/*
 * ContextFolderModel.cpp
 *
 *  Created on: Nov 14, 2013
 *      Author: khajvah
 */

#include "ContextFolderModel.h"
#include "GroupModifier.h"

ContextFolderModel::ContextFolderModel() {
	m_mainModel = GroupModifier::Instance();

	this->insertList(m_mainModel->getFolderList());
	//Sort in Ascending order when folders are data
	this->setSortedAscending(true);

	connect (m_mainModel, SIGNAL(folderAdded(QVariantMap)), this, SLOT (onNewFolderAdded(QVariantMap)));
}

ContextFolderModel::~ContextFolderModel() {
	// TODO Auto-generated destructor stub
}

QString ContextFolderModel::getFolderName (int id) {
	for (unsigned int i = 0; i < m_mainModel->getFolderList().size(); i++) {
		if (m_mainModel->getFolderList().at(i).toMap()["Id"].toInt() == id) {
			return m_mainModel->getFolderList().at(i).toMap()["FolderName"].toString();
		}
	}
}

ContextFolderModel* ContextFolderModel::get()
{
	return this;
}

void ContextFolderModel::onNewFolderAdded(QVariantMap newFolder) {
	this->insert(newFolder);
}

void ContextFolderModel::addNewFolderByType (QString name, QString type) {
	if (type == "Simple")
		m_mainModel->addNewFolder(name, true, true, false, false, true);
	else if (type == "Shopping List")
		m_mainModel->addNewFolder(name, false, false, true, true, true);
	else if (type == "Task List")
		m_mainModel->addNewFolder(name, false, true, false, false, true);
}

bool ContextFolderModel::getDateToFinish(int Id) {
	QVariantList it = this->first();
	for (int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["Id"].toInt() == Id)
			return (this->data(it).toMap()["DateToFinish"].toInt() == 0) ? false : true;

		it = this->after(it);
	}
}

bool ContextFolderModel::getPrice (int Id) {
	QVariantList it = this->first();
	for (int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["Id"].toInt() == Id)
			return (this->data(it).toMap()["Price"].toInt() == 0) ? false : true;

		it = this->after(it);
	}
}

bool ContextFolderModel::getQuantity (int Id) {
	QVariantList it = this->first();
	for (int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["Id"].toInt() == Id)
			return (this->data(it).toMap()["Quantity"].toInt() == 0) ? false : true;

		it = this->after(it);
	}
}

bool ContextFolderModel::getTags (int Id) {
	QVariantList it = this->first();
	for (int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["Id"].toInt() == Id)
			return this->data(it).toMap()["Tags"].toBool();

		it = this->after(it);
	}
}

bool ContextFolderModel::getDateCreated (int Id) {
	QVariantList it = this->first();
	for (int i = 0; i < this->size(); i++) {
		if (this->data(it).toMap()["Id"].toInt() == Id)
			return (this->data(it).toMap()["DateCreated"].toInt() == 0) ? false : true;

		it = this->after(it);
	}
}


