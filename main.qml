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
        anchors.fill: parent
//        anchors.right: parent.right
//        anchors.rightMargin: 0
//        anchors.left: parent.left
//        anchors.leftMargin: 0


        ScrollView {
//            Rectangle {
//                anchors.fill: parent
////                implicitWidth: 40
////                implicitHeight: 20
//                color: "lightblue"
//            }

            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true


            ListView {
                id: listView
                x:0
                y:0
                anchors.fill: parent
                model: 20
                delegate: ItemDelegate {
                    text: "Item " + (index + 1)
                    width: parent.width
                    onClicked: print("item clicked "+ text)
                    contentItem: RowLayout {
                        Text {
                            id: namesss
                            text: qsTr("this is sparta")
                            Layout.fillWidth: true
                        }
                        Button {
                            text: "Go!"
                        }
                    }
                }
            }
        }


        Button {
            Layout.alignment: Qt.AlignCenter
            id: button
            text: qsTr("Button")
        }

        DelayButton {
            id: delayButton
            text: qsTr("Delay Button")
        }

        RowLayout {
            Layout.alignment: Qt.AlignLeading
            Slider {
                id: slider
                value: 0.5
                Layout.minimumWidth: 20
                Layout.fillWidth: true

            }

            PageIndicator {
                id: pageIndicator
                Layout.alignment: Qt.AlignCenter
                count: 3
                Layout.fillWidth: true;
            }

//            Rectangle {
//                color: "steelblue"
//                implicitHeight: 20
//                Layout.fillWidth: true;
//            }

            ProgressBar {
                id: progressBar
                value: 0.5
                Layout.fillWidth: true
            }
        }



    }

    Connections {
        target: delayButton
        onActivated: print("toggled")
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

