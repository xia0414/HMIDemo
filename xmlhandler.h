#ifndef XMLHANDLER_H
#define XMLHANDLER_H

#include <QObject>
#include <QtXml>
#include <QDomDocument>
#include <QXmlStreamReader>
#include <QFile>
#include <QDebug>
#include <QList>
#include <QVector>

struct Point {
    int id;
    double x;
    double y;
};

class XMLHandler : public QObject
{
    Q_OBJECT
public:
    explicit XMLHandler(QObject *parent = nullptr);
    void serializeToXml(const QList<Point>& points, const QString& filename);
    QList<Point> deserializeFromXml(const QString& filename);
    QVariantList convertTo2DArray(const QList<Point>& points) {
        QVariantList result;
        for (const Point& p : points){
            QVector<double> row;
            row.append(p.id);
            row.append(p.x);
            row.append(p.y);
            result.append(QVariant::fromValue(row));
        }
        return result;
    }
    QList<Point> convertVariantListToPointList(const QVariantList& array) {
        QList<Point> points;
        for (const QVariant& rowVar : array) {
            QVariantList row = rowVar.toList();
            if (row.size() >= 3) {
                Point p;
                p.id = row[0].toInt();
                p.x = row[1].toDouble();
                p.y = row[2].toDouble();
                points.append(p);
            }
        }
        return points;
    }
    Q_INVOKABLE void saveArrayToXml(const QVariantList &array, const QString &filename);
    Q_INVOKABLE QVariantList loadArrayFromXml(const QString& filename);
    Q_INVOKABLE void saveIdsToXml(const QVariantList &array, const QString &filename);
    Q_INVOKABLE QVariantList loadIdsFromXml(const QString &filename);

signals:

};

#endif // XMLHANDLER_H
