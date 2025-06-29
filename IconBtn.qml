import QtQuick 2.0
import QtQuick.Controls 2.12
Button
{
    property var imgPath
    property var btnText
    id: customButton
    clip: true
    background: Rectangle {
        radius: 10
        color: customButton.pressed ? "#E3E3E3" :
               customButton.hovered ? "#EEEEEE" : "#F2F2F2"
        border.color: "#D4D4d4"
        border.width: 1
        Image {
            id:img_1
            source: imgPath
            height: parent.height-10
            fillMode: Image.PreserveAspectFit
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
        Text {
            text: btnText
            anchors.left:img_1.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 20
        }
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }




}
