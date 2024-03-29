import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../theControls"
import "../../theScripts/theDataBaseSystem/saveLoadEvents.js" as SaveEvents

Item
{
    id:root;
    signal updateLogsListModel;
    signal btnCancel;
    signal changeTextEditsEnableStatus;
    onChangeTextEditsEnableStatus:
    {
        if(root.visible)
        {
            logName.enabled = true;
            logTag.enabled = true;
            eventLocation.enabled = true;
            eventDescription.enabled = true;
        }
        else
        {
            logName.enabled = false;
            logTag.enabled = false;
            eventLocation.enabled = false;
            eventDescription.enabled = false;
        }
    }

    property int setMaxCharLogName:25;
    property int setMaxCharLogTag:25;
    property int theEventGroupId:0;

    onBtnCancel:
    {
        stack_event_titles = "EG/E/";
        logName.text = eventDescription.text = logTag.text = valueStartDate.text = valueEndDate.text = eventLocation.text = valueEndClock.text = valueStartClock.text = "";
//        eventStatusSwitch.setStatusSwitch = false; //has bug for background color ..
        priorityTumbler.currentIndex = 0;
    }


    property variant setPriorityValues:
        ["01","02","03","04","05","06","07","08","09","10",
        "11","12","13","14","15","16","17","18","19","20",
        "21","22","23","24","25","26","27","28","29","30",
        "31","32","33","34","35","36","37","38","39","40",
        "41","42","43","44","45","46","47","48","49","50",
        "51","52","53","54","55","56","57","58","59","60"];

    anchors.fill:parent;


    MyCancelSaveButton
    {
        id:myCancelSaveButtons; //here used as SAVE
        onButtonSaveClicked:
        {
            if(logName.text !== "")
            {
                SaveEvents.set(theEventGroupId,logName.text,eventDescription.text,logTag.text,
                               setPriorityValues[priorityTumbler.currentIndex], valueStartDate.text + " " + valueStartClock.text ,valueEndDate.text  + " " + valueEndClock.text,
                               eventStatusSwitch.setStatusSwitch,eventLocation.text);
                updateLogsListModel();
                btnCancel();
            }
        }
        onButtonCancelClicked:
        {
            btnCancel();

        }
    }


    ScrollView
    {
//        anchors.fill: parent
        anchors
        {
            top:myCancelSaveButtons.bottom;
            left:parent.left;
            right:parent.right;
            bottom:parent.bottom;
        }

        clip: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn;
        Item
        {
            id:rootItem;
            width: parent.width;
            height: 1500;
            implicitHeight: height;

            Rectangle
            {
                id:baseLogName;
                anchors
                {
                    horizontalCenter: parent.horizontalCenter;
                    top:parent.top
                    topMargin: 50;
                }
                width:parent.width/1.10;
                height:50;
                color:cBG_element;
                radius: 15;
                TextEdit
                {
                    id:logName;
                    anchors.fill:parent;
                    horizontalAlignment: TextInput.AlignHCenter;
                    verticalAlignment: TextInput.AlignVCenter;
                    font.family: gFontFamily;
                    font.pointSize: 12.50;
                    color:cTxt_button;
                    enabled: true;
                    clip:true;
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere;

                    Text
                    {
                        text: "Enter event title here...";
                        color: "#aaa";
                        visible: !logName.text;
                        anchors.centerIn:parent;
                    }
                    onTextChanged:
                    {
                        if(logName.length >= setMaxCharLogName)
                        {
                            logName.text = logName.text.slice(0,setMaxCharLogName);
                            logName.cursorPosition=setMaxCharLogName;
                        }
                    }
                }
            }//end of log name base









            Rectangle
            {
                id:baseLogTag;
                anchors
                {
                    horizontalCenter: parent.horizontalCenter;
                    top:baseLogName.bottom;
                    topMargin: 25;
                }
                width:parent.width/1.10;
                height:50;
                color:cBG_element;
                radius: 15;

                TextEdit
                {
                    id:logTag;
                    anchors.fill:parent;
                    horizontalAlignment: TextInput.AlignHCenter;
                    verticalAlignment: TextInput.AlignVCenter;
                    font.family: gFontFamily;
                    font.pointSize: 12.50;
                    color:cTxt_button;
                    enabled: true;
                    clip:true;
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                    Text
                    {
                        text: "Enter event tags here...";
                        color: "#aaa";
                        visible: !logTag.text;
                        anchors.centerIn:parent;
                    }
                    onTextChanged:
                    {
                        if(logTag.length >= setMaxCharLogTag)
                        {
                            logTag.text = logTag.text.slice(0,setMaxCharLogTag);
                            logTag.cursorPosition=setMaxCharLogTag;
                        }
                    }
                }
            }//end of log name base




            Rectangle
            {
                id:baseEventLocation;
                anchors
                {
                    horizontalCenter: parent.horizontalCenter;
                    top:baseLogTag.bottom;
                    topMargin: 25;
                }
                width:parent.width/1.10;
                height:50;
                color:cBG_element;
                radius: 15;

                TextEdit
                {
                    id:eventLocation;
                    anchors.fill:parent;
                    horizontalAlignment: TextInput.AlignHCenter;
                    verticalAlignment: TextInput.AlignVCenter;
                    font.family: gFontFamily;
                    font.pointSize: 12.50;
                    color:cTxt_button;
                    enabled: true;
                    clip:true;
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                    Text
                    {
                        text: "Enter location here...";
                        color: "#aaa";
                        visible: !eventLocation.text;
                        anchors.centerIn:parent;
                    }
                    onTextChanged:
                    {
                        if(eventLocation.length >= setMaxCharLogTag)
                        {
                            eventLocation.text = eventLocation.text.slice(0,setMaxCharLogTag);
                            eventLocation.cursorPosition=setMaxCharLogTag;
                        }
                    }
                }
            }//end of log name base



            Rectangle
            {
                id:baseEventDescription;
                anchors
                {
                    horizontalCenter: parent.horizontalCenter;
                    top:baseEventLocation.bottom;
                    topMargin: 25;
                }
                width:parent.width/1.10;
                height:50*3;
                color:cBG_element;
                radius: 15;

                TextEdit
                {
                    id:eventDescription;
                    anchors.fill:parent;
                    horizontalAlignment: TextInput.AlignHCenter;
                    verticalAlignment: TextInput.AlignVCenter;
                    font.family: gFontFamily;
                    font.pointSize: 12.50;
                    color:cTxt_button;
                    enabled: true;
                    clip:true;
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                    Text
                    {
                        text: "Enter description here...";
                        color: "#aaa";
                        visible: !eventDescription.text;
                        anchors.centerIn:parent;
                    }
                    onTextChanged:
                    {
                        if(eventDescription.length >= setMaxCharLogTag*5)
                        {
                            eventDescription.text = eventDescription.text.slice(0,setMaxCharLogTag);
                            eventDescription.cursorPosition=setMaxCharLogTag;
                        }
                    }
                }
            }//end of log name base




            Rectangle
            {
                id:baseEventActiveStatus;
                anchors
                {
                    horizontalCenter: parent.horizontalCenter;
                    top:baseEventDescription.bottom;
                    topMargin: 25;
                }
                width:parent.width/1.10;
                height:50;
                color:cBG_element;
                radius: 15;
                Text
                {
                    text:"Event active";
                    font.family: gFontFamily;
                    font.bold: true;
                    color:cTxt_button;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.leftMargin: 10;
                }

                Rectangle
                {
                    width: 50;
                    height: width/2;
                    color:cBG_Unknown;
                    anchors
                    {
                        right:baseEventActiveStatus.right;
                        rightMargin:10;
                        verticalCenter:parent.verticalCenter;
                    }

                    MySwitch
                    {
                        id:eventStatusSwitch;
                        setBorderWidth: 4;
                        setStatusSwitch:false;
                        setStatusBorder:false;
                        setSizeSwitchCircle: 2.80;
                    }
                }
            }//end of log name base




            Rectangle
            {
                id:baseLogPriority;
                anchors
                {
                    horizontalCenter: parent.horizontalCenter;
                    top:baseEventActiveStatus.bottom;
                    topMargin: 25;
                }
                width:parent.width/1.10;
                height:255;
                color:cBG_element;
                radius: 15;
                clip:true;
                Tumbler
                {
                    id: priorityTumbler;
                    width: parent.width/3;
                    model:setPriorityValues;
                    currentIndex: 1;
                    font.bold: true;
                    font.pointSize: 30;
                    visibleItemCount: 4;
                    anchors
                    {
                        centerIn:parent;
                    }
                }
            }


            Rectangle
            {
                id:baseStartDate;
                anchors
                {
                    horizontalCenter: parent.horizontalCenter;
                    top:baseLogPriority.bottom;
                    topMargin: 25;
                }
                width:parent.width/1.10;
                height:50;
                color:cBG_element;
                radius: 15;
                Text
                {
                    id: labelStartDate;
                    text:"Start:";
                    font.bold: true;
                    font.family:gFontFamily;
                    color:cTxt_button;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.leftMargin: 10;
                }
                Text
                {
                    id: valueStartDate;
                    text:"";
                    anchors.leftMargin: 10;
                    anchors.left: labelStartDate.right;
                    anchors.verticalCenter: parent.verticalCenter;
                    font.family:gFontFamily;
                    color:cUnknown;
                }
                Text
                {
                    id: valueStartClock;
                    text:"";
                    anchors.leftMargin: 10;
                    anchors.left: valueStartDate.right;
                    anchors.verticalCenter: parent.verticalCenter;
                    font.family:gFontFamily;
                    color:cUnknown;
                }


                Rectangle
                {
                    id:baseSelectStartClock;
                    anchors.verticalCenter: parent.verticalCenter;
                    width:25;
                    height:25;
                    color:cBG_Unknown;
                    anchors.right:parent.right;
                    anchors.rightMargin: 10;
                    MouseArea
                    {
                        anchors.fill:parent;
                        onClicked:
                        {
                            pickClockStartId.visible=true;
                            stack_event_titles += "CS/";
                        }
                    }
                    Image
                    {
                        anchors.fill: parent;
                        source: "../../" +path_to_menuIcons + fileIcon_pickClock;
                    }
                }

                Rectangle
                {
                    id:baseSelectStartDate;
                    anchors.verticalCenter: parent.verticalCenter;
                    width:25;
                    height:25;
                    color:cBG_Unknown;
                    anchors.right:baseSelectStartClock.left;
                    MouseArea
                    {
                        anchors.fill:parent;
                        onClicked:
                        {
                            pickStartdateId.visible=true;
                            stack_event_titles += "DS/";
                        }
                    }
                    Image
                    {
                        anchors.fill: parent;
                        source: "../../" +path_to_menuIcons + fileIcon_pickDate;
                    }
                }

            }//end of log name base








            Rectangle
            {
                id:baseEndDate;
                anchors
                {
                    horizontalCenter: parent.horizontalCenter;
                    top:baseStartDate.bottom;
                    topMargin: 25;
                }
                width:parent.width/1.10;
                height:50;
                color:cBG_element;
                radius: 15;
                Text
                {
                    id: labelEndDate;
                    text:"End:";
                    font.bold: true;
                    font.family:gFontFamily;
                    color:cTxt_button;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: parent.left;
                    anchors.leftMargin: 10;
                }
                Text
                {
                    id: valueEndDate;
                    text:"";
                    anchors.left: labelEndDate.right;
                    anchors.leftMargin: 10;
                    anchors.verticalCenter: parent.verticalCenter;
                    font.family:gFontFamily;
                    color:cUnknown;
                }
                Text
                {
                    id: valueEndClock;
                    text:"";
                    anchors.left: valueEndDate.right;
                    anchors.leftMargin: 10;
                    anchors.verticalCenter: parent.verticalCenter;
                    font.family:gFontFamily;
                    color:cUnknown;
                }

                Rectangle
                {
                    id:baseSelectEndClock;
                    anchors.verticalCenter: parent.verticalCenter;
                    width:25;
                    height:25;
                    color:cBG_Unknown;
                    anchors.right:parent.right;
                    anchors.rightMargin: 10;
                    MouseArea
                    {
                        anchors.fill:parent;
                        onClicked:
                        {
                            pickClockEndId.visible=true;
                            stack_event_titles += "CE/";
                        }
                    }
                    Image
                    {
                        anchors.fill: parent;
                        source: "../../" +path_to_menuIcons + fileIcon_pickClock;
                    }
                }

                Rectangle
                {
                    id:baseSelectEndDate;
                    anchors.verticalCenter: parent.verticalCenter;
                    width:25;
                    height:25;
                    color:cBG_Unknown;
                    anchors.right:baseSelectEndClock.left;
                    MouseArea
                    {
                        anchors.fill:parent;
                        onClicked:
                        {
                            pickEnddateId.visible=true;
                            stack_event_titles += "DE/";
                        }
                    }
                    Image
                    {
                        anchors.fill: parent;
                        source: "../../" +path_to_menuIcons + fileIcon_pickDate;
                    }
                }

            }//end of log name base

        }
    }


    //calender
    PickDatePopup
    {
        id:pickStartdateId;
        z:6;

        onBtnSave:
        {
            whatsOutput();
//            console.log(giveme_picked_days[0]);
//            console.log(giveme_picked_days[1]);
//            console.log(giveme_picked_days[2]);
//            console.log(giveme_picked_days[3]);
//            console.log(giveme_picked_days[4]);
//            console.log(giveme_picked_days[5]);
//            console.log(giveme_picked_days[6]);
//            console.log(giveme_picked_days[7]);
            valueStartDate.text= giveme_picked_days[0] + "/" +  giveme_picked_days[1]  + "/" +
                    giveme_picked_days[2] + giveme_picked_days[3] + giveme_picked_days[4] +
                    giveme_picked_days[5] + giveme_picked_days[6] + giveme_picked_days[7];
            //here is bug the giveme picked days has some zero value and those make this output value are bad for view.

        }
        onBtnCancel:
        {
            stack_event_titles = "EG/E/N/";
        }
    }

    PickDatePopup
    {
        id:pickEnddateId;
        z:6;

        onBtnSave:
        {
            whatsOutput();
            valueEndDate.text= giveme_picked_days[0] + "/" +  giveme_picked_days[1]  + "/" +
                    giveme_picked_days[2] + giveme_picked_days[3] + giveme_picked_days[4] +
                    giveme_picked_days[5] + giveme_picked_days[6] + giveme_picked_days[7];
            //here is bug the giveme picked days has some zero value and those make this output value are bad for view.

        }
        onBtnCancel:
        {
            stack_event_titles = "EG/E/N/";
        }
    }


    PickClockPopup
    {
        id:pickClockStartId;
        z:6;

        onBtnSave:
        {
            valueStartClock.text= outputHour + ":" + outputMinute;
        }
        onBtnCancel:
        {
            stack_event_titles = "EG/E/N/";
        }
    }


    PickClockPopup
    {
        id:pickClockEndId;
        z:6;

        onBtnSave:
        {
            valueEndClock.text= outputHour + ":" + outputMinute;
        }
        onBtnCancel:
        {
            stack_event_titles = "EG/E/N/";
        }
    }



}
