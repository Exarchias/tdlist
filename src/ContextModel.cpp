/*
 * ContexModel.cpp
 *
 *  Created on: Nov 7, 2013
 *      Author: khajvah
 */

#include "ContextModel.h"


ContextModel::ContextModel() {
	// TODO Auto-generated constructor stub
	m_mainModel = ListModel::Instance();

	QStringList keyList;
	keyList << "Status" << "DateCreated";

	this->setSortingKeys(keyList);
	this->setSortedAscending(false);

	connect (m_mainModel, SIGNAL(newTaskAdded(QVariantMap)), this, SLOT(onNewTaskAdded(QVariantMap)));
	connect (m_mainModel, SIGNAL(taskRemoved(int)), this, SLOT(onTaskRemoved(int)));
	connect (m_mainModel, SIGNAL(statusChanged(int,int)), this, SLOT(onStatusChanged(int,int)));
	connect (m_mainModel, SIGNAL(entryReplaced(int,QVariantMap)), this, SLOT(onEntryReplaced(int, QVariantMap)));
}

ContextModel::~ContextModel() {
	// TODO Auto-generated destructor stub
}

QString ContextModel::folder() {
	return m_folderName;
}

void ContextModel::setFolder(QString FolderName) {
	m_folderName = FolderName;
}

void ContextModel::fillEntire () {
	QVariantList it = m_mainModel->first();
	for (unsigned int i = 0; i < m_mainModel->size(); i++) {
		this->insert(m_mainModel->data(it).toMap());
		it = m_mainModel->after(it);
	}
}

void ContextModel::fillByFolderName () {
	QVariantList it = m_mainModel->first();
	for (unsigned int i = 0; i < m_mainModel->size(); i++) {
		if (m_mainModel->data(it).toMap()["Folder"] == m_folderName) {
			this->insert(m_mainModel->data(it).toMap());
		}

		it = m_mainModel->after(it);
	}
}


int ContextModel::addNewTask (QString description, QDateTime dateToFinish, int isReminded) {

	return m_mainModel->addNewTask(m_folderName, description, dateToFinish, isReminded);

}

int ContextModel::removeTask (int dateCreated) {
	return m_mainModel->removeTask(dateCreated);
}

bool ContextModel::isReminded (int taskID) {
	return m_mainModel->isReminded(taskID);
}

int ContextModel::replaceEntry (int taskID, QString newDescription, QDateTime newDateToFinish, int newisReminded) {
	return m_mainModel->replaceEntry(taskID, newDescription, newDateToFinish, newisReminded);
}

int ContextModel::changeStat (int dateCreated, int taskStatus) {
	return m_mainModel->changeStat(dateCreated, taskStatus);
}

QString ContextModel::getDesctiption(int id) {
	return m_mainModel->getDesctiption(id);
}

QString ContextModel::getDatetoFinish(int id) {
	return m_mainModel->getDatetoFinish(id);
}

int ContextModel::getStatus (int id) {
	return m_mainModel->getStatus(id);
}

void ContextModel::onNewTaskAdded (QVariantMap newtask) {
	this->insert(newtask);
}

void ContextModel::onTaskRemoved (int id) {
	QVariantList it = this->first();
	for (unsigned int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["DateCreated"].toInt() == id) {
			this->removeAt(it);
			return;
		}
		it = this->after(it);
	}
}

void ContextModel::onStatusChanged (int id, int newStatus) {
	QVariantMap updatedData;
	QVariantList it = this->first();
	for (unsigned int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["DateCreated"] == id) {
			updatedData = this->data(it).toMap();
			updatedData["Status"] = QString::number(newStatus);
			this->updateItem(it, updatedData);
			break;
		}
		it = this->after(it);
	}
}

void ContextModel::onEntryReplaced (int id, QVariantMap newEntry) {
	QVariantList it = this->first();
	for (unsigned int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["DateCreated"].toInt() == id) {
			this->updateItem(it, newEntry);
			break;
		}
		it = this->after(it);
	}
}
