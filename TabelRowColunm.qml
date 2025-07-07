import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
Rectangle
{
    id:tabelRowColunm
    property var jsonData
    property var jsonData2
    property var textsize:20
    property var rowHeight:35
    property var columnWidths: []
Rectangle
{
    id:rect1
    clip: true
    anchors.fill: parent
    Column {
            id:colunm_1
            x:0
            y:0
            spacing: 0
            Row {
                spacing: 0
                Repeater {
                    model: jsonData2.columns
                    Rectangle {
                        width: columnWidths[index]+10
                        height: rowHeight
                        border.color: "black"
                        border.width: 1

                        Text {
                            id:text_1
                            anchors.centerIn: parent
                            text: modelData
                            font.bold: true
                            font.pixelSize: textsize
                            color: "black"
                        }
                    }
                }
            }
            Repeater {
                model: jsonData2.fields
                Row {
                    spacing: 0
                    Repeater {
                        model: modelData
                        Rectangle {
                            width: columnWidths[index]+10
                            height: rowHeight
                            border.color: "black"
                            border.width: 1

                            Text {
                                id:text_2
                                anchors.centerIn: parent
                                text: modelData
                                font.pixelSize: textsize
                            }
                            Component.onCompleted:
                            {
                                console.log(index,columnWidths[index])
                            }
                        }
                    }
                }
            }
        }
     ScrollBar {
        id: hbar
        height: 30
        active:true
        orientation: Qt.Horizontal
        policy: ScrollBar.AlwaysOn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        size: rect1.width / colunm_1.width
        position: Math.abs(colunm_1.x)/colunm_1.width
        onPositionChanged:
        {
            if (hbar.pressed) {
                        colunm_1.x = -(colunm_1.width * position);
                    }
        }
    }
}

MouseArea
{
    id:mouse_left
    anchors.left: parent.left
    anchors.right: parent.horizontalCenter
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 30
    onClicked:
    {
        if(colunm_1.x+30>0)
        {
            colunm_1.x=0
        }
        else
        {
        colunm_1.x +=30
        }
        console.log(colunm_1.x)
    }

}

MouseArea
{
    id:mouse_right
    anchors.left: parent.horizontalCenter
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 30
    anchors.rightMargin: 30
    onClicked:
    {
        if(colunm_1.x+colunm_1.width>=rect1.width+30)
        colunm_1.x -=30
        else
        {
        colunm_1.x = -(colunm_1.width-rect1.width)
        }
    }
}
Button
{
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    text: "back"
    onClicked:
    {
        parent.parent.pop()
    }
}
Text {
    id: textMeasurer
    visible: false
    font.pixelSize:textsize
}

      function calculateWidths(pixsize) {
          for (var i = 0; i < jsonData.columns.length; i++) {
              columnWidths.push(0)
          }
          for (var row = 0; row < jsonData.fields.length; row++) {
              for (var col = 0; col < jsonData.fields[row].length; col++) {
                  var text = String(jsonData.fields[row][col])
                  textMeasurer.text = text
                  var textWidth = textMeasurer.width+10
                  if (textWidth > columnWidths[col]) {
                      columnWidths[col] = textWidth
                  }
              }
          }
          for (col = 0; col < jsonData.columns.length; col++) {
              textMeasurer.text = jsonData.columns[col]
              var headerWidth = textMeasurer.width+10
              if (headerWidth > columnWidths[col]) {
                  columnWidths[col] = headerWidth
              }
          }
          console.log(columnWidths)
      }
    function loadFromJson(jsonString)
    {
        columnWidths = []
        jsonData = []
        jsonData2 = []
        jsonData = JSON.parse(jsonString)
        calculateWidths(textsize)
        jsonData2 = jsonData
    }

    Component.onCompleted:
    {
        loadFromJson(json1)
    }
    property var json1 : '{
            "columns": [
                        "id",
                        "connectorId",
                        "idTagStart",
                        "meterStart",
                        "timestampStart",
                        "transactionId",
                        "idTagStop",
                        "meterStop",
                        "timestampStop",
                        "startSOC",
                        "stopSOC"
                    ],
            "fields": [
                        [1, 1, "TAG10001", 1500, "2023-07-01T08:00:00Z", 1001, "TAG10001", 1800, "2023-07-01T10:30:00Z", 20, 85],
                        [2, 1, "TAG10002", 1600, "2023-07-01T09:15:00Z", 1002, "TAG10002", 1900, "2023-07-01T11:45:00Z", 15, 90],
                        [3, 2, "TAG10003", 1700, "2023-07-01T10:30:00Z", 1003, "TAG10003", 2000, "2023-07-01T13:00:00Z", 10, 80],
                        [4, 2, "TAG10004", 1800, "2023-07-01T11:45:00Z", 1004, "TAG10004", 2100, "2023-07-01T14:15:00Z", 25, 95],
                        [5, 3, "TAG10005", 1900, "2023-07-01T13:00:00Z", 1005, "TAG10005", 2200, "2023-07-01T15:30:00Z", 30, 75],
                        [6, 3, "TAG10006", 2000, "2023-07-01T14:15:00Z", 1006, "TAG10006", 2300, "2023-07-01T16:45:00Z", 18, 88],
                        [7, 4, "TAG10007", 2100, "2023-07-01T15:30:00Z", 1007, "TAG10007", 2400, "2023-07-01T18:00:00Z", 22, 92],
                        [8, 4, "TAG10008", 2200, "2023-07-01T16:45:00Z", 1008, "TAG10008", 2500, "2023-07-01T19:15:00Z", 28, 82],
                        [9, 5, "TAG10009", 2300, "2023-07-01T18:00:00Z", 1009, "TAG10009", 2600, "2023-07-01T20:30:00Z", 12, 78],
                        [10, 500, "TAG1001000000", 2843897187, "2023-07-01T19:15:00Z", 1010, "TAG10010", 2700, "2023-07-01T21:45:00Z", 35, 97]
                    ]
        }'

}
