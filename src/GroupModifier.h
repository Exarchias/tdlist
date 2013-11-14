/*
 * GroupModifier.h
 *
 *  Created on: Nov 14, 2013
 *      Author: khajvah
 */

#ifndef GROUPMODIFIER_H_
#define GROUPMODIFIER_H_

#include <QObject>
#include <QVariantList>
#include <bb/data/JsonDataAccess>

class GroupModifier : public QObject {
	Q_OBJECT

public:
	GroupModifier();
	virtual ~GroupModifier();

	void addNewFolder (QString fName, bool dateCreated,
			bool dateToFinish,
			bool price,
			bool quantity,
			bool tags);

	void deleteFolder (QString fName);
	QVariantList getFolderList ();

	static GroupModifier* Instance();

signals:
	void folderAdded (QVariantMap);
	void folderDeleted (QString);


private:
	static GroupModifier* m_groupmod;
	QVariantList m_folderList;

private:
	bb::data::JsonDataAccess* jda;

};

#endif /* GROUPMODIFIER_H_ */
