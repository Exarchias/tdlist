/*
 * DeviceSettings.cpp
 *
 *  Created on: Nov 4, 2013
 *      Author: khajvah
 */

#include "DeviceSettings.h"
#include <bb/device/HardwareInfo>

using namespace bb::device;

DeviceSettings::DeviceSettings(QObject* parent) : QObject(parent) {

}

DeviceSettings::~DeviceSettings() {
}


//1 for z10, 2 for q10, 3 for z30
int DeviceSettings::getDevice () const {
	HardwareInfo info;

	//Dev Alpha that I am using returns "Unknown" modelName.
	if (info.modelName() == "Unknown" || info.modelName() == "Z10")
		return 1;
	else if (info.modelName() == "Q10")
		return 2;
	else
		return 3;
}


QString DeviceSettings::modelName() const {
	HardwareInfo info;

	return info.modelName();

}
