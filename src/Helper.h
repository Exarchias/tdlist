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
	Q_INVOKABLE int getclickedTaskId () const;

	//Returns folder id. In first version, it returned its name
	Q_INVOKABLE int getClickedFolderName () const;
	Q_INVOKABLE void setClickedFolderName (int newfolderName);

signals:
	void waitPassed();

private:
	int clickedTaskId;
	int m_clickedFolderName;
};


#endif /* HELPER_H_ */
