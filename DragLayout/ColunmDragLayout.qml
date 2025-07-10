import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    id:root
    width: 600; height: 400
    property var itemId :1
    ColumnLayout
    {
        id:gridLayout
        height: 400
        width: 300
        ListModel {
            id:itemModel
        }
        Repeater
        {
            model: itemModel
            delegate:  DropArea {
                id: delegateRoot
                Layout.fillWidth: true
                height: 70
                onEntered:{
                    itemModel.move(drag.source.visualIndex,icon.visualIndex,1)
                    save()
                }
                property int visualIndex: index
                Binding { target: icon; property: "visualIndex"; value: visualIndex }
                Rectangle {
                    id: icon
                    property int visualIndex: 0
                    width: delegateRoot.width-10; height: 60
                    color: "lightblue"
                    border.color: "black"
                    border.width: 2
                    radius: 5
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    Text {
                        anchors.centerIn: parent
                        color: "black"
                        text: id
                        font.pixelSize: icon.height/2
                    }
                    DragHandler {
                        id: dragHandler
                    }
                    Drag.active: dragHandler.active
                    Drag.source: icon
                    Drag.hotSpot.x: 36
                    Drag.hotSpot.y: 36

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }
                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }
    }
    Button {
        id:btn_load
        anchors.bottom: parent.bottom
        text: "load"
        onClicked: {
            load()
        }

    }
    Button{
        id:btn_save
        text: "save"
        anchors.left: btn_load.right
        anchors.bottom: parent.bottom
        onClicked:
        {
            save()
        }
    }
    Button
    {
        id:btn_add
        text: "add"
        anchors.left: btn_save.right
        anchors.bottom: parent.bottom
        onClicked:
        {
            addNew()
            save()
        }
    }
    Button
    {
        id:btn_clear
        text: "clear"
        anchors.left:btn_add.right
        anchors.bottom: parent.bottom
        onClicked:
        {
            clear()
        }

    }

    function loadFormMartix(array)
    {
        for (var i = 0; i < array.length; i++) {
            itemModel.append({"id":array[i]});
        }
    }
    function save()
    {
        var array = [];
        for (var i = 0; i < itemModel.count; i++) {
            array.push(itemModel.get(i).id);
        }
        console.log(array)
        xmlHandle.saveIdsToXml(array,"ids2_dom.xml")
    }
    function load()
    {
        itemModel.clear()
        var array = xmlHandle.loadIdsFromXml("ids2_dom.xml")
        console.log("load",array)
        loadFormMartix(array)
    }

    function clear()
    {
        itemModel.clear()
    }
    function addNew()
    {
        var newid = 0
        for (var i = 0; i < itemModel.count; i++) {
            newid = Math.max(itemModel.get(i).id,newid);
        }
        newid++
        itemModel.append({"id":newid});
    }
    Component.onCompleted:
    {
        var delayTimer = Qt.createQmlObject('import QtQuick 2.12; Timer { interval: 50; running: true }',
                                            parent,
                                            "delayTimer");
        delayTimer.triggered.connect(function() {
            load()
            delayTimer.destroy();
        });
    }
}


