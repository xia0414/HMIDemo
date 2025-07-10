import QtQuick 2.0
import QtQuick.Layouts 1.12
Rectangle {
    id: draggableItem
    property var id
    property var index

    width: 80; height: 80
    color: "lightblue"
    radius: 5
    border.width: 2
    border.color: "black"
    Drag.active: dragArea.drag.active
    Drag.hotSpot.x: width / 2
    Drag.hotSpot.y: height / 2
    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        onReleased:
        {
            draggableItem.parent.parent.save();
        }
    }
    Text {
        anchors.centerIn: parent
        text: id
        font.pixelSize: 30
    }

}

