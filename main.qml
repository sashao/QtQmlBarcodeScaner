import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3


ApplicationWindow {
    id: applicationWindow
    width: 651
    height: 494
    title: "Barcode Scaner"
    visible: true




    ColumnLayout {
        spacing: 6
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        Button {
            id: button
            text: qsTr("Button")
        }

        DelayButton {
            id: delayButton
            text: qsTr("Delay Button")
        }

        Slider {
            id: slider
            value: 0.5
        }

        ProgressBar {
            id: progressBar
            value: 0.5
        }

        PageIndicator {
            id: pageIndicator
            count: 3
        }

        ScrollView {
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 30
            anchors.topMargin: 30
            anchors.fill: parent

            ListView {
                x: 0
                y: 0
                model: 20
                delegate: ItemDelegate {
                    text: "Item " + (index + 1)
                    width: parent.width
                }
            }
        }

    }

    Connections {
        target: delayButton
        onClicked: print("clicked delay")
    }

    Connections {
        target: button
        onClicked: print("clicked button")
    }

    Connections {
        target: slider
        onMoved: {
            progressBar.value = slider.value
            print("moved slider")
        }
    }
}

/*##^##
Designer {
    D{i:1;anchors_x:0}
}
##^##*/
