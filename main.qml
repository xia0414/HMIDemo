import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
//import QtQuick.Controls.Material 2.12
import "qrc:/"
ApplicationWindow {
    id:root
    visible: true
    width: 800
    height: 480
    title: qsTr("HMIDemo")
    property real baseFontSize: 24
    property real scale: root.width/800
    StackView {
    id: stackView
    initialItem: "qrc:/HomePage.qml"
    anchors.fill: parent

    function loadPage(page)
    {
        stackView.push(page)
    }
    }

    Button
    {
        id:back_btn
        width: 40
        height: 40
        anchors.top: parent.top;
        anchors.right: parent.right;
        visible: stackView.depth == 1 ? false : true
        icon.source: "qrc:/resources/icons/cancel.svg"
        background: Rectangle
        {
            color:"transparent"
        }

        onClicked:
        {
            stackView.pop()
        }
    }

}
