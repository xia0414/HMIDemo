import QtQuick 2.12
import QtQuick.Controls 2.12
Item {
    property color color: Config.borderColor
    property int elevation: 10
    property int radius: parent.radius
    id:control
    anchors.fill: parent
    Repeater{
        model: elevation
        Rectangle{
            anchors.fill: parent
            color: "#00000000"
            opacity: 0.01 * (elevation-index+1)
            anchors.margins: -index
            radius: control.radius+index
            border.width: index
            border.color: control.color
        }
    }
}

