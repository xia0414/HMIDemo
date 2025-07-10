pragma Singleton
import QtQuick 2.0

Item {
    id:theme
    property bool  isLightTheme:theme.state === "lightTheme"? true:false
    property real fontScale:1
    property color backgroundColor: "#DFDFDF"
    property color titleBarColor:"#ECECEC"
    property color cardColor:"#FFFFFF"
    property color textColor: "#3C485C"
    property color borderColor: "#D4D4D4"
    property color btnColor:"#F2F2F2"
    property color btnPressedColor:"#E3E3E3"
    property var themeState: theme.state

    function setBlackTheme()
    {
        theme.state = "blackTheme"
        themeChanged(theme.state)
    }
    function setlightTheme()
    {
        theme.state = "lightTheme"
        themeChanged(theme.state)
    }

    signal themeChanged(var state);

    states: [
        State {
            name: "lightTheme"
            PropertyChanges {
                target: theme
                backgroundColor:"#DFDFDF"
                titleBarColor:"#ECECEC"
                borderColor:"#D4D4D4"
                btnColor:"#F2F2F2"
                btnPressedColor:"#E3E3E3"
            }
            PropertyChanges {
                target: theme
                cardColor:"#FFFFFF"
            }
            PropertyChanges {
                target: theme
                textColor:"#3C485C"
            }

        }
        ,
        State {
            name: "blackTheme"
            PropertyChanges {
                target: theme
                backgroundColor:"#2D2D2D"
                titleBarColor:"#383838"
                borderColor:"#1D1D1D"
                btnColor:"#2D2D2D"
                btnPressedColor:"#1D1D1D"
            }
            PropertyChanges {
                target: theme
                cardColor:"#383838"
            }
            PropertyChanges {
                target: theme
                textColor:"#C5C5C5"
            }
        }
    ]

    transitions: [
                Transition {
                from: "*"; to: "*"
                    PropertyAnimation { target: theme; properties: "backgroundColor"; duration: 200 }
                    PropertyAnimation { target: theme; properties: "cardColor"; duration: 200 }
                    PropertyAnimation { target: theme; properties: "textColor"; duration: 200 }
                    PropertyAnimation { target: theme; properties: "titleBarColor"; duration: 200 }
                    PropertyAnimation { target: theme; properties: "borderColor"; duration: 200 }
            }
        ]



}
