import QtQuick 2.0
import QtQuick.Controls 2.12
Button
{
    id: root
    property var btnText
    property var textSize
    clip: true
    background: Rectangle {
        radius: 10
        color: root.pressed ? Config.btnPressedColor :
               root.hovered ? Config.btnColor : Config.btnColor
        border.color: Config.borderColor
        border.width: 1
        Text {
            text: btnText
            color: Config.textColor
            anchors.centerIn: parent
            font.pixelSize: textSize
        }

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

}
