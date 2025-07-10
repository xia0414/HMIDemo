import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Rectangle {
    property var  name
    property var itemIndex:0
    property var inPutList:[]
    property var outPutList: []
    Rectangle
    {
        id:root
        anchors.fill: parent
    }
    Button
    {
        id:btn_save
        anchors.left: parent.left
        text:"保存"
        onClicked: {
            traverseDirectChildren()
            console.log(outPutList,outPutList.length)
            xmlHandle.saveArrayToXml(outPutList,"points_dom.xml")
        }
         anchors.bottom: parent.bottom

    }
    Button
    {
        id:btn_add
        anchors.left: btn_save.right
        anchors.bottom: parent.bottom
        text:"新增"
        onClicked:
        {
            addNewItem()
        }
    }
    Button
    {
        id:btn_clear
        anchors.left: btn_add.right
        anchors.bottom: parent.bottom
        text: "删除"
        onClicked:
        {
            clearItem()
        }
    }
    function addItem(id,x,y)
    {
        var component = Qt.createComponent("qrc:/DragLayout/DragableItem.qml");
        if (component.status === Component.Ready) {
            var dynamicComponent = component.createObject(root, {
                        "x": x,
                        "y": y,
                        "id":id
                    });
                    if (dynamicComponent === null) {
                        console.log("Error creating object:", component.errorString());
                    } else {
                        console.log(dynamicComponent.id);
                    }
        } else if (component.status === Component.Error) {
            console.log("Error loading component:", component.errorString());
        } else {
            component.statusChanged.connect(function() {
                if (component.status === Component.Ready) {
                    instantiateComponent(component);
                } else if (component.status === Component.Error) {
                    console.log("Error loading component:", component.errorString());
                }
            });
        }
    }
    function loadMatrix(matrix)
    {
        for (var i = 0; i < matrix.length; i++) {
            addItem(matrix[i][0],matrix[i][1],matrix[i][2])
            console.log(matrix[i][0],matrix[i][1],matrix[i][2])
        }
    }
    function traverseDirectChildren() {
        outPutList = []
        for (let i = 0; i < root.children.length; i++) {
            const child = root.children[i];
            console.log(child.id,child.x,child.y)
            outPutList.push([child.id,child.x,child.y])
        }
        console.log("outputlist",outPutList);
    }

    function addNewItem()
    {
        var newid = -1
        for (let i = 0; i < root.children.length; i++) {
            const child = root.children[i];
            console.log(child.id)
            newid = Math.max(child.id,newid)
            //outPutList.push([child.id,child.x,child.y])
        }
        newid++
        addItem(newid,50,50)
    }
    function clearItem()
    {
        for (let i = 0; i < root.children.length; i++) {
            const child = root.children[i];
            console.log(child.id)
            child.destroy()
        }
        outPutList = []
        console.log(outPutList,outPutList.length)
        xmlHandle.saveArrayToXml(outPutList,"points_dom.xml")
        loadMatrix(xmlHandle.loadArrayFromXml("points_dom.xml"));
    }
    function save()
    {
        traverseDirectChildren()
        xmlHandle.saveArrayToXml(outPutList,"points_dom.xml")
    }
    Component.onCompleted:
    {
        var delayTimer = Qt.createQmlObject('import QtQuick 2.12; Timer { interval: 50; running: true }',
                                              parent,
                                              "delayTimer");
           delayTimer.triggered.connect(function() {
               console.log("array", xmlHandle.loadArrayFromXml("points_dom.xml").length);
               loadMatrix(xmlHandle.loadArrayFromXml("points_dom.xml"));
               delayTimer.destroy();
           });
    }
//   Component.onDestruction:
//   {
//       save()
//   }
}
