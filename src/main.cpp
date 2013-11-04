#include <bb/cascades/Application>

#include <QLocale>
#include <QTranslator>
#include "TDList.hpp"
#include <QTimer>

#include <Qt/qdeclarativedebug.h>

#include "listModel.h"
#include "Helper.h"
using namespace bb::cascades;

Q_DECL_EXPORT int main(int argc, char **argv)
{
    Application app(argc, argv);

    qmlRegisterType<ListModel>("list", 1, 0, "lModel");
    qmlRegisterType<Helper>("cpphelper", 1, 0, "Cpphelper");
    qmlRegisterType<QTimer>("bb.cascades", 1, 0, "QTimer");
    // Create the Application UI object, this is where the main.qml file
    // is loaded and the application scene is set.
    new TDList(&app);

    // Enter the application main event loop.
    return Application::exec();
}
