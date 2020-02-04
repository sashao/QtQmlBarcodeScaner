import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtMultimedia 5.12

import QZXing 2.3

ApplicationWindow {
    id: applicationWindow
    width: 651
  //  property alias listView: listView
    title: "Barcode Scaner"
    visible: true

    Camera
     {
         id:camera
         focus {
             focusMode: CameraFocus.FocusContinuous
             focusPointMode: CameraFocus.FocusPointAuto
         }
         captureMode: Camera.CaptureViewfinder
     }







    ColumnLayout {
        id: columnLayout
        spacing: 6
        anchors.fill: parent



        VideoOutput
        {
            id: videoOutput
            source: camera
            visible: true;
            Layout.fillHeight: true
            Layout.fillWidth: true


            autoOrientation: true
            filters: [ zxingFilter ]
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        camera.focus.focusPointMode = CameraFocus.FocusPointCustom;
                        camera.focus.customFocusPoint = Qt.point(mouse.x / width,  mouse.y / height);
                        print("Focusing on " + camera.focus.customFocusPoint)
//                        camera.focus.focusMode = CameraFocus.FocusMacro;
                    }
                }
            RowLayout {
                anchors.fill: parent
            Rectangle {
                Layout.alignment: Qt.AlignCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.leftMargin: videoOutput.contentRect.width/4+(parent.width-videoOutput.contentRect.width)/2
                Layout.rightMargin: videoOutput.contentRect.width/4+(parent.width-videoOutput.contentRect.width)/2
                Layout.topMargin: videoOutput.contentRect.height/4+(parent.height-videoOutput.contentRect.height)/2
                Layout.bottomMargin: videoOutput.contentRect.height/4+(parent.height-videoOutput.contentRect.height)/2
                id: captureZone
                color: "white"
                opacity: 0.5
            }
            }
        }




        ScrollView {
            id: scrollView

            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            Layout.maximumHeight: 340

            ListView {
                id: listView
                highlightRangeMode: ListView.NoHighlightRange
                anchors.fill: parent
                model: 200
                delegate: ItemDelegate {
                    property int indexxx: index
                    text: "Item " + (indexxx + 1)
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
                            onClicked: {
                                parent.parent.indexxx+=1;
                                namesss.text = "Item " + (indexxx + 1)
                            }
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
            delay: 5000
        }

        RowLayout {
            id: sliderLayout
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
                to: 2.0
                Layout.fillWidth: true
            }
            states: [
                State {
                    name: "lf"
                    PropertyChanges {
                        target: sliderLayout
                        layoutDirection: Qt.RightToLeft
                    }
                    PropertyChanges {
                        target: slider
                        value: 0
                    }
                },
                State {
                    name: "rf"
                    PropertyChanges {
                        target: sliderLayout
                        layoutDirection: Qt.LeftToRight
                    }
                }
            ]
        }



    }





    QZXingFilter
     {
         id: zxingFilter
         captureRect: {
             // setup bindings
             videoOutput.contentRect;
             videoOutput.sourceRect;
             return videoOutput.mapRectToSource(videoOutput.mapNormalizedRectToItem(Qt.rect(
                 0., 0., 1., 1.
             )));
         }

         decoder {
             enabledDecoders: QZXing.DecoderFormat_EAN_13 | QZXing.DecoderFormat_CODE_39 | QZXing.DecoderFormat_QR_CODE
             //enabledDecoders: QZXing.DecoderFormat_QR_CODE

             onTagFound: {
                 print(tag + " | " + decoder.foundedFormat() + " | " + decoder.charSet());

//                 window.detectedTags++;
//                 window.lastTag = tag;
             }

             tryHarder: true
         }

         onDecodingStarted:
         {
//             console.log("started");
         }

         property int framesDecoded: 0
         property real timePerFrameDecode: 0

         onDecodingFinished:
         {
            timePerFrameDecode = (decodeTime + framesDecoded * timePerFrameDecode) / (framesDecoded + 1);
            framesDecoded++;
             if (succeeded)
             {
                print("SUCCESS!!!\n\n\n\n\n\n\n\n frame finished: " + succeeded, decodeTime, timePerFrameDecode, framesDecoded);
             }
             print("frame finished: " + succeeded, decodeTime, timePerFrameDecode, framesDecoded);
         }
     }






    Connections {
        target: delayButton
        onActivated: {
            sliderLayout.state = "rf"
            print("activated")
       }
        onProgressChanged: {
            progressBar.value = delayButton.progress *2.0;
        }
    }

    Connections {
        target: button
        onClicked: {
            sliderLayout.state = "lf"
            print("clicked button")
       }
    }

    Connections {
        target: slider
        onMoved: {
            progressBar.value = slider.value
            progressBar.opacity = slider.value
            print("moved slider "+slider.value)
        }
    }


//    Button {
//        text: "hello world"
//        onClicked: {
//            camera.start();
//            print (camera.errorString +  QtMultimedia.availableCameras)
//            videoOutput.visible = true
//        }
//    }

}

