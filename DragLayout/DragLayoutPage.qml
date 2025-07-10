import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQml.Models 2.1
import QtQuick.Layouts 1.12

Rectangle{
    visible: true
    anchors.fill: parent
    ColumnLayout {
           anchors.fill: parent

           TabBar {
               id: tabBar
               Layout.fillWidth: true
               TabButton { text: "页面1" }
               TabButton { text: "页面2" }
               TabButton { text: "页面3" }
           }
           StackLayout {
               id: stackLayout
               Layout.fillWidth: true
               Layout.fillHeight: true
               currentIndex: tabBar.currentIndex
               DragArea { }
               GridDragLayout { }
               ColunmDragLayout{ }
           }
       }

}
