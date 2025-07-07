import QtQuick 2.0
import QtQuick.Controls 2.12
Button
{
    id: customButton
    property var imgPath
    property var btnText
    clip: true
    background: Rectangle {
        radius: 10
        color: customButton.pressed ? Config.btnPressedColor :
               customButton.hovered ? Config.btnColor : Config.btnColor
        border.color: Config.borderColor
        border.width: 1
        Image {
            id:img_1
            source: imgPath
            height: parent.height-10
            width: parent.height-10
            fillMode: Image.PreserveAspectFit
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
        Text {
            text: btnText
            color: Config.textColor
            anchors.left:img_1.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20*Config.fontScale
        }

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

}
