#ifndef DATAMANAGER_H
#define DATAMANAGER_H

#include <QObject>
#include <QTimer>

class DataManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(double vol READ vol WRITE setVol NOTIFY volChanged)
    Q_PROPERTY(double cur READ cur WRITE setCur NOTIFY curChanged)
    //Q_PROPERTY_AUTO()
public:
    explicit DataManager(QObject *parent = nullptr);
    double vol() const;
    void setVol(double vol);

    double cur() const;
    void setCur(double cur);

    void generateRandomData();
    Q_INVOKABLE void startGenerate();
    Q_INVOKABLE void stopGenerate();

private:
    double m_vol = 0;
    double m_cur = 0;

    QTimer* m_timer;

signals:
    void volChanged();
    void curChanged();
};

#endif // DATAMANAGER_H
