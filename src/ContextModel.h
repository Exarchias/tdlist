/*
 * ContexModel.h
 *
 *  Created on: Nov 7, 2013
 *      Author: khajvah
 */

#ifndef CONTEXMODEL_H_
#define CONTEXMODEL_H_

#include <QObject>
#include <bb/cascades/GroupDataModel>

#include "listModel.h"

class ContextModel: public bb::cascades::GroupDataModel {

	Q_OBJECT

	Q_PROPERTY(int folder READ folder WRITE setFolder)

public:
	ContextModel();
	virtual ~ContextModel();

	int folder();
	void setFolder(int FolderName);

	Q_INVOKABLE int addNewTask (int folderName, QString description, QDateTime dateToFinish, int isReminded);
	Q_INVOKABLE int removeTask (int dateCreated);
	Q_INVOKABLE bool isReminded (int taskID);
	Q_INVOKABLE int replaceEntry (int taskID, QString newDescription, QDateTime newDateToFinish, int newisReminded);
	Q_INVOKABLE int changeStat (int dateCreated, int taskStatus);

	Q_INVOKABLE QString getDesctiption(int id);
	Q_INVOKABLE QString getDatetoFinish(int id);
	Q_INVOKABLE int getStatus (int id);
	Q_INVOKABLE QString getFolderName (int id);

	Q_INVOKABLE void addNewFolder (QString name);

	Q_INVOKABLE void fillByFolderId (int);
	Q_INVOKABLE void fillEntire();
	Q_INVOKABLE void fillFolderList ();

private slots:
	void onNewTaskAdded(QVariantMap newTask);
	void onTaskRemoved (int Id);
	void onStatusChanged(int, int);
	void onEntryReplaced (int, QVariantMap);
	void onNewFolderAdded (QVariantMap);

private:
	ListModel* m_mainModel;
	int m_folderName;

private:
	//Whether it is displaying folders or actual data. 0 for folders, 1 for entries
	int m_dataMode;



};

#endif /* CONTEXMODEL_H_ */
