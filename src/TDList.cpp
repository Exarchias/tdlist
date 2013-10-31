#include "TDList.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

#include "listModel.h"
#include "Helper.h"

using namespace bb::cascades;

TDList::TDList(bb::cascades::Application *app) :
        QObject(app)
{
    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    mainModel = new ListModel();

    Helper* help = new Helper();

    qml->setContextProperty("Model" , mainModel);
    qml->setContextProperty("CppHelper", help);
    qml->setContextProperty("context", this);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);
}
