#include "TDList.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

#include "listModel.h"
#include "Helper.h"
#include "DeviceSettings.h"

using namespace bb::cascades;

TDList::TDList(bb::cascades::Application *app) :
        QObject(app)
{
    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    mainModel = new ContextModel();
    Helper* Help = new Helper();
    DeviceSettings* device = new DeviceSettings();

    qml->setContextProperty("Model" , mainModel);
    qml->setContextProperty("CppHelper", Help);
    qml->setContextProperty("context", this);
    qml->setContextProperty("Device", device);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);
}
