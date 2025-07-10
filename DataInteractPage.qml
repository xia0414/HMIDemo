import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
Rectangle
{
    id:root
    anchors.fill: parent
    color: Config.backgroundColor
    ColumnLayout
    {
        anchors.fill: parent
        spacing: 20
        RowLayout{
            Layout.preferredWidth: 200
            Layout.alignment: Layout.Center
            Text {
                text: "电压:"
                font.pixelSize: 40
                color: Config.textColor
            }
            Rectangle
            {
                Layout.preferredHeight: 100
                Layout.preferredWidth:vol_edit.width+20>150? vol_edit.width:150
                Layout.alignment: Layout.Center
                border.color:Config.borderColor
                color: Config.cardColor
                border.width: 1
                radius: 10
                TextEdit
                {
                    id:vol_edit
                    anchors.centerIn: parent
                    font.pixelSize: 50
                    color:Config.textColor
                    text: dataManager.vol
                    onTextChanged:
                    {
                        dataManager.vol = text
                    }
                }
            }
        }
        RowLayout{
            Layout.preferredWidth: 200
            Layout.alignment: Layout.Center
            Text {
                text: "电流:"
                font.pixelSize: 40
                color: Config.textColor
            }
            Rectangle
            {
                Layout.preferredHeight: 100
                Layout.preferredWidth:150
                Layout.alignment: Layout.Center
                border.color:Config.borderColor
                color: Config.cardColor
                border.width: 1
                radius: 10
                TextEdit
                {
                    id:cur_edit
                    anchors.centerIn: parent
                    font.pixelSize: 50
                    color:Config.textColor
                    text: dataManager.cur
                    onTextChanged:
                    {
                        dataManager.cur = text
                    }
                }
            }
        }
    }

    Button
    {
        id:randomGenerateCtl
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        text: checked? "stop":"start"
        checkable: true
        onClicked:
        {
            if(checked)
            {
                console.log("start")
                dataManager.startGenerate();
            }
            else
            {
                console.log("stop")
                dataManager.stopGenerate();
            }
        }
    }
}
