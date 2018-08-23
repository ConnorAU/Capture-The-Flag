class CaptureTheFlag_UI_PlayerMenu {
    idd=-1;
    movingEnable=0;
    enableSimulation=1;
    name="CaptureTheFlag_UI_PlayerMenu";
    onLoad="['init',_this] call (missionNameSpace getvariable ['CaptureTheFlag_c_ui_playerMenu',{}])";

    class controls {

        #define PM_BUTTON_H 0.04
        #define PM_MAIN_W 0.3
        #define PM_MAIN_H (PM_BUTTON_H*7)

        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            style=2;
            text="Player Menu";
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(PM_MAIN_W);
            y=SZ_centerYA(PM_MAIN_H)-PM_BUTTON_H;
            w=(PM_MAIN_W);
            h=(PM_BUTTON_H);

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
            x=SZ_centerXA(PM_MAIN_W);
            y=SZ_centerYA(PM_MAIN_H);
            w=(PM_MAIN_W);
            h=PM_MAIN_H;

            colorBackground[]={0,0,0,0.6};
        };
        class button1: CaptureTheFlag_3DEN_ctrlButton {
            idc=1;
            style=2;
            text="Groups";
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(PM_MAIN_W);
            y=SZ_centerYA(PM_MAIN_H)+(PM_BUTTON_H*0);
            w=(PM_MAIN_W);
            h=(PM_BUTTON_H);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class button2: button1 {
            idc=2;
            text="Settings";

            y=SZ_centerYA(PM_MAIN_H)+(PM_BUTTON_H*1);
        };
        class button3: button1 {
            idc=3;
            text="Force Sync";

            y=SZ_centerYA(PM_MAIN_H)+(PM_BUTTON_H*2);
        };
        class button4: button1 {
            idc=4;
            text="Controls & Rules";

            y=SZ_centerYA(PM_MAIN_H)+(PM_BUTTON_H*3);
        };
        class button5: button1 {
            idc=5;
            text="Created by Connor";

            y=SZ_centerYA(PM_MAIN_H)+(PM_BUTTON_H*4);

            url="https://steamcommunity.com/id/_connor/";
        };
        class button6: button1 {
            idc=6;
            text="GitHub Repository";

            y=SZ_centerYA(PM_MAIN_H)+(PM_BUTTON_H*5);

            url="https://github.com/ConnorAU/Capture-The-Flag";
        };
        class button7: button1 {
            idc=7;
            text="Exit Menu";

            y=SZ_centerYA(PM_MAIN_H)+(PM_BUTTON_H*6);
        };

        #undef PM_BUTTON_H
        #undef PM_MAIN_W
        #undef PM_MAIN_H

    };
};
