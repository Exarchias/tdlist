/*
 * ContextFolderModel.h
 *
 *  Created on: Nov 14, 2013
 *      Author: khajvah
 */

#ifndef CONTEXTFOLDERMODEL_H_
#define CONTEXTFOLDERMODEL_H_

#include <bb/cascades/GroupDataModel>
#include "GroupModifier.h"

class ContextFolderModel: public bb::cascades::GroupDataModel
{
	Q_OBJECT

public:
	ContextFolderModel();
	virtual ~ContextFolderModel();

	Q_INVOKABLE QString getFolderName (int id);
	Q_INVOKABLE void addNewFolderByType (QString name, QString type);
	Q_INVOKABLE ContextFolderModel* get();
	Q_INVOKABLE bool getDateToFinish (int Id);
	Q_INVOKABLE bool getPrice(int Id);
	Q_INVOKABLE bool getQuantity(int Id);
	Q_INVOKABLE bool getTags(int Id);
	Q_INVOKABLE bool getDateCreated(int id);
public slots:
	void onNewFolderAdded (QVariantMap);

private:
	GroupModifier* m_mainModel;
};

#endif /* CONTEXTFOLDERMODEL_H_ */
