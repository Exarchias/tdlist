/*
 * ListModel.cpp
 *
 *  Created on: Oct 28, 2013
 *      Author: khajvah
 */

#include "listModel.h"
#include <QDebug>

using namespace bb::cascades;


ListModel::ListModel()
{

	QStringList keyList;
	keyList << "Status" << "DateCreated";

	this->setSortingKeys(keyList);

	//this->sortingKeys() << "Status" << "DateCreated";

	jda = new bb::data::JsonDataAccess;
	QVariant list = jda->load(QDir::currentPath() +
			"/app/native/assets/test.json");


	this->insertList(list.value<QVariantList>());
	this->setSortedAscending(true);

}


ListModel* ListModel::get() {

	return this;

}

QString ListModel::getDesctiption (int id) {
	for (QVariantList it = this->first(); it != this->last(); it = this->after(it)) {
		if (this->data(it).toMap()["DateCreated"].toInt() == id)
			return this->data(it).toMap()["Description"].toString();
	}
	//Loop does not check the last item, so if it ends, the last element is what we are looking for
	return this->data(this->last()).toMap()["Description"].toString();
}

QString ListModel::getDatetoFinish(int id) {
	for (QVariantList it = this->first(); it != this->last(); it = this->after(it)) {
		if (this->data(it).toMap()["DateCreated"].toInt() == id)
			return this->data(it).toMap()["DateToFinish"].toString();
	}
	//Loop does not check the last item, so if it ends, the last element is what we are looking for
	return this->data(this->last()).toMap()["DateToFinish"].toString();
}

int ListModel::getStatus (int id) {

	for (QVariantList it = this->first(); it != this->last(); it = this->after(it)) {
			if (this->data(it).toMap()["DateCreated"].toInt() == id)
				return this->data(it).toMap()["Status"].toInt();
		}
		//Loop does not check the last item, so if it ends, the last element is what we are looking for
		return this->data(this->last()).toMap()["Status"].toInt();

}

int ListModel::addNewTask(QString description, QDateTime dateToFinish) {
	/*	I don't use ID any more, as DateCreated is unique for every task
	//Getting the the ID of last task
	QVariantList lastItemPath = this->first();
	QVariant last = this->data(lastItemPath);
	QVariantMap map = last.toMap();
	int lastId = map["taskId"].toInt();
	 */
	//Creating the new task
	QVariantMap newTask;
	//newTask["taskId"] = QString::number(lastId+1);
	newTask["Description"] = description;
	newTask["Status"] = QString::number(1);
	newTask["DateToFinish"] = QString::number(dateToFinish.toTime_t());
	newTask["DateCreated"] = QDateTime::currentDateTime().toTime_t();
	//Insert before writing to Json
	//To be able to write Json file
	this->insert(newTask);

	//Gluing all tasks together
	QVariantList entireDataList;
	for (QVariantList it = this->first(); it != this->last(); it = this->after(it)) {
		entireDataList << this->data(it);
	}
	entireDataList << this->data(this->last());
	QVariant entireData = (QVariant)entireDataList;

	//Save Json file
	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");
	if (!jda->hasError()) {
		emit newTaskAdded();
	}else {
		//Remove the problematic task from model if there is a problem in writing to json
		this->remove(newTask);
	}

	return 0;

}

int ListModel::removeTask (int dateCreated) {
	//Finding and removing from the Model
	QVariantList entireDataList;

	QVariantList it = this->first();
	for (unsigned int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["DateCreated"].toInt() == dateCreated) {
			this->removeAt(it);
		} else {
			entireDataList << this->data(it);
		}

		it = this->after(it);
	}

	QVariant entireData = (QVariant)entireDataList;

	//Saving the Json file
	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");
	if (!jda->hasError()) {
		emit taskRemoved(dateCreated);
	}

	return 0;

}

int ListModel::removeTask (std::vector<int> datesCreated) {

	//TODO Fix removeTask(std::vector...) function. THIS STILL DOES NOT WORK
	//Finding and removing from the Model
	QVariantList entireDataList;
	for (QVariantList it = this->first(); it != this->last(); it = this->after(it)) {
		for (unsigned int i = 0; i < datesCreated.size(); i++) {
			if (this->data(it).toMap()["DateCreated"].toInt() == datesCreated[i]) {
				this->removeAt(it);
			}
		}

		entireDataList << this->data(it);
	}
	QVariant entireData = (QVariant)entireDataList;

	//Saving the Json file
	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");
	if (!jda->hasError()) {

		emit tasksRemoved(datesCreated);

	}

	return 0;
}

int ListModel::changeStat (int dateCreated, int taskStatus) {

	QVariantList entireDataList;
	QVariantMap updatedData;
	QVariantList it = this->first();
	for (unsigned int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["DateCreated"].toString() == QString::number(dateCreated)) {
			updatedData = this->data(it).toMap();
			updatedData["Status"] = QString::number(taskStatus);
			this->updateItem(it, updatedData);
		}

		entireDataList << this->data(it);
		it = this->after(it);
	}

//	QVariantList entireDataList;
//	for (QVariantList it = this->first(); it != this->last(); it = this->after(it)) {
//		if (this->data(it).toMap()["DateCreated"].toInt() == dateCreated) {
//			if (taskStatus < 0 || taskStatus > 3) {
//				qDebug() << "Internal Error";
//				break;
//			}
//
//			this->data(it).toMap()["Status"] = QString::number(taskStatus);
//
//		}
//
//		entireDataList << this->data(it);
//	}
	QVariant entireData = (QVariant)entireDataList;

	//Saving the Json file
	jda->save(entireData, QDir::currentPath() + "/app/native/assets/test.json");

	if (!jda->hasError()) {
		emit statusChanged(dateCreated, taskStatus);
	}

	return 0;

}
