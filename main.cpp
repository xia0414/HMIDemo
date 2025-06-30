#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QQuickStyle>
#include <qrencode.h>
#include "qrcodegenerate.h"
#include <QApplication>
#include <QWindow>
#include <QQmlContext>
//#include <QWidgetContainer>
int main(int argc, char *argv[])
{
#ifdef N
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //QQuickStyle::setStyle("Fusion");

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

    QRCodeGenerate *qrc = new QRCodeGenerate();
    //QWidgetContainer *container = QWidgetContainer::createWindowContainer(myWidget, qmlEngine(this));
    //widgetWindow->setFlags(Qt::FramelessWindowHint);
    //qmlRegisterType<QRCodeGenerate>("QRCodeGenerate", 1, 0, "QRCodeGenerate");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

        //engine.rootContext()->setContextProperty("qrcg",qrc);
      engine.addImageProvider("myprovider", new MyImageProvider());

#endif

    engine.load(url);

    return app.exec();
}
