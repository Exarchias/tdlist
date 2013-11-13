/*
 * ListModel.cpp
 *
 *  Created on: Oct 28, 2013
 *      Author: khajvah
 */

#include "listModel.h"
#include <QDebug>
#include <QFile>

#include "NotificationManager.h"

using namespace bb::cascades;

ListModel* ListModel::m_instance = NULL;

ListModel* ListModel::Instance() {
	if (!m_instance)
		m_instance = new ListModel;

	return m_instance;
}

ListModel::ListModel()
{

	QStringList keyList;
	keyList << "Status" << "DateCreated";

	jda = new bb::data::JsonDataAccess;

	QVariant folderList = jda->load(QDir::currentPath() +
			"/app/native/assets/folders.json");

	m_folderList = folderList.value<QVariantList>();

	QVariant list = jda->load(QDir::currentPath() +
			"/app/native/assets/test.json");

	m_fullDataList = list.value<QVariantList>();
}
QVariantList ListModel::getData() const {
	return m_fullDataList;
}

QString ListModel::getDesctiption (int id) {

	for (int i = 0; i < m_fullDataList.size(); i++) {
		if (m_fullDataList.at(i).toMap()["DateCreated"].toInt() == id) {
			return m_fullDataList.at(i).toMap()["Description"].toString();
		}
	}

}

QString ListModel::getDatetoFinish(int id) {

	for (int i = 0; i < m_fullDataList.size(); i++) {
		if (m_fullDataList.at(i).toMap()["DateCreated"].toInt() == id) {
			return m_fullDataList.at(i).toMap()["DateToFinish"].toString();
		}
	}
}

int ListModel::getStatus (int id) {

	for (int i = 0; i < m_fullDataList.size(); i++) {
		if (m_fullDataList.at(i).toMap()["DateCreated"].toInt() == id) {
			return m_fullDataList.at(i).toMap()["Status"].toInt();
		}
	}

}

int ListModel::addNewTask(int folder, QString description, QDateTime dateToFinish, int isReminded) {
	//Creating the new task
	QVariantMap newTask;
	//newTask["taskId"] = QString::number(lastId+1);
	newTask["Remind"] = isReminded;
	newTask["Description"] = description;
	newTask["Status"] = QString::number(2);
	newTask["DateToFinish"] = dateToFinish.toTime_t();
	newTask["DateCreated"] = QDateTime::currentDateTime().toTime_t();
	newTask["Folder"] = folder;
	//Insert before writing to Json
	//To be able to write Json file


	//this->insert(newTask);

	m_fullDataList << newTask;

	QVariant entireData = (QVariant)m_fullDataList;

	//Save Json file
	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");
	if (!jda->hasError()) {
		emit newTaskAdded(newTask);
	}else {
	}

	return 0;

}

int ListModel::removeTask (int dateCreated) {
	//Finding and removing from the Model
	for (unsigned i = 0; i < m_fullDataList.size(); i++) {
		if (m_fullDataList.at(i).toMap()["DateCreated"].toInt() == dateCreated) {
			m_fullDataList.removeAt(i);
		}
	}

	QVariant entireData = (QVariant)m_fullDataList;

	//Saving the Json file
	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");
	if (!jda->hasError()) {
		emit taskRemoved(dateCreated);
	}

	return 0;

}

int ListModel::removeTask (std::vector<int> datesCreated) {

	//TODO removeTask (std:;vector) implementation
	//	//Finding and removing from the Model
	//	QVariantList entireDataList;
	//	for (QVariantList it = this->first(); it != this->last(); it = this->after(it)) {
	//		for (unsigned int i = 0; i < datesCreated.size(); i++) {
	//			if (this->data(it).toMap()["DateCreated"].toInt() == datesCreated[i]) {
	//				this->removeAt(it);
	//			}
	//		}
	//
	//		entireDataList << this->data(it);
	//	}
	//	QVariant entireData = (QVariant)entireDataList;
	//
	//	//Saving the Json file
	//	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");
	//	if (!jda->hasError()) {
	//
	//		emit tasksRemoved(datesCreated);
	//
	//	}

	return 0;
}

int ListModel::changeStat (int dateCreated, QString taskStatus) {
	QVariantMap updatedData;
	for (unsigned i = 0; i < m_fullDataList.size(); i++) {
		if (m_fullDataList.at(i).toMap()["DateCreated"].toInt() == dateCreated) {
			updatedData = m_fullDataList.at(i).toMap();
			updatedData["Status"] = taskStatus;
			QVariant variantfromMap(updatedData);
			m_fullDataList.replace(i, variantfromMap);
		}
	}


	QVariant entireData = (QVariant)m_fullDataList;

	//Saving the Json file
	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");

	if (!jda->hasError()) {
		emit statusChanged(dateCreated, taskStatus);
	}

	return 0;
}

bool ListModel::isReminded (int taskID) {

	for (unsigned i = 0; i < m_fullDataList.size(); i++) {
		if (m_fullDataList.at(i).toMap()["Remind"] == 0)
			return true;
		else
			return false;
	}

}

int ListModel::replaceEntry (int taskID, QString newDescription, QDateTime newDateToFinish, int newisReminded) {

	QVariantMap updatedData;
	updatedData["Remind"] = (newisReminded == 0) ? false : true;
	updatedData["Description"] = newDescription;
	updatedData["DateToFinish"] = newDateToFinish.toTime_t();

	for (unsigned i = 0; i < m_fullDataList.size(); i++) {
		if (m_fullDataList.at(i).toMap()["DateCreated"].toInt() == taskID) {
			updatedData["DateCreated"] = m_fullDataList.at(i).toMap()["DateCreated"];
			updatedData["Status"] = m_fullDataList.at(i).toMap()["Status"].toInt();
			QVariant dataFromMap(updatedData);
			m_fullDataList.replace(i, dataFromMap);
		}
	}

	QVariant entireData = (QVariant)m_fullDataList;

	//Saving the Json file
	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");

	if (!jda->hasError()) {
		emit entryReplaced(taskID, updatedData);
	}
	return 0;
}

void ListModel::addNewFolder (QString fName) {
	QVariantMap newItem;
	newItem["FolderName"] = fName;
	newItem["Id"] = QDateTime::currentDateTime().toTime_t();
	m_folderList << newItem;
	jda->save((QVariant)m_folderList, QDir::currentPath() +
			"/app/native/assets/folders.json");
	emit folderAdded (newItem);
}

void ListModel::deleteFolder(QString fName) {
	QVariantList::iterator it = m_folderList.begin();
	for (int i = 0; i < m_folderList.size(); i++) {
		if (*it == fName){
			m_folderList.erase(it);
			break;
		}
		it++;
	}
	jda->save((QVariant)m_folderList, QDir::currentPath() +
			"/app/native/assets/folders.json");
	emit folderDeleted (fName);
}

QVariantList ListModel::getFolderList () {
	return m_folderList;
}
