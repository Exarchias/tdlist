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

class ListModel : public bb::cascades::GroupDataModel
{

Q_OBJECT
public:
	ListModel();

	//IsReminded- 0 for false, 1 for true
	Q_INVOKABLE int addNewTask (QString description, QDateTime dateToFinish, int isReminded);

	//Remove one or multiple tasks at once
	Q_INVOKABLE int removeTask (int dateCreated);
	Q_INVOKABLE int removeTask (std::vector<int> datesCreated);

	Q_INVOKABLE bool isReminded (int taskID);

	Q_INVOKABLE int replaceEntry (int taskID, QString newDescription, QDateTime newDateToFinish, int newisReminded);

	//Change statuses of one or multiple tasks' at once
	Q_INVOKABLE int changeStat (int dateCreated, int taskStatus);

	Q_INVOKABLE QString getDesctiption(int id);
	Q_INVOKABLE QString getDatetoFinish(int id);
	Q_INVOKABLE int getStatus (int id);

	Q_INVOKABLE ListModel* get();

signals:
	void newTaskAdded ();
	void taskRemoved(int dateCreated);
	void tasksRemoved(std::vector<int> datesCreated);
	void statusChanged (int dateCreated, int newStatus);


private:
	bb::data::JsonDataAccess* jda;

private:
	std::set<int> m_setOfDates;

};

#endif /* LISTMODEL_HPP_ */
