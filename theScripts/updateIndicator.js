
function setIndexActive(a_Active,b_Diactive,c_Diactive,d_Diactive)//, a_icon,b_icon,c_icon,d_icon, icon)
{
    a_Active.color = cBG_button;
    b_Diactive.color = cBG_button_deactivated;
    c_Diactive.color = cBG_button_deactivated;
    d_Diactive.color = cBG_button_deactivated;

//    console.log(a_icon.source);// = directory_Icons+direcotry_WhiteIcons+icon;
}


function setIndexTitleBarFromSwipeView(indexValue)
{
    switch(indexValue)
    {
        case 0: appTitle = "Calendar"; break;
        case 1: appTitle = "Event"; break;
        case 2: appTitle = "Log"; break;
        case 3: appTitle = "Alarm"; break;
        case 4: appTitle = "Timer"; break;
        case 5: appTitle = "Sport Timer"; break;
        case 6: appTitle = "StopWatch"; break;
        case 7: appTitle = "Multi Timer"; break;
        default: appTitle = "pLarm"; break;
    }
}
