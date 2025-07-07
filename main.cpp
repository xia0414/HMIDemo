#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QQuickStyle>
#include "qrencode/qrencode.h"
#include "qrcodegenerate.h"
#include <QApplication>
#include <QWindow>
#include <QQmlContext>
#include <QTimer>
//#include <QWidgetContainer>
int main(int argc, char *argv[])
{
#ifdef N
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
#endif

#ifndef N
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

    //QQuickStyle::setStyle("Material");


    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
     QRCodeGenerate *qrc = new QRCodeGenerate();
     MyImageProvider* imgProvider = new MyImageProvider();
     imgProvider->setQRCodeGenerate(qrc);
     imgProvider->setQRString("hello_world");
     engine.addImageProvider("myprovider",imgProvider);
     engine.rootContext()->setContextProperty("qrc",qrc);

     QTimer::singleShot(2000, [&](){
         qDebug() << "This message appears after 1 second";
         imgProvider->setQRString("hello_world2");
         qrc->doimgUpdate();
     });


#endif

    engine.load(url);

    return app.exec();
}
