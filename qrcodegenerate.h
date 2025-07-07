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
    void doimgUpdate();
signals:
    void imgUpdate();
};

class MyImageProvider : public QQuickImageProvider{
public:
    MyImageProvider() : QQuickImageProvider(QQuickImageProvider::Image) {}

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override
    {
        return m_qrc->createQRImage(m_qrstring,200);
    }
    void setQRString(QString str)
    {
        m_qrstring = str;
    }
    void setQRCodeGenerate(QRCodeGenerate* qrc)
    {
        m_qrc = qrc;
    }
private:
    QString m_qrstring;
    QRCodeGenerate* m_qrc;
signals:
};






#endif // QRCODEGENERATE_H
