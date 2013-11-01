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

enum taskStatus {Finished = 0, inProgress, withdrow};

class ListModel : public bb::cascades::GroupDataModel
{

Q_OBJECT
public:
	ListModel();

	Q_INVOKABLE int addNewTask (QString description, QDateTime dateToFinish);

	//Remove one or multiple tasks at once
	Q_INVOKABLE int removeTask (int dateCreated);
	Q_INVOKABLE int removeTask (std::vector<int> datesCreated);

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


};

#endif /* LISTMODEL_HPP_ */
