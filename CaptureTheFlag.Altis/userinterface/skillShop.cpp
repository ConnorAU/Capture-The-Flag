class CaptureTheFlag_UI_SkillShop {
    idd=-1;
    enableSimulation=1;
    movingEnable=0;
    name="CaptureTheFlag_UI_SkillShop";
    onLoad="_this call (missionnamespace getvariable ['CaptureTheFlag_c_shop_skill_init',{}]);";

    #define SK_MAIN_W 0.6
    #define SK_MAIN_H 0.401111
    #define SK_BUTTON_H 0.04

    class controls {
        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            style=2;
            text="Manage your Skills";

            sizeEx=SZ_sizeEx_04;
            x=SZ_centerXA(SK_MAIN_W);
            y=SZ_centerYA(SK_MAIN_H)-SK_BUTTON_H;
            w=(SK_MAIN_W);
            h=(SK_BUTTON_H);

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class exitButton: CaptureTheFlag_3DEN_ctrlButton {
            idc=2;
            style=2;
            text="Exit Menu";

            sizeEx=SZ_sizeEx_04;
            x=SZ_centerXA(SK_MAIN_W);
            y=SZ_centerYA(SK_MAIN_H)+SK_MAIN_H;
            w=(SK_MAIN_W);
            h=(SK_BUTTON_H);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
    };
    class controlsBackground {
        class container: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
            x=SZ_centerXA(SK_MAIN_W);
            y=SZ_centerYA(SK_MAIN_H);
            w=(SK_MAIN_W);
            h=SK_MAIN_H+SK_BUTTON_H;

            class controls {
                class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
                    w=(SK_MAIN_W);
                    h=SK_MAIN_H+SK_BUTTON_H;

                    colorBackground[]={0,0,0,0.6};
                };
                class scollerContainer: CaptureTheFlag_3DEN_ctrlControlsGroup {
                    idc=3;

                    w="0.599001";
                    h=(SK_MAIN_H);

                    class controls {
                        class maintainWidthScrollBarCtrl: CaptureTheFlag_3DEN_ctrlStaticBackground {
                            idc=1;

                            colorBackground[]={0,0,0,0};
                        };
                    };
                };
            };
        };
    };
};
