/*
 * NotificationManager.h
 *
 *  Created on: Nov 5, 2013
 *      Author: khajvah
 */

#ifndef NOTIFICATIONMANAGER_H_
#define NOTIFICATIONMANAGER_H_

#include <qobject.h>
#include <set>

#include "listModel.h"

class NotificationManager: public QObject {

	Q_OBJECT

public:
	NotificationManager(std::set<int>* dates, ListModel* dataModel);
	virtual ~NotificationManager();

private:
	ListModel* m_dataModel;
	std::set<int>* m_setOfDatesToNotify;
};

#endif /* NOTIFICATIONMANAGER_H_ */
