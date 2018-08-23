class CaptureTheFlag_UI_Settings {
    idd=-1;
    enableSimulation=1;
    movingEnable=0;
    name="CaptureTheFlag_UI_Settings";
    onLoad="['settingsLoad',_this] call (missionnamespace getvariable ['CaptureTheFlag_c_ui_playerMenu',{}])";

    class controls {

        #define S_W 0.4
        #define S_H 0.4
        #define S_04 0.04
        #define S_01N(n) (0.01+(0.05*n))

        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            style=2;
            text="Settings";
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(S_W);
            y=SZ_centerYA(S_H)-S_04;
            w=(S_W);
            h=(S_04);

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
            x=SZ_centerXA(S_W);
            y=SZ_centerYA(S_H);
            w=(S_W);
            h=S_H+S_04;

            colorBackground[]={0,0,0,0.6};
        };
        class textContainer: CaptureTheFlag_3DEN_ctrlControlsGroup {
            x=SZ_centerXA(S_W);
            y=SZ_centerYA(S_H);
            w=(S_W);
            h=(S_H);

            class controls {
                class footVDTag: CaptureTheFlag_3DEN_ctrlStaticTitle {
                    text="Foot View Distance:";
                    sizeEx=SZ_sizeEx_04;

                    x=S_01N(0);
                    y=S_01N(0);
                    w=S_01N(3)+0.03;
                    h=(S_04);

                    colorBackground[]={0,0,0,0};
                    font="RobotoCondensed";
                };
                class footVDButtonDown: CaptureTheFlag_3DEN_ctrlButton {
                    idc=10;
                    style=2;
                    text="<";

                    x=S_01N(4);
                    y=S_01N(0);
                    w=S_01N(0)+0.02;
                    h=(S_04);

                    colorBackground[]={0,0,0,0.3};
                    font="RobotoCondensed";
                };
                class footVDDisplay: CaptureTheFlag_3DEN_ctrlStaticTitle {
                    idc=11;
                    style=2;
                    sizeEx=SZ_sizeEx_04;

                    x=S_01N(4)+0.03;
                    y=S_01N(0);
                    w=S_01N(2)+0.01;
                    h=(S_04);

                    colorBackground[]={0,0,0,0.3};
                    font="RobotoCondensed";
                };
                class footVDButtonUp: footVDButtonDown {
                    idc=12;
                    text=">";

                    x=S_01N(7);
                    y=S_01N(0);
                };
                class landVDTag: footVDTag {
                    text="Land View Distance:";

                    y=S_01N(1);
                };
                class landVDButtonDown: footVDButtonDown {
                    idc=20;

                    y=S_01N(1);
                };
                class landVDDisplay: footVDDisplay {
                    idc=21;

                    y=S_01N(1);
                };
                class landVDButtonUp: footVDButtonUp {
                    idc=22;

                    y=S_01N(1);
                };
                class airVDTag: footVDTag {
                    text="Air View Distance:";

                    y=S_01N(2);
                };
                class airVDButtonDown: footVDButtonDown {
                    idc=30;

                    y=S_01N(2);
                };
                class airVDDisplay: footVDDisplay {
                    idc=31;

                    y=S_01N(2);
                };
                class airVDButtonUp: footVDButtonUp {
                    idc=32;

                    y=S_01N(2);
                };
                class terrainSmoothingTag: footVDTag {
                    text="Terrain Surface:";

                    y=S_01N(3)+0.02;
                };
                class terrainSmoothingButtonDown: footVDButtonDown {
                    idc=40;

                    y=S_01N(3)+0.02;
                };
                class terrainSmoothingDisplay: footVDDisplay {
                    idc=41;

                    y=S_01N(3)+0.02;
                };
                class terrainSmoothingButtonUp: footVDButtonUp {
                    idc=42;

                    y=S_01N(3)+0.02;
                };
                class environmentTag: footVDTag {
                    text="Enable Environment:";

                    y=S_01N(5)-0.01;
                };
                class environmentCheck: CaptureTheFlag_3DEN_ctrlCheckbox {
                    idc=50;

                    x=S_01N(5)+0.02425;
                    y=S_01N(5)-0.01;
                    w=S_01N(0)+0.0215001;
                    h=(S_04);

                    color[]={1,1,1,1};
                    textureChecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_none_ca.paa";
                    textureDisabledChecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_none_ca.paa";
                    textureDisabledUnchecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_addons_ca.paa";
                    textureFocusedChecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_none_ca.paa";
                    textureFocusedUnchecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_addons_ca.paa";
                    textureHoverChecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_none_ca.paa";
                    textureHoverUnchecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_addons_ca.paa";
                    texturePressedChecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_none_ca.paa";
                    texturePressedUnchecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_addons_ca.paa";
                    textureUnchecked="\a3\ui_f\data\gui\rsc\rscdisplaymultiplayer\sessions_addons_ca.paa";
                };
                class playerTagsTag: footVDTag {
                    text="Show Player Tags:";

                    y=S_01N(6)-0.01;
                };
                class playerTagsCheck: environmentCheck {
                    idc=60;

                    y=S_01N(6)-0.01;
                };
                class hitMarkersTag: footVDTag {
                    text="Show Hit Markers:";

                    y=S_01N(7)-0.01;
                };
                class hitmarkerCheck: environmentCheck {
                    idc=70;

                    y=S_01N(7)-0.01;
                };
            };
        };
        class exitButton: CaptureTheFlag_3DEN_ctrlButton {
            idc=1;
            style=2;
            text="Exit Menu";
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(S_W);
            y=SZ_centerYA(S_H)+S_H;
            w=(S_W);
            h=(S_04);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };

        #undef S_W
        #undef S_H
        #undef S_04
        #undef S_01N

    };
};
