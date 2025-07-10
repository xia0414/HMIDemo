import QtQuick 2.0
import QtQuick.Controls 2.12
Button
{
    id: customButton
    property var imgPath
    property var btnText
    property bool isscale: true
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
            x:img_1.width+(parent.width-img_1.width)/2-(width/2)
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: isscale? 20*Config.fontScale:height-2
        }

        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

}
