#include "xmlhandler.h"

XMLHandler::XMLHandler(QObject *parent) : QObject(parent)
{

}

void XMLHandler::serializeToXml(const QList<Point> &points, const QString &filename)
{
    QDomDocument doc;
        QDomProcessingInstruction instruction = doc.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-8\"");
        doc.appendChild(instruction);
        QDomElement root = doc.createElement("Points");
        doc.appendChild(root);
        for (const Point& point : points) {
            QDomElement pointElem = doc.createElement("Point");
            pointElem.setAttribute("id", point.id);
            QDomElement xElem = doc.createElement("x");
            QDomText xText = doc.createTextNode(QString::number(point.x));
            xElem.appendChild(xText);
            pointElem.appendChild(xElem);
            QDomElement yElem = doc.createElement("y");
            QDomText yText = doc.createTextNode(QString::number(point.y));
            yElem.appendChild(yText);
            pointElem.appendChild(yElem);
            root.appendChild(pointElem);
        }
        QFile file(filename);
        if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
            qWarning() << "无法打开文件用于写入:" << filename;
            return;
        }
        QTextStream out(&file);
        doc.save(out, 4);
        file.close();
        qDebug() << "XML序列化完成，文件已保存到:" << filename;
}

QList<Point> XMLHandler::deserializeFromXml(const QString &filename)
{
    QList<Point> points;

        QFile file(filename);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qWarning() << "无法打开文件用于读取:" << filename;
            return points;
        }
        QDomDocument doc;
        QString errorMsg;
        int errorLine, errorColumn;
        if (!doc.setContent(&file, &errorMsg, &errorLine, &errorColumn)) {
            qWarning() << "XML解析错误:" << errorMsg
                      << "行:" << errorLine
                      << "列:" << errorColumn;
            file.close();
            return points;
        }
        file.close();

        QDomElement root = doc.documentElement();
        if (root.tagName() != "Points") {
            qWarning() << "根元素不是<Points>";
            return points;
        }

        QDomNodeList pointNodes = root.elementsByTagName("Point");
        for (int i = 0; i < pointNodes.size(); ++i) {
            QDomElement pointElem = pointNodes.at(i).toElement();
            Point point;

            if (pointElem.hasAttribute("id")) {
                point.id = pointElem.attribute("id").toInt();
            } else {
                qWarning() << "Point元素缺少id属性";
                continue;
            }

            QDomElement xElem = pointElem.firstChildElement("x");
            if (xElem.isNull()) {
                qWarning() << "Point" << point.id << "缺少x元素";
                continue;
            }
            point.x = xElem.text().toDouble();

            QDomElement yElem = pointElem.firstChildElement("y");
            if (yElem.isNull()) {
                qWarning() << "Point" << point.id << "缺少y元素";
                continue;
            }
            point.y = yElem.text().toDouble();

            points.append(point);
        }

        return points;
}

void XMLHandler::saveArrayToXml(const QVariantList &array, const QString &filename)
{
    QList<Point> points =  convertVariantListToPointList(array);
    serializeToXml(points,filename);
}

QVariantList XMLHandler::loadArrayFromXml(const QString &filename)
{
    QList<Point> points;
    points = deserializeFromXml(filename);
    QVariantList result;
    result =  convertTo2DArray(points);
    return result;
}

void XMLHandler::saveIdsToXml(const QVariantList &array, const QString &filename)
{
    QDomDocument doc;
    QDomProcessingInstruction instr = doc.createProcessingInstruction(
                "xml", "version=\"1.0\" encoding=\"UTF-8\"");
    doc.appendChild(instr);
    QDomElement root = doc.createElement("IntegerIds");
    doc.appendChild(root);
    for (const QVariant &item : array) {
        bool ok;
        int id = item.toInt(&ok);

        if (!ok) {
            qWarning() << "跳过非整型数据:" << item;
            continue;
        }
        QDomElement idElement = doc.createElement("Id");
        idElement.appendChild(doc.createTextNode(QString::number(id)));
        root.appendChild(idElement);
    }
    QFile file(filename);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qWarning() << "无法打开文件用于写入:" << filename;
        return;
    }
    QTextStream out(&file);
    out.setCodec("UTF-8");
    doc.save(out, 4);
    file.close();
    qDebug() << "整型ID列表成功保存到XML文件:" << filename;
}

QVariantList XMLHandler::loadIdsFromXml(const QString &filename)
{
    QVariantList idList;

        QFile file(filename);
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qWarning() << "无法打开文件用于读取:" << filename;
            return idList;
        }
        QDomDocument doc;
        QString errorMsg;
        int errorLine, errorColumn;
        if (!doc.setContent(&file, &errorMsg, &errorLine, &errorColumn)) {
            file.close();
            qWarning() << QString("XML解析错误: %1 (行: %2, 列: %3)")
                              .arg(errorMsg).arg(errorLine).arg(errorColumn);
            return idList;
        }
        file.close();
        QDomElement root = doc.documentElement();
        if (root.tagName() != "IntegerIds") {
            qWarning() << "无效的XML格式: 根元素不是<IntegerIds>";
            return idList;
        }
        QDomNodeList idNodes = root.elementsByTagName("Id");
        for (int i = 0; i < idNodes.count(); i++) {
            QDomNode node = idNodes.at(i);
            if (node.isElement()) {
                QDomElement idElement = node.toElement();
                bool ok;
                int id = idElement.text().toInt(&ok);

                if (ok) {
                    idList.append(id);
                } else {
                    qWarning() << "跳过非整型ID:" << idElement.text();
                }
            }
        }
        qDebug() << "从XML文件加载了" << idList.size() << "个ID";
        return idList;
}

