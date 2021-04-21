import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button {
    id: toggleBtn

    // SHAPE PROPERTIES
    property int normalWidth: 60
    property int iconLength: 24
    implicitHeight: 60
    implicitWidth: 60

    // COLOUR PROPERTIES
    property color defaultBgColour: "#2b2b2b"
    property color hoverBgColour: "#3e3e3e"
    property color activeBgColour: "#24e034"
    property color borderColour: "#1e1e1e"

    // OTHER PROPERTIES
    property url iconSource: "../../Resources/svg_images/menu_icon.svg"
    property int iconLeftMargin: 18

    QtObject {
        id: internal

        property var dynamicColour: toggleBtn.down ? activeBgColour : toggleBtn.hovered ? hoverBgColour : defaultBgColour
    }

    background: Rectangle {
        id: bg
        color: internal.dynamicColour

        border.width: 2
        border.color: borderColour
    }

    contentItem: Item {
        id: content
        anchors.fill: parent

        Image {
            id: btnIcon
            width: iconLength
            height: iconLength
            sourceSize.height: iconLength
            sourceSize.width: iconLength

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: iconSource
            anchors.leftMargin: iconLeftMargin
            fillMode: Image.PreserveAspectFit
            antialiasing: true
            visible: false
        }

        ColorOverlay {
            anchors.fill: btnIcon
            source: btnIcon
            color: "#ffffff"
            antialiasing: true
            width: iconLength
            height: iconLength
        }

    }

}





/*##^##
Designer {
    D{i:0;formeditorZoom:8}
}
##^##*/
