import QtQuick 2.15
import QtQuick.Controls 2.15
import "../../theControls"
import "../../thePages"
import "../../theScripts/theDataBaseSystem/saveLoadEventGroups.js" as SaveLoadEventGroups
import "../../thePages/theLogs/"

Item
{
    signal goToEventGroupSetPage;
    signal refreshListModel;
    signal goToLogMessages;
    signal goBackToLogs;
    signal goToEventSetPage;
    property int selectedEventGroupId:0;
    property variant selectedItemData : [-1,"","",0]; //id, name, tag, priority
    property int flag_editElement : 0;

    signal resetValueMiniMenuEditDelete;
    onResetValueMiniMenuEditDelete:
    {
        if(flag_editElement<1)
        {
            selectedItemData=[-1,"","",0];
        }

        miniMenu_edit_delete.visible=false;
        stack_event_titles = "EG/";
    }


    signal refreshTheEventsPage;

    onRefreshTheEventsPage:
    {
        //refresh events page is on.
        logMessages.refreshListModel();
    }

    onGoBackToLogs:
    {
        logMessagesBase.visible=false;
        root.visible=true;
    }

    onGoToLogMessages:
    {
        root.visible=false;
        logMessagesBase.visible=true;
        resetValueMiniMenuEditDelete();
    }

    onRefreshListModel:
    {
        listModelMain.clear();
        if(JSON.stringify(SaveLoadEventGroups.get()).length > 24) //to avoid Syntax error Json.parse error showsup when table is clear
        {
            var allObject = JSON.parse(SaveLoadEventGroups.get());
            for(var i=0; i<allObject.eventGroups.length; i++)
            {
                listModelMain.append({
                                         id: allObject.eventGroups[i].id,
                                         ename : allObject.eventGroups[i].name.length > 7 ? allObject.eventGroups[i].name.slice(0,6) + ".." :  allObject.eventGroups[i].name,
                                         fullename: allObject.eventGroups[i].name,
                                         priority: allObject.eventGroups[i].priority,
                                         tag: allObject.eventGroups[i].tags,
                                     });

            }
        }
        else //table is empty and json has error
        {
            console.log("(from EventGroupsPage) Eventgourps NOT FOUND(eventGroups are 0)/Table isnt exists");
        }

    }

    Component.onCompleted:
    {
        refreshListModel();
    }


    anchors.fill: parent;
    Rectangle
    {
        id:root;
        anchors.fill: parent;
        color:cBG;

        ListView
        {
            id:listViewMain;
            anchors.fill:parent;
            anchors.topMargin:35;
            clip:true;
            model:
            ListModel
            {
                id:listModelMain;
            }
            delegate:
            Item
            {
                width: listViewMain.width;
                height: 70;
                Rectangle
                {
                    anchors.fill: parent;
                    color:cBG;
                    Rectangle
                    {
                        id:itemmm2;
                        width: parent.width/1.10;
                        height: 50;
                        color: cBG_element;
                        radius:15;
                        anchors.horizontalCenter: parent.horizontalCenter;

                        Text
                        {
                            text: ename;
//                            anchors.horizontalCenter: parent.horizontalCenter;
//                            width:40;
//                            height:parent.height;
//                            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
                            font.family: gFontFamily;
                            color:cTxt_button;
                            font.pointSize: 18;
                            width:parent.width/3;
                            clip:true;
                            anchors
                            {
                                verticalCenter:parent.verticalCenter;
                                left:parent.left;
                                leftMargin: 30;
                            }

                        }
                        Text
                        {
                            text: tag;
                            font.family: gFontFamily;
                            color:cTxt_button;
                            font.pointSize: 12;
                            width:parent.width/5;
                            clip:true;
                            anchors
                            {
                                verticalCenter:parent.verticalCenter;
                                right:parent.right;
                                rightMargin: 30;
                            }
                        }



                        MouseArea
                        {
                            anchors.fill:parent;
                            onClicked:
                            {
                                selectedEventGroupId = id;
                                logMessages.setEventGroupId = id;
//                                selectedEventGroupTitle = ename;
//                                logMessages.setEventGroupName = ename;
                                logMessages.setEventGroupName = fullename;

                                logMessages.refreshListModel();
                                goToLogMessages();
                                stack_event_titles = "EG/E/";
                            }
                            onPressAndHold:
                            {
                                miniMenu_edit_delete.visible=true;
                                const valY = itemmm2.y;
                                if(valY >= root.height)
                                {
                                    console.log("(from EventGroupsPage) id & x & Y press and holded item id=" + id + "-x=" + itemmm2.x + "-y="+itemmm2.y);
                                    console.log('(from EventGroupsPage) problem: the y is more than view os its going very down + 1 element isnt include (bcz of myIndicator Height)');
                                }
                                else
                                    miniMenu_edit_delete.posYselectedElement=valY;
                                selectedItemData[0]=id;
                                selectedItemData[1]=fullename;
                                selectedItemData[2]=tag;
                                selectedItemData[3]=priority;
                                stack_event_titles += "M/";
                            }
                        }
                    }


                }

            }//end of item delegate

        }//end of list view





        MyThreeBottomButtons
        {
            id:idMyThreeBottomButtons;
            width: root.width;
            height:root.height/10.5;
            setCenterButtonText: "+";
            setLeftButtonText: "";
            setRightButtonText: ""; //null string make em invisible
            setCenterButtonCircleStyled: true;

            anchors
            {
                bottom:root.bottom;
                bottomMargin:15;
            }
            onCenterButtonPressed:
            {
                goToEventGroupSetPage();
                resetValueMiniMenuEditDelete();
                stack_event_titles = "EG/N/";
            }
        }
    }//end of root

    Rectangle
    {
        id:logMessagesBase;
        anchors.fill:parent;
        visible:false;
        EventsPage
        {
            id:logMessages;
            onGoBackToEventGroupsFromEvents:
            {
                logMessagesBase.visible=false;
                root.visible=true;
            }

//            onGoToLogs:
//            {
//                goBackToLogs();
//            }
        }
    }

    MiniMenuEditAndDelete
    {
        id:miniMenu_edit_delete;
        z:10;

        onCancelButton:
        {
            resetValueMiniMenuEditDelete();
        }

        setTitlesAsArray : ["Archive","Edit","Delete"];
        setIconsAsArray:
        [
            path_to_menuIcons + fileIcon_Archive,
            path_to_menuIcons + fileIcon_Edit,
            path_to_menuIcons + fileIcon_Delete
        ];


        onButtonAClicked:
        {
            console.log("archive clicked");
        }
        onButtonBClicked:
        {
            console.log("edit clicked");
//            updateModeEnabledActions
            if(selectedItemData[0]>0)
            {
                flag_editElement=1;
                goToEventGroupSetPage();
                resetValueMiniMenuEditDelete();
                stack_event_titles = "EG/NE/";
            }
            else
                console.log("(from EventGroupsPage) message failed to edit because of invaild id="+selectedItemData[0]);
        }

        onButtonCClicked:
        {
            if(selectedItemData[0]>0)
            {
                if(SaveLoadEventGroups.removeElement(selectedItemData[0]) === "OK")
                {
                    console.log("(from EventGroupsPage) message success delete element.");
                    refreshListModel();
                    resetValueMiniMenuEditDelete();
                }
                else
                    console.log("(from EventGroupsPage) message faile to delete element.");
            }
            else
            {
                console.log("(from EventGroupsPage) error, wrong element id="+selectedItemData[0]);
            }
        }
    }
}//end of item



