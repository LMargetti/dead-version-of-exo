import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: winBtn

    // Colour Properties
    property color defCol: "#1e1e1e"
    property color hoverCol: "#2b2b2b"
    property color actCol: "#242424"

    // Colour Properties
    property url iconSource: "../../Resources/svg_images/wanderson/minimize_icon.svg"
    property int iconHeight: 18
    property int iconWidth: 18

    implicitHeight: 25
    implicitWidth: 50

    QtObject {
        id: internal

        property var dynamicColour: winBtn.down ? actCol : winBtn.hovered ? hoverCol : defCol
    }


    background: Rectangle {
        id: btnBg
        color: internal.dynamicColour
    }

    contentItem: Item{
        id: content
        anchors.fill: parent
        Image {
             id: iconBtn
             source: iconSource
             anchors.verticalCenter: parent.verticalCenter
             anchors.horizontalCenter: parent.horizontalCenter
             height: iconHeight
             width: iconWidth
             fillMode: Image.PreserveAspectFit
             antialiasing: false
             visible: false
            }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#ffffff"
            antialiasing: false
        }

    }


}



/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/
