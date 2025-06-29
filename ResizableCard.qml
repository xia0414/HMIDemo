import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Window {
    visible: true
    width: 800
    height: 480
    title: qsTr("Hello World")
    Rectangle
    {
        id:rect_top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 50
        color: "#ECECEC"
        Image {
            id: hici_logo
            source: "file"
        }
        ComboBox
        {
            model: [1, 2, 3, 4]
            onCurrentIndexChanged:
            {
                if(currentIndex===0)
                {
                    listModel.clear()
                    listModel.append({"text": "a"})
                }
                else if(currentIndex===1)
                {
                    listModel.clear()
                    listModel.append({"text": "a"})
                    listModel.append({"text": "b"})
                }
                else if(currentIndex===2)
                {
                    listModel.clear()
                    listModel.append({"text": "a"})
                    listModel.append({"text": "b"})
                    listModel.append({"text": "c"})
                }
                else if(currentIndex===3)
                {
                    listModel.clear()
                    listModel.append({"text": "a"})
                    listModel.append({"text": "b"})
                    listModel.append({"text": "c"})
                    listModel.append({"text": "d"})
                }
            }
        }

    }
    Rectangle
    {
        id:rect_mid
        anchors.top: rect_top.bottom
        anchors.bottom: rect_bottom.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#DFDFDF"
        ListModel {
            id: listModel
            ListElement { text: "a" }
            ListElement { text: "b" }
            ListElement { text: "c" }
            ListElement { text: "d" }

        }

        ListView {
            id: listView
            interactive: false
            anchors.fill: parent
            anchors.margins: 40
            orientation: ListView.Horizontal
            spacing: 20
            model: listModel

            delegate: Rectangle {
                width: listView.currentIndex === index? parent.height:145
                height: parent.height
                color: "#FFFFFF"
                border.color: "#BDBDBD"
                radius: 20
                Loader {
                    anchors.fill: parent
                    anchors.margins: 10
                    sourceComponent: text==="a"? a_component:
                                                 text==="b"? b_component:
                                                             text==="c"? c_component:
                                                                         d_component
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: listView.currentIndex = index
                }
                Behavior on width {
                    NumberAnimation {
                        easing.type: Easing.InOutQuad
                        duration: 200
                    }
                }
            }
        }

    }
    Rectangle
    {
        id:rect_bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 40
        color: "#ECECEC"

    }

    Component {
        id:a_component
        Rectangle {
            Text {
                id:text_a
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 100
                text: "A"
                font.pixelSize: 60
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    Component {
        id:b_component
        Rectangle {
            Text {
                id:text_b
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 100
                text: "B"
                font.pixelSize: 60
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    Component {
        id:c_component
        Rectangle {
            Text {
                id:text_b
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 100
                text: "C"
                font.pixelSize: 60
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
    Component {
        id:d_component
        Rectangle {
            Text {
                id:text_b
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 100
                text: "D"
                font.pixelSize: 60
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }
    }


}
