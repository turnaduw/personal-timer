import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15
import "theControls"
import "thePages"
import QtQuick.Controls.Material 2.15
import "thePages/theTimer"
import "theScripts/theDataBaseSystem/saveLoadSettings.js" as LoadSettings
import "thePages/theLogs"
import "thePages/theCalender"
import "thePages/theAlarm"
import "theScripts/updateIndicator.js" as UpdateSwipeViewIndexesAsIndicator
import "thePages/theEvents"
import "theScripts/staticValues.js" as SVS
//import "theScripts/theAPI_v1/syncSettings.js" as SyncSettings
import "theScripts/theAPI_v1/connectionInfo.js" as GetApiInfo //get url and accesskey

Window
{
//    Material.theme:Material.Dark
//    Material.accent: Material.LightBlue

    id: mainWindow;
//    width: Screen.width;
//    height: Screen.height;
    width:720/2+10;
    height:1339/1.7;
    visible: true;
    property string appTitle: SVS.listTitles[viewTimers.currentIndex];

    title: qsTr(appTitle);
    color:cBG;

    onClosing:
    {
        /*
            how works?
            if setting == ""
            {
                if warning, messages, errors stacks != ""
                {
                    work for them
                }
                else if(apptitle has only one slash)
                        -> confrim to quit app

                    else
                        switch(apptitle)
                        {
                          "Alarm" -> alarms
                          "Log" -> logs
                           ... -> ...
                        }

            }

            else do settings.
        */
        console.log("app ganna close i dont do that haha");
        close.accepted = false;
        console.log("EVENT=" + stack_event_titles);
        console.log("Log="+stack_log_titles);
        console.log("ALARM="+stack_alarm_titles);
        console.log("SETINGS="+stack_setting_titles);
        console.log("--------------------------------------\n\n");
        pageSettings.anBackPage();
    }

    Rectangle
    {
        id:root;
        anchors.fill: parent;
        color:cBG;
    }

    //sync and api things.
//    property string accessKey_api_v1: GetApiInfo.get_AccessKey_Api_v1();//"c329e3fecf44130943a9e8adf1ae7872f3e909ec6672501472aa415da23cc509NEIN";
//    property string private_url_api: GetApiInfo.get_api_url();//"http://www.mewware.com/timer1-api-v1/v1-private/";


    property int iconWidthAndHeight: mainWindow.width<700? 40:50; //for button iconBackToHome &  iconSettings
    property int fontSizeTitles: mainWindow.width<700 ? 45:65;
    property int swipeLunchIndex: 0; //BUG FOR MYNEWINDICATOR , the indicator dont current index
    property variant global_errors; //error list. syntax : "error/warning id/number"

    //- - - - - - - - - - - - - - - - - - - - - - set theme, default light mode colors
    property bool themeDarkMode:false;
    property string stack_event_titles: "EG/"; //keys = EG(evengroup) , E(event) , N(new), M(minimenu), DS(start date picker), CS(start clcok picker), DE(end date picker), CE(end clock picker), NE(new form as Edit)
    property string stack_log_titles: "L/";// keys = L(log), M(Message), N(new), E(element selected (miniMenu)), NE(new form as Edit), EM(edit message)
    property string stack_alarm_titles: "A/"; //A(alarm), N(new) , C(combobox), E(editing alarm)
    property string stack_setting_titles: ""; //key= S(setting)

//    property string stack_calendar_titles: "Calendar";
//    property string stack_timer_titles: "Timer";
//    property string stack_multiTimer_titles: "MultiTimer";
//    property string stack_stopwatch_titles: "StopWatch";
//    property string stack_sportTimer_titles:"SportTimer";


    property color cTxt_normal : "black";
    property color cTxt_title : "#3E386C";
    property color cBG : "#dedede";//"#F6F6F6";
    property color cBG_element: "white";
    property color cTxt_button : "black";
    property color cBG_button : "#B178FF";
    property color cBG_button_activated: "#B178FF";
    property color cBG_button_deactivated: "#EBDDFF";
    property string gFontFamily:"Courier";
    property color cBG_Unknown: "transparent";
    property color cUnknown: "white";
    Material.foreground: cTxt_button;

    onThemeDarkModeChanged:
    {
        const tempIndex = viewTimers.currentIndex; // to avoid when themeSwitched, the swipeIndex into 0
        myIndicator.refreshIcons();
        myIndicator.sayCurrentIndex = tempIndex;
    }


    // - - - component for save the themeDarkLight

    //load theme Mode:
    Component.onCompleted:
    {
        console.log("lunch stats: \n"
                    +"swipeLunchIndex="+swipeLunchIndex
                    +"themedark="+themeDarkMode);
        viewTimers.setCurrentIndex(swipeLunchIndex);

        if(LoadSettings.get("darkmode", "Hello World")==='1' || LoadSettings.get("darkmode", "Hello World")=== 1)
        {
            themeDarkMode = true;
            cTxt_normal = "black";
            cTxt_title = "#3E386C";
            cBG = "#23272A";//darked
            cBG_element= "#565578";//darked
            cTxt_button = "white";//darked
            cBG_button = "#7289DA";//darked
            cBG_button_activated= "#7289DA";//darked
            cBG_button_deactivated= "#313447";//"gray";//darked
            gFontFamily="Courier";//ok
            cBG_Unknown= "transparent";
            cUnknown = "white";//o99AAB5k
            path_to_menuIcons= directory_Icons + direcotry_WhiteIcons;
        }
        else
        {
            themeDarkMode = false;
            cTxt_normal = "black";
            cTxt_title = "#3E386C";
            cBG = "#dedede";
            cBG_element= "white";
            cTxt_button = "black";
            cBG_button = "#B178FF";
            cBG_button_activated = "#B178FF";
            cBG_button_deactivated = "#dcd3e8";
            gFontFamily ="Courier";
            cBG_Unknown = "transparent";
            cUnknown = "white";
            path_to_menuIcons= directory_Icons + direcotry_BlackIcons;
        }
    }


    //- - - - - - - - - - - - - - - - - - - - - - icons
    property string directory_Icons: "../thePictures/";
    property string direcotry_BlackIcons: "dark-25px/";
    property string direcotry_WhiteIcons: "white-25px/";
    property string path_to_menuIcons: directory_Icons + direcotry_BlackIcons;//(!themeDarkMode? direcotry_BlackIcons:direcotry_WhiteIcons);

    //dark/light switch icons
    property string fileIcon_DarkMode: "icon-darkmode.png";
    property string fileIcon_LightMode: "icon-lightmode.png";


    //my inidcator icons
    property string fileIcon_Alarm: "icon-alarm.png";
    property string fileIcon_Countdown: "icon-countdown.png";
    property string fileIcon_Stopwatch: "icon-stopwatch.png";
    property string fileIcon_Calender: "icon-calender.png";
    property string fileIcon_Event: "icon-event.png";
    property string fileIcon_Log: "icon-log.png";
    property string fileIcon_MultiTimer: "icon-multi-timer.png";
    property string fileIcon_SportTimer: "icon-sport-timer.png";

    //calender icons
    property string fileIcon_BackNext: "icon-back-next.png";

    //alarm(TimerDown.qml) icons
    property string fileIcon_Cancel: "icon-cancel.png";

    property string fileIcon_backToHome: "icon-back.png"; //NOT FOUND NOT USED


    //sportTimer Icons
    property string fileIcon_Mute: "icon-mute.png";
    property string fileIcon_Unmute: "icon-unmute.png";
    property string fileIcon_Settings: "icon-settings.png";
    property string fileIcon_Reset: "icon-reset.png";

    //event icons
    property string fileIcon_pickClock: "icon-clock.png";
    property string fileIcon_pickDate: "icon-pickDate.png";

    //Log Icons
    property string fileIcon_Send: "icon-send.png";


    //Modifing Icons
    property string fileIcon_Delete: "icon-delete.png";
    property string fileIcon_Edit: "icon-edit.png";

    //MimiMenu
    property string fileIcon_Copy: "icon-copy.png";
    property string fileIcon_Bold: "icon-bold.png";
    property string fileIcon_Italic: "icon-italic.png";
    property string fileIcon_Underline: "icon-underline.png";
    property string fileIcon_Strikeout: "icon-strikeout.png";
    property string fileIcon_Checked: "icon-checked.png";
    property string fileIcon_Archive: "icon-archive.png";

    //- - - - - - - - - - - - - - - - - - - - - - sound effects
    //- - sportTimer:
    property string directory_Sounds: "../theSounds/";
    property string directory_sportTimer_SoundEffects: "sportTimer/sound-effects/";
    property string directory_SoundEffect_PackA: "sound-pack-a/";

    property string fileAudio_timerStarted: "started.wav";
    property string fileAudio_timerStopped: "stopped.wav";
    property string fileAudio_roundStarted: "round-started.wav";
    property string fileAudio_roundStopped: "round-stopped.wav";
    property string fileAudio_breakStarted: "break-started.wav";
    property string fileAudio_breakStopped: "break-stopped.wav";

    property string path_to_sportTimer_SoundEffect: "../"+ directory_Sounds + directory_sportTimer_SoundEffects;//innder directory ../


    //- - - - - - - singleTimer
    property string fileAudio_elevatorTone: "mixkit-elevator-tone-2863.wav";



    //- - - - - - - - - - - - - - - - - - - - - - sound speech
    property string directory_sportTimer_SoundSpeech: "sportTimer/sound-speech/";
    property string directory_SoundSpeech_PackA: "sound-pack-male-joey/"; //MALE , by ttsmp3.com , US English Joey
    property string directory_sportTimer_SoundSpeech_Numbers: "numbers/";

    property string fileAudio_speech_start: "start.wav";
    property string fileAudio_speech_stop: "stop.wav";
    property string fileAudio_speech_rest: "rest.wav";
    property string fileAudio_speech_set: "set.wav";
    property string fileAudio_speech_go: "go.wav";
    property string fileAudio_speech_cheer: "cheer.wav";
    property string fileAudio_speech_ready: "ready.wav";

    property string fileAudio_speech_hour: "hour.wav";
    property string fileAudio_speech_minute: "minute.wav";
    property string fileAudio_speech_second: "second.wav";

    property string fileAudio_speech_hours: "hours.wav";
    property string fileAudio_speech_minutes: "minutes.wav";
    property string fileAudio_speech_seconds: "seconds.wav";

    property variant fileAudio_speech_numbers:
        ["0","1.wav","2.wav","3.wav","4.wav","5.wav","6.wav","7.wav","8.wav","9.wav","10.wav",
        "11.wav","12.wav","13.wav","14.wav","15.wav","16.wav","17.wav","18.wav","19.wav","20.wav",
        "21.wav","22.wav","23.wav","24.wav","25.wav","26.wav","27.wav","28.wav","29.wav","30.wav",
        "31.wav","32.wav","33.wav","34.wav","35.wav","36.wav","37.wav","38.wav","39.wav","40.wav",
        "41.wav","42.wav","43.wav","44.wav","45.wav","46.wav","47.wav","48.wav","49.wav","50.wav",
        "51.wav","52.wav","53.wav","54.wav","55.wav","56.wav","57.wav","58.wav","59.wav","60.wav",
        "61.wav","62.wav","63.wav","64.wav","65.wav","66.wav","67.wav","68.wav","69.wav","70.wav",
        "71.wav","72.wav","73.wav","74.wav","75.wav","76.wav","77.wav","78.wav","79.wav","80.wav",
        "81.wav","82.wav","83.wav","84.wav","85.wav","86.wav","87.wav","88.wav","89.wav","90.wav",
        "91.wav","92.wav","93.wav","94.wav","95.wav","96.wav","97.wav","98.wav","99.wav","100.wav"];


    property string fileAudio_speech_left: "left.wav";
    property string fileAudio_speech_passed: "passed.wav";


    property string path_to_sportTimer_SoundSpeech: "../" + directory_Sounds + directory_sportTimer_SoundSpeech;





   Rectangle
   {
       id:menuBar;
       width: root.width;
       height:root.height/15;
       anchors.top:root.top;
       color:cBG;
       z:5;
       MyMenu
       {
            id:myMenu;
            cBGMenu: viewTimers.currentIndex ===0 ? cBG_button: cBG;
            colorTextMenu:cTxt_button;
            textTitleMenu:appTitle;
            onSignalOpenMenu:
            {
                if(pageSettings.visible)
                {
                    UpdateSwipeViewIndexesAsIndicator.setIndexTitleBarFromSwipeView(viewTimers.currentIndex);
                    //invise all set pages becuase of : when app is in a setpage and button openMenu/settings clicked set page still open but upside of a list/or/etc/... so i decide to invise all setpages to avoid this
                    baseAlarmSet.visible =  baseLogSet.visible = baseEventGroupSet.visible = baseEventSet.visible = pageSettings.visible=false;

                    //and when app is in setpage setEventPage the myIndicatorBase will invise so in this case after menu open&close the inidicator will keep inivse!
                    myIndicatorBase.visible=true;
                    viewTimers.interactive=true;
                    viewTimers.visible=true;

                }
                else
                {
                    stack_setting_titles = "S/";
                    pageSettings.visible=true;
                    viewTimers.interactive=false;
                    viewTimers.visible=false;
                }
            }
       }

   }

    //swipe base Timer starts
    Rectangle
    {
        id:baseTimers;
        visible: true;
        clip: true;
        color:cBG;
        anchors
        {
            top:menuBar.bottom;
            left:root.left;
            right:root.right;
            bottom:myIndicatorBase.top;
        }

        Item
        {
            id:itemBaseViewTimers

            SwipeView
            {
                id: viewTimers
                currentIndex:0;
                width: baseTimers.width;
                height:baseTimers.height/100*99;
                onCurrentIndexChanged:
                {
                    myIndicator.sayCurrentIndex = viewTimers.currentIndex;
                    UpdateSwipeViewIndexesAsIndicator.setIndexTitleBarFromSwipeView(currentIndex);
                }


                Page
                {
                    id:calenderPage;
                    CalenderPage
                    {

                    }
                }

                Page
                {
                    EventGroupsPage
                    {
                        id: eventGroupPage;
                        onGoToEventGroupSetPage:
                        {
                            if(eventGroupPage.flag_editElement>0)
                            {
                                pageEventGroupSet.updateModeData = eventGroupPage.selectedItemData;
                                flag_editElement=0;
                                resetValueMiniMenuEditDelete();
                                pageEventGroupSet.updateModeEnabledActions();
                            }

                            baseEventGroupSet.visible=true;
                            viewTimers.interactive=false;
                            viewTimers.visible=false;
                            myIndicatorBase.visible=false;
                        }
                        onGoToEventSetPage:
                        {
                            pageEventSet.theEventGroupId = selectedEventGroupId;
                            baseEventSet.visible=true;
                            viewTimers.interactive=false;
                            viewTimers.visible=false;
                            myIndicatorBase.visible=false;
                        }
                    }
                }


                Page
                {
                    LogsPage
                    {
                        id: logsPage;
                        onGoToLogSetPage:
                        {
                            if(logsPage.flag_editElement>0)
                            {
                                pageLogSet.updateModeData = logsPage.selectedItemData;
                                flag_editElement=0;
                                resetValueMiniMenuEditDelete();
                                pageLogSet.updateModeEnabledActions();
                            }

                            baseLogSet.visible=true;
                            viewTimers.interactive=false;
                            viewTimers.visible=false;
                            myIndicatorBase.visible=false;
//                            pageAlarmSet.resetValues(); wTF IS THIS???????????????????????????????
                        }
                    }
                }

                Page
                {
                    Alarm
                    {
                        id:alarmPage;
                        onGoToAlarmSetPage:
                        {
                            if(alarmPage.flag_editElement>0)
                            {
                                pageAlarmSet.updateModeData = alarmPage.selectedItemData;
                                flag_editElement=0;
//                                resetValueMiniMenuEditDelete();
                                pageAlarmSet.updateModeEnabledActions();
                            }
                            baseAlarmSet.visible=true;
                            viewTimers.interactive=false;
                            viewTimers.visible=false;
                        }
                    }
                }

                Page
                {
                    id: singleTimerPage;
                    SingleTimer
                    {
                        id:singleTimer;
                        visible:false;
                        onCancelTimer:
                        {
                            singleTimer.visible=false;
                            singleTimerSetPage.visible=true;
                        }
                    }
                    SingleTimerSetPage
                    {
                        id:singleTimerSetPage;
                        onButtonStartClicked:
                        {
                            singleTimer.baseTime[0] = singleTimerSetPage.selectHour;
                            singleTimer.baseTime[1] = singleTimerSetPage.selectMinute;
                            singleTimer.baseTime[2] = singleTimerSetPage.selectSecond;
                            singleTimerSetPage.visible=false;
                            singleTimer.visible=true;
                            singleTimer.runTimer();
                        }
                    }

                }//end of page 3 , single timer.

                Page
                {
                    id:sportTimerPage;
                    SportTimer
                    {
                        id:sportTimer;
                        visible: false;//example command, for test github
                        onSportTimerEnded:
                        {
                            sportTimer.visible=false;
                            sportTimerSetPage.visible=true;
                        }
                    }
                    SportTimerSetPage
                    {
                        id:sportTimerSetPage;
                        onStartSportTimer:
                        {
                            sportTimerSetPage.visible=false;
                            sportTimer.visible=true;

                            sportTimer.setRounds = repeatValue[0];


                            sportTimer.setTimePerRound[0] =  roundValues[0];
                            sportTimer.setTimePerRound[1] =  roundValues[1];
                            sportTimer.setTimePerRound[2] =  roundValues[2];

                            sportTimer.setBreaks[0] =  breakValues[0];
                            sportTimer.setBreaks[1] =  breakValues[1];
                            sportTimer.setBreaks[2] =  breakValues[2];


                            sportTimer.setCountDownBeforeRoundStart = statusCDBeforeRoundStart;
                            if(statusCDBeforeRoundStart) //to avoid invalid value , == 0 or >= breaks values convert to second
                            {
                                var tempMin = breakValues[0] * 60;
                                tempMin += breakValues[1];
                                var tempSec = breakValues[2];
                                tempSec += tempMin * 60;
                                if(secondsCDBeforeRoundSTart === 0 || secondsCDBeforeRoundSTart >= tempSec)
                                    sportTimer.setSecondsCountDownBeforeRoundStart = 3;
                                else
                                    sportTimer.setSecondsCountDownBeforeRoundStart = secondsCDBeforeRoundSTart;

                            }


                            sportTimer.setSpeechOn = statusSpeech;
                            sportTimer.setSoundEffectsOn =statusSoundEffect;

                            sportTimer.startTheMainTimer();

                        }
                    }
                }//end of sportTimer page

                Page
                {
                    id: stopWatchPage;
                    StopWatch
                    {

                    }
                }


                Page
                {
                    id:multiTimerPage;
                    Rectangle
                    {
                        anchors.fill: parent;
                        color:"pink";
                    }
                }//end of page 4,
            }
        }



    }
    //swipe base timer ends



    //timer indicator starts
    Rectangle
    {
        id:myIndicatorBase;
        width:parent.width;
        anchors.bottom:root.bottom;
        height:80;
        color:cBG;
        anchors.horizontalCenter: parent.horizontalCenter;

        MyNewIndicator
        {
            id:myIndicator;
            onSayCurrentIndexChanged:
            {
                viewTimers.currentIndex = sayCurrentIndex;
            }
        }
    }
    //timer indicator ends


    Rectangle
    {
        id:baseAlarmSet;
        anchors.fill: parent;
        anchors.topMargin: menuBar.height;
        color:cBG_Unknown;
        visible: false;
        z:4;


        AlarmSetPage
        {
            id:pageAlarmSet;
            onBtnCancel:
            {
                baseAlarmSet.visible=false;
                viewTimers.interactive=true;
                viewTimers.visible=true;
            }
            onUpdateAlarmListModel:
            {
                alarmPage.refreshListModel();
            }
        }
    }

    Rectangle
    {
        id:baseLogSet;
        anchors.fill: parent;
        anchors.topMargin: menuBar.height;
        color:cBG_Unknown;
        visible: false;
        z:4;
        LogSetPage
        {
            id:pageLogSet;
            onBtnCancel:
            {
                baseLogSet.visible=false;
                viewTimers.interactive=true;
                viewTimers.visible=true;
                myIndicatorBase.visible=true;
            }
            onUpdateLogsListModel:
            {
                logsPage.refreshListModel();
            }

        }
    }


    Rectangle
    {
        id:baseEventGroupSet;
        anchors.fill: parent;
        anchors.topMargin: menuBar.height;
        color:cBG_Unknown;
        visible: false;
        z:4;
        EventGroupSetPage
        {
            id:pageEventGroupSet;
            onBtnCancel:
            {
                baseEventGroupSet.visible=false;
                viewTimers.interactive=true;
                viewTimers.visible=true;
                myIndicatorBase.visible=true;
            }
            onUpdateLogsListModel:
            {
                eventGroupPage.refreshListModel();
            }

        }
    }


    Rectangle
    {
        id:baseEventSet;
        anchors.fill: parent;
        anchors.topMargin: menuBar.height;
        color:cBG_Unknown;
        visible: false;
        z:4;
        EventSetPage
        {
            id:pageEventSet;
            onBtnCancel:
            {
                baseEventSet.visible=false;
                viewTimers.interactive=true;
                viewTimers.visible=true;
                myIndicatorBase.visible=true;
            }
            onUpdateLogsListModel:
            {
                eventGroupPage.refreshTheEventsPage();
            }


        }
    }

    SettingsPage
    {
        id:pageSettings;
        visible: false;
        z:5;
    }
}//end of window
