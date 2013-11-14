/*
 * GroupModifier.cpp
 *
 *  Created on: Nov 14, 2013
 *      Author: khajvah
 */

#include "GroupModifier.h"
#include <QDir>
#include <QDateTime>


GroupModifier* GroupModifier::m_groupmod = NULL;

GroupModifier* GroupModifier::Instance() {
	if (!m_groupmod)
		m_groupmod = new GroupModifier;

	return m_groupmod;
}


GroupModifier::GroupModifier() {
	jda = new bb::data::JsonDataAccess;

	QVariant folderList = jda->load(QDir::currentPath() +
			"/app/native/assets/folders.json");

	m_folderList = folderList.value<QVariantList>();

}

GroupModifier::~GroupModifier() {
	// TODO Auto-generated destructor stub
}

void GroupModifier::addNewFolder (QString fName,
		bool dateCreated,
		bool dateToFinish,
		bool price,
		bool quantity,
		bool tags) {

	QVariantMap newItem;
	newItem["FolderName"] = fName;
	newItem["DateToFinish"] = (dateToFinish == true) ? 1 : 0;
	newItem["Price"] = (price == true) ? 1 : 0;
	newItem["DateCreated"] = (dateCreated == true) ? 1 : 0;
	newItem["Quantity"] = (quantity == true) ? 1 : 0;
	newItem["Tags"] = tags;
	newItem["Id"] = QDateTime::currentDateTime().toTime_t();
	m_folderList << newItem;
	jda->save((QVariant)m_folderList, QDir::currentPath() +
			"/app/native/assets/folders.json");
	emit folderAdded (newItem);
}

void GroupModifier::deleteFolder(QString fName) {
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

QVariantList GroupModifier::getFolderList () {
	return m_folderList;
}
