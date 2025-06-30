#ifndef QRCODEGENERATE_H
#define QRCODEGENERATE_H

#include <QObject>
#include <QWidget>
#include <QWindow>
#include <QQuickImageProvider>

class QRCodeGenerate : public QObject
{
    Q_OBJECT
public:
    explicit QRCodeGenerate(QObject *parent = nullptr);

    Q_INVOKABLE QImage createQRImage(const QString& text, int size);

signals:

};


class MyImageProvider : public QQuickImageProvider {
public:
    MyImageProvider() : QQuickImageProvider(QQuickImageProvider::Image) {}

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override
    {
        // 这里返回你的 QImage（示例：生成一个红色矩形）
        QRCodeGenerate* qrc = new QRCodeGenerate();

        return qrc->createQRImage("hello_world",200);
    }
};



#endif // QRCODEGENERATE_H
