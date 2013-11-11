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
	//TODO converts unix timestamp to human readable time
	return "";
}

void Helper::setclickedTaskId (int id) {

	clickedTaskId = id;

}

int Helper::getclickedTaskId () const {

	return clickedTaskId;

}

int Helper::getClickedFolderName () const{
	return m_clickedFolderName;
}

void Helper::setClickedFolderName (int newfolderName) {
	m_clickedFolderName = newfolderName;
}
