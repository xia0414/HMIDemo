import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0
Rectangle{
    id:root
    visible: true
    anchors.fill: parent
    property real baseFontSize: 24
    property real scale: root.width/800
    Component.onCompleted:
    {
       console.log(parent.parent)
    }

    Rectangle
    {
        id:rect_top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 40
        color: Config.titleBarColor
        Image {
            id: hici_logo
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            autoTransform: true
            anchors.leftMargin: 5
            height: 30
            source: "qrc:/resources/icons/logo_hici.svg"
            fillMode: Image.PreserveAspectFit
        }
        ComboBox
        {
            id:combobox_1
            height: parent.height
            width: parent.height+10
            anchors.left: hici_logo.right
            anchors.verticalCenter: parent.verticalCenter
            //Material.background: Material.Brown

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
            Component.onCompleted:
            {
                combobox_1.currentIndex=3
            }

        }

        Switch
        {
            id:theme_swith
            anchors.left: combobox_1.right
            height: parent.height
            checked: false
            onCheckedChanged:
            {
                console.log(checked)
                if(checked)
                {
                    Config.setBlackTheme()
                }
                else
                {
                    Config.setlightTheme()
                }
            }

        }
        Text {
            id: timeText
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
            font.pixelSize: 24
            color: Config.textColor
            Component.onCompleted: updateTime()
            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: updateTime()
            }
        }

        Image {
            id: wifi_logo
            anchors.right:timeText.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
            autoTransform:true
            height: 30
            source: "qrc:/resources/icons/wifi_4.svg"
            fillMode: Image.PreserveAspectFit
            ColorOverlay{
                    anchors.fill: parent
                    color: Config.textColor
                    source: parent
                }
        }

    }
    ListModel {
        id: listModel
        ListElement { text: "a"}
        ListElement { text: "b"}
        ListElement { text: "c"}
        ListElement { text: "d"}
    }
    Rectangle
    {
        id:rect_mid
        anchors.top: rect_top.bottom
        anchors.bottom: rect_bottom.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: Config.backgroundColor
        RowLayout {
            id:rowLayout
            anchors.fill: parent
            anchors.margins: 20
            spacing: 10
            property var currentType;
            Repeater {
                model: listModel
                Rectangle
                {
                    property bool isSelected : text===rowLayout.currentType? true:false
                    Layout.preferredWidth: isSelected&&listModel.count!=2? 340:120
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    color: Config.cardColor
                    border.color: Config.borderColor
                    radius: 20
                    border.width: 1
                    Loader {
                        anchors.fill: parent
                        anchors.margins: 10
                        sourceComponent: text==="a"? a_component:
                                         text==="b"? b_component:
                                         text==="c"? c_component:
                                         d_component
                        MouseArea{
                            anchors.fill: parent
                            propagateComposedEvents: true // 允许传递组合事件
                            onClicked:
                            {
                                rowLayout.currentType = text
                                console.log(width,height)
                                mouse.accepted = false;
                            }
                        }
                    }


                    Behavior on Layout.preferredWidth {
                           NumberAnimation {
                               duration: 300  // 动画持续时间(毫秒)
                               easing.type: Easing.OutCubic  // 动画曲线
                           }
                    }
                }
            }
            Component.onCompleted:
            {
                rowLayout.currentType = "a";
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
        color:Config.titleBarColor
        Image
        {
            id:help_btn
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            height: 30
            source: "qrc:/resources/icons/help.svg"
            fillMode: Image.PreserveAspectFit
            ColorOverlay{
                    anchors.fill: parent
                    color: Config.textColor
                    source: parent
                }
        }
        Image
        {
            id:setting_btn
            anchors.left: help_btn.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            height: 30
            source: "qrc:/resources/icons/set.svg"
            fillMode: Image.PreserveAspectFit
            ColorOverlay{
                    anchors.fill: parent
                    color: Config.textColor
                    source: parent
                }
        }
        Image
        {
            id:fee_btn
            anchors.left: setting_btn.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            height: 30
            source: "qrc:/resources/icons/fee.svg"
            fillMode: Image.PreserveAspectFit
            ColorOverlay{
                    anchors.fill: parent
                    color: Config.textColor
                    source: parent
                }
            MouseArea{
                anchors.fill: parent
                onClicked:
                {
                    root.laodpage()
                }
            }
        }
    }
//A
    Component {
        id:a_component
        Rectangle {
            id:a_rect
            color: Config.cardColor
            ColumnLayout
            {
                anchors.fill: parent
                Text {
                    id:text_a
                    color: Config.textColor
                    text: "A"
                    font.pixelSize: 50*Config.fontScale
                    Layout.preferredHeight: 80
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true
                }
                Text {
                    id:text_connect
                    color: Config.textColor
                    text: "未连接"
                    font.pixelSize: 15*Config.fontScale
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                     Layout.alignment: Qt.AlignCenter
                }
                RowLayout
                {
                    Rectangle
                    {
                        color: Config.cardColor
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Layout.maximumWidth: parent.height
                        Rectangle
                        {
                            color: Config.cardColor
                            anchors.centerIn: parent
                            height: parent.width
                            width: parent.width
                            Image {
                                anchors.fill: parent
                                id: qrcode_border
                                source: "qrc:/resources/icons/QRCode_border.svg"
                            }

                            Rectangle
                            {
                                color: Config.cardColor
                                anchors.fill: parent
                                anchors.margins: parent.width/20
                                //color: "black"
                                Image {
                                    id: qrcode_img
                                    anchors.fill: parent
                                    //source: "file"
                                    source: "image://myprovider/my_image_id"
                                    function refresh(){
                                        qrcode_img.source="image://myprovider/image.png"
                                    }
                                }

                                Connections
                                {
                                    target: qrc
                                    onImgUpdate:
                                    {
                                        qrcode_img.refresh()
                                        console.log("update")
                                    }
                                }
                            }
                        }
                    }
                    Rectangle
                    {
                        id:rect_card_1
                        color: Config.cardColor
                        visible: a_rect.width>(a_rect.height*0.4)? true:false
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        ColumnLayout
                        {
                            anchors.fill: parent
                            IconBtn
                            {
                                id:card_btn
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                //Layout.maximumWidth: 200
                                Layout.alignment: Qt.AlignCenter
                                imgPath: "qrc:/resources/icons/card_1.svg"
                                btnText: "刷卡"
                                onClicked:
                                {
                                    console.log("btnclicked")
                                }

                            }
                            IconBtn
                            {
                                id:vin_btn
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                //Layout.maximumWidth: 200
                                Layout.alignment: Qt.AlignCenter
                                imgPath: "qrc:/resources/icons/car.svg"
                                btnText: "VIN"
                                //scale:root.scale
                                onClicked:
                                {
                                    console.log("btnclicked")
                                }
                            }
                            IconBtn
                            {
                                id:more_btn
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.preferredHeight: 40
                                Layout.alignment: Qt.AlignCenter
                                imgPath: "qrc:/resources/icons/more.svg"
                                btnText: "更多"
                                //scale:root.scale
                                onClicked:
                                {
                                    console.log("btnclicked")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
//B
    Component {
        id:b_component


        Rectangle {
            color: Config.cardColor
            ColumnLayout
            {
                anchors.fill: parent
                clip: true
                Text {
                    id:text_b
                    color: Config.textColor
                    text: "B"
                    font.pixelSize: 50*Config.fontScale
                    Layout.preferredHeight: 80
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillWidth: true

                }
                Rectangle
                {
                    color: Config.cardColor
                    height: 30
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Image {
                        id: ccs2dc1_img
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        height: 110
                        width: 110
                        source: "qrc:/resources/icons/CCS2_DC.svg"

                    }
                }
                Text{
                    id:cc2dc1_text
                    color: Config.textColor
                    height: 40
                    text: "CCS2_DC"
                    font.pixelSize: 20*Config.fontScale
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter

                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Config.borderColor // 线条颜色
                }
                Text {
                    id: ccs2dc1_connectState
                    color: Config.textColor
                    font.pixelSize:15*Config.fontScale
                    Layout.preferredHeight: 50*Config.fontScale
                    text: "未连接"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter
                }
            }
        }
    }
//C
    Component {
        id:c_component
        Rectangle {
            color: Config.cardColor
            ColumnLayout
            {
                anchors.fill: parent
                clip: true
                Text {
                    id:text_c
                    color: Config.textColor
                    height: 50
                    text: "C"
                    font.pixelSize: 50*Config.fontScale
                    Layout.preferredHeight: 80
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignHCenter
                }
                Rectangle
                {
                    color: Config.cardColor
                    height: 30
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Image {
                        id: ccs2dc2_img
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        height: 110
                        width: 110
                        source: "qrc:/resources/icons/CCS2_DC.svg"

                    }
                }
                Text{
                    id:cc2dc1_text
                    color: Config.textColor
                    height: 40
                    text: "CCS2_DC"
                    font.pixelSize: 20*Config.fontScale
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter

                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Config.borderColor  // 线条颜色
                }
                Text {
                    id: ccs2dc2_connectState
                    color: Config.textColor
                    height: 50
                    text: "未连接"
                    font.pixelSize: 15*Config.fontScale
                     Layout.preferredHeight: 50*Config.fontScale
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter
                }
            }
        }
    }
//C
    Component {
        id:d_component
        Rectangle {
            color: Config.cardColor
            ColumnLayout
            {
                anchors.fill: parent
                clip: true
                Text {
                    id:text_d
                    color: Config.textColor
                    height: 50
                    text: "D"
                    font.pixelSize: 50*Config.fontScale
                    Layout.preferredHeight: 80
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter
                }
                Rectangle
                {
                    color: Config.cardColor
                    height: 30
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Image {
                        id: ccs2dc3_img
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        height: 110
                        width: 110
                        source: "qrc:/resources/icons/CCS2_DC.svg"

                    }
                }
                Text{
                    id:cc2dc1_text
                    color: Config.textColor
                    height: 40
                    text: "CCS2_DC"
                    font.pixelSize: 20*Config.fontScale
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: Config.borderColor
                }
                Text {
                    id: ccs2dc3_connectState
                    color: Config.textColor
                    height: 50
                    text: "未连接"
                    font.pixelSize: 15*Config.fontScale
                    Layout.preferredHeight: 50*Config.fontScale
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignCenter
                }
            }
        }
    }
    function updateTime() {
        timeText.text = Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss")
    }
    function laodpage()
    {
        parent.loadPage("qrc:/TabelRowColunm.qml")
    }

    onScaleChanged:
    {
        Config.fontScale = root.scale
    }

}
