/*
 * listModel.hpp
 *
 *  Created on: Oct 28, 2013
 *      Author: khajvah
 */
#ifndef LISTMODEL_HPP_
#define LISTMODEL_HPP_

#include <bb/cascades/GroupDataModel>
#include <bb/data/JsonDataAccess>
#include <vector>
#include <set>

enum taskStatus {inProgress = 0, Finished, withdrow};

class ListModel : public QObject
{

Q_OBJECT
public:
	ListModel();

	//IsReminded- 0 for false, 1 for true
	int addNewTask (int folder, QString description, QDateTime dateToFinish, int isReminded,
			int quantity, int price, QStringList* taglist);

	//Remove one or multiple tasks at once
	int removeTask (int dateCreated);
	int removeTask (std::vector<int> datesCreated);

	bool isReminded (int taskID);

	int replaceEntry (int taskID, QString newDescription, QDateTime newDateToFinish, int newisReminded);

	//Change statuses of one or multiple tasks' at once
	int changeStat (int dateCreated, QString taskStatus);

	QString getDesctiption(int id);
	QString getDatetoFinish(int id);
	int getStatus (int id);

	void addNewFolder (QString fName, QString type);
	void deleteFolder (QString fName);
	QVariantList getFolderList ();

	QVariantList getData() const;

	static ListModel* Instance();

signals:
	void newTaskAdded (QVariantMap);
	void taskRemoved(int dateCreated);
	void tasksRemoved(std::vector<int> datesCreated);
	void statusChanged (int dateCreated, QString newStatus);
	void entryReplaced (int id, QVariantMap newEntry);

	void folderAdded (QVariantMap);
	void folderDeleted (QString);


private:
	bb::data::JsonDataAccess* jda;

private:
	QVariantList m_folderList;
	QVariantList m_fullDataList;

private:
	static ListModel* m_instance;

};

#endif /* LISTMODEL_HPP_ */
