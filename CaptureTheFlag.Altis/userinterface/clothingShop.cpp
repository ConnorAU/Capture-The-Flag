class CaptureTheFlag_UI_ClothingShop {
    idd=-1;
    enableSimulation=1;
    movingEnable=0;
    name="CaptureTheFlag_UI_ClothingShop";
    onLoad="_this call (missionnamespace getvariable ['CaptureTheFlag_c_shop_clothing_init',{}]);";

    #define C_MAIN_W 0.6
    #define C_MAIN_H 0.361111
    #define C_BUTTON_H 0.04
    #define C_3 0.3

    class controls {
        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=1;
            style=2;
            text="Change My Appearance";
            sizeEx=SZ_sizeEx_04;

            x=SZ_centerXA(C_MAIN_W);
            y=SZ_centerYA(C_MAIN_H)-C_BUTTON_H;
            w=(C_MAIN_W);
            h=(C_BUTTON_H);

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class exitButton: CaptureTheFlag_3DEN_ctrlButton {
            idc=2;
            style=2;
            text="Exit Menu";

            sizeEx=SZ_sizeEx_04;
            x=SZ_centerXA(C_MAIN_W);
            y=SZ_centerYA(C_MAIN_H)+C_MAIN_H;
            w=(C_MAIN_W);
            h=(C_BUTTON_H);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
    };
    class controlsBackground {
        class container: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
            x=SZ_centerXA(C_MAIN_W);
            y=SZ_centerYA(C_MAIN_H);
            w=(C_MAIN_W);
            h=C_MAIN_H+C_BUTTON_H;

            class controls {
                class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
                    x="0";
                    y="0";
                    w=(C_MAIN_W);
                    h=C_MAIN_H+C_BUTTON_H;

                    colorBackground[]={0,0,0,0.6};
                };
                class scollerContainer: CaptureTheFlag_3DEN_ctrlControlsGroup {
                    idc=10;

                    x="0";
                    y="0";
                    w="0.599001";
                    h="0.0888887";

                    class VScrollBar: VScrollBar {
                        width="0";
                    };
                    class HScrollBar: HScrollBar {
                        height="0.013468";
                    };
                };
                class selectedUniform: CaptureTheFlag_3DEN_ctrlButtonPictureKeepAspect {
                    idc=20;

                    x="0";
                    y="0.0888887";
                    w="0.15";
                    h="0.23";

                    colorBackground[]={0,0,0,0};
                    colorBackgroundDisabled[]={0,0,0,0};
                    colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                };
                class selectedVest: selectedUniform {
                    idc=21;

                    x="0.15";
                };
                class selectedHat: selectedUniform {
                    idc=22;

                    x=(C_3);
                };
                class selectedEyes: selectedUniform {
                    idc=23;

                    x="0.45";
                };
                class purchaseButton: CaptureTheFlag_3DEN_ctrlButton {
                    idc=30;
                    style=2;

                    sizeEx=SZ_sizeEx_04;
                    x="0";
                    y="0.318889";
                    w=(C_3);
                    h="0.04";

                    colorBackground[]={0,0,0,0};
                    colorBackgroundDisabled[]={0,0,0,0};
                    colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    font="RobotoCondensed";
                };
                class setAsLoadout: purchaseButton {
                    idc=31;

                    x=(C_3);
                };
            };
        };
    };

    #undef C_MAIN_W
    #undef C_MAIN_H
    #undef C_BUTTON_H

};
