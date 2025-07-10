#include "datamanager.h"
#include <QDebug>
#include <QTimer>
#include <random>
#include <QRandomGenerator>
DataManager::DataManager(QObject *parent) : QObject(parent)
{
    m_timer = new QTimer(this);
    generateRandomData();
}

double DataManager::vol() const
{
    return m_vol;
}

void DataManager::setVol(double vol)
{
    if(m_vol != vol)
    {
        m_vol = vol;
        emit volChanged();
        qDebug()<<"C++:vol updata:"<<m_vol;
    }
}

double DataManager::cur() const
{
    return m_cur;
}

void DataManager::setCur(double cur)
{
    if(m_cur != cur)
    {
        m_cur = cur;
        emit curChanged();
        qDebug()<<"C++:cur updata:"<<m_cur;
    }
}

void DataManager::generateRandomData()
{

   connect(m_timer, &QTimer::timeout, this, [&]()
   {
       double vol = QRandomGenerator::global()->bounded(200)/10.0;
       double cur = QRandomGenerator::global()->bounded(100)/10.0;
       setCur(cur);
       setVol(vol);
       qDebug()<<"random generated";
   });
}

void DataManager::startGenerate()
{
    m_timer->start(1000);
}

void DataManager::stopGenerate()
{
    m_timer->stop();
}


