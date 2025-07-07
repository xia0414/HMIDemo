#include "qrcodegenerate.h"
#include "qrencode/qrencode.h"
#include <QLabel>
#include <QBoxLayout>

QRCodeGenerate::QRCodeGenerate(QObject *parent) : QObject(parent)
{

}

 QImage QRCodeGenerate::createQRImage(const QString &text, int size)
{
    QRcode* qr = QRcode_encodeString(text.toUtf8(), 0, QR_ECLEVEL_L, QR_MODE_8, 1);
        if(!qr) return QImage();
        const int margin = 0;
        const int totalSize = qr->width + margin * 2;
        QImage img(totalSize, totalSize, QImage::Format_Mono);
        img.fill(1);

        for(int y = 0; y < qr->width; y++) {
            for(int x = 0; x < qr->width; x++) {
                img.setPixel(x + margin, y + margin, qr->data[y * qr->width + x] & 1 ? 0 : 1);
            }
        }
        QRcode_free(qr);
        return img.scaled(size, size, Qt::KeepAspectRatio, Qt::FastTransformation);
 }

 void QRCodeGenerate::doimgUpdate()
 {
     emit imgUpdate();
 }
