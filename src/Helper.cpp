/*
 * Helper.cpp
 *
 *  Created on: Oct 30, 2013
 *      Author: khajvah
 */

#include "Helper.h"
#include <QDateTime>
#include <stdlib.h> //atoi
#include <cstring>
#include <string>

Helper::Helper() {

}

QString Helper::convertUTtoString(int unixTime) {

	//Int converted = atoi((const char*)(unixTime.toUtf8().constData()));
	return QString::number(unixTime);
	/*
	QDateTime timestamp;
	timestamp.setTime_t(converted);
	return timestamp.toString();
*/}

void Helper::setclickedTaskId (int id) {

	clickedTaskId = id;

}

int Helper::getclickedTaskId () {

	return clickedTaskId;

}
