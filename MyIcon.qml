import QtQuick 2.12
import QtQuick.Controls 2.12

Text {
    property int iconSource
    property int iconSize: height
    property color iconColor: Config.textColor
    //anchors.fill: parent
    id:control
    font.family: font_loader.name
    font.pixelSize: iconSize
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    color: iconColor
    text: (String.fromCharCode(iconSource).toString(16))
    opacity: iconSource>0
    FontLoader{
        id: font_loader
        source: "qrc:/resources/font/FluentIcons.ttf"
    }
}
