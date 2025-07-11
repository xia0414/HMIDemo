#ifndef DEF_H
#define DEF_H
#include <QObject>
#include <QtQml/qqml.h>
namespace FluThemeType {
    Q_NAMESPACE
    enum DarkMode {
        System = 0x0000,
        Light = 0x0001,
        Dark = 0x0002,
    };
    Q_ENUM_NS(DarkMode)

}
#endif // DEF_H
