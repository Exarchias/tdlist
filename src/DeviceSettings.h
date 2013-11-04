/*
 * DeviceSettings.h
 *
 *  Created on: Nov 4, 2013
 *      Author: khajvah
 */

#ifndef DEVICESETTINGS_H_
#define DEVICESETTINGS_H_

#include <QObject>

class DeviceSettings : public QObject {

Q_OBJECT

public:
	DeviceSettings(QObject* parent = 0);
	virtual ~DeviceSettings();

	//1 for Z10, 2 for Q10, 3 for Z30
	Q_INVOKABLE int getDevice() const;
	Q_INVOKABLE QString modelName() const;
};

#endif /* DEVICESETTINGS_H_ */
