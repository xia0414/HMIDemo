QT += quick quickcontrols2 \
    widgets xml

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS
DEFINES += HAVE_CONFIG_H

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        datamanager.cpp \
        main.cpp \
        qrcodegenerate.cpp \
        qrencode/bitstream.c \
        qrencode/mask.c \
        qrencode/mmask.c \
        qrencode/mqrspec.c \
        qrencode/qrenc.c \
        qrencode/qrencode.c \
        qrencode/qrinput.c \
        qrencode/qrspec.c \
        qrencode/rsecc.c \
        qrencode/split.c \
        xmlhandler.cpp

RESOURCES += qml.qrc \
    res.qrc


LIBS +=
#INCLUDEPATH += /path/to/qrencode/include
# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    Def.h \
    IconTypes.h \
    datamanager.h \
    qrcodegenerate.h \
    qrencode/bitstream.h \
    qrencode/config.h \
    qrencode/mask.h \
    qrencode/mmask.h \
    qrencode/mqrspec.h \
    qrencode/qrencode.h \
    qrencode/qrencode_inner.h \
    qrencode/qrinput.h \
    qrencode/qrspec.h \
    qrencode/rsecc.h \
    qrencode/split.h \
    xmlhandler.h
