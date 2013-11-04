/*
 * Helper.h
 *gme
 *  Created on: Oct 30, 2013
 *      Author: khajvah
 */

#ifndef HELPER_H_
#define HELPER_H_

#include <QObject>

class Helper : public QObject
{
	Q_OBJECT

public:
	Helper();

	Q_INVOKABLE QString convertUTtoString(int unixTime);
	Q_INVOKABLE void setclickedTaskId (int id);
	Q_INVOKABLE int getclickedTaskId ();
	Q_INVOKABLE void wait(int seconds);

signals:
	void waitPassed();

private:
	int clickedTaskId;
};


#endif /* HELPER_H_ */
