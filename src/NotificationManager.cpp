/*
 * NotificationManager.cpp
 *
 *  Created on: Nov 5, 2013
 *      Author: khajvah
 */

#include "NotificationManager.h"
#include <QDateTime>
#include <bb/platform/Notification>


NotificationManager::NotificationManager(std::set<int>* dates, ListModel* dataModel)
:	m_dataModel(dataModel),
 	m_setOfDatesToNotify(dates)
{

	m_dataModel = dataModel;
	m_setOfDatesToNotify = dates;

}

NotificationManager::~NotificationManager() {
	// TODO Auto-generated destructor stub
}
