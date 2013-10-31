#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include <QObject>

#include "listModel.h"

namespace bb
{
    namespace cascades
    {
        class Application;
        class LocaleHandler;
    }
}

class QTranslator;

/*!
 * @brief Application object
 *
 *
 */

class TDList : public QObject
{
    Q_OBJECT
public:
    TDList(bb::cascades::Application *app);
    virtual ~TDList() { }
private slots:

private:

private:
	ListModel* mainModel;
};

#endif /* ApplicationUI_HPP_ */
