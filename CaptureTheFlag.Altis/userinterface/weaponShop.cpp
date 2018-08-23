class CaptureTheFlag_UI_WeaponShop {
    idd=-1;
    enableSimulation=1;
    movingEnable=0;
    name="CaptureTheFlag_UI_WeaponShop";
    onLoad="_this call (missionnamespace getvariable ['CaptureTheFlag_c_shop_weapon_init',{}]);";

    #define W_MAIN_W 0.6
    #define W_MAIN_H 0.401111
    #define W_BUTTON_H 0.04
    #define W_1(n) (0.1*n)

    class controls {
        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=1;
            style=2;
            text="Choose Your Weapons";

            sizeEx=SZ_sizeEx_04;
            x=SZ_centerXA(W_MAIN_W);
            y=SZ_centerYA(W_MAIN_H)-W_BUTTON_H;
            w=(W_MAIN_W);
            h=(W_BUTTON_H);

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class exitButton: CaptureTheFlag_3DEN_ctrlButton {
            idc=2;
            style=2;
            text="Exit Menu";

            sizeEx=SZ_sizeEx_04;
            x=SZ_centerXA(W_MAIN_W);
            y=SZ_centerYA(W_MAIN_H)+W_MAIN_H;
            w=(W_MAIN_W);
            h=(W_BUTTON_H);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
    };
    class controlsBackground {
        class container: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
            x=SZ_centerXA(W_MAIN_W);
            y=SZ_centerYA(W_MAIN_H);
            w=(W_MAIN_W);
            h=W_MAIN_H+W_BUTTON_H;

            class controls {
                class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
                    x="0";
                    y="0*safezoneH";
                    w=(W_MAIN_W);
                    h=W_MAIN_H+W_BUTTON_H;

                    colorBackground[]={0,0,0,0.6};
                };
                class primaryButton: CaptureTheFlag_3DEN_ctrlButton {
                    idc=10;
                    style=2;

                    sizeEx=SZ_sizeEx_04;
                    x="0";
                    y="0";
                    w=W_1(2);
                    h=(W_BUTTON_H);

                    colorBackground[]={0,0,0,0};
                    colorBackgroundDisabled[]={0,0,0,0};
                    colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    font="RobotoCondensed";
                };
                class launcherButton: primaryButton {
                    idc=11;

                    x=W_1(2);
                };
                class handgunButton: primaryButton {
                    idc=12;

                    x=W_1(4);
                };
                class scollerContainer: CaptureTheFlag_3DEN_ctrlControlsGroup {
                    idc=15;

                    x="0";
                    y=(W_BUTTON_H);
                    w="0.599001";
                    h="0.0888887";

                    class VScrollBar: VScrollBar {
                        width=0;
                    };
                    class HScrollBar: HScrollBar {
                        height="0.013468";
                    };
                };
                class selectedWeapon: CaptureTheFlag_3DEN_ctrlButtonPictureKeepAspect {
                    idc=20;

                    x="0";
                    y="0.128889";
                    w=W_1(3);
                    h=W_1(2.3);

                    colorBackground[]={0,0,0,0};
                    colorBackgroundDisabled[]={0,0,0,0};
                    colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                };
                class selectedOptic: selectedWeapon {
                    idc=21;

                    x=W_1(3);
                    w=W_1(1.5);
                    h=W_1(1.15);
                };
                class selectedPointer: selectedOptic {
                    idc=22;

                    y="0.243889";
                };
                class selectedMuzzle: selectedOptic {
                    idc=23;

                    x=W_1(4.5);
                };
                class selectedBipod: selectedMuzzle {
                    idc=24;

                    y="0.243889";
                };
                class purchaseButton: CaptureTheFlag_3DEN_ctrlButton {
                    idc=30;
                    style=2;

                    sizeEx=SZ_sizeEx_04;
                    x="0";
                    y="0.358889";
                    w=W_1(3);
                    h=(W_BUTTON_H);

                    colorBackground[]={0,0,0,0};
                    colorBackgroundDisabled[]={0,0,0,0};
                    colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    font="RobotoCondensed";
                };
                class setAsLoadout: purchaseButton {
                    idc=31;

                    x=W_1(3);
                };
            };
        };
    };

    #undef W_MAIN_W
    #undef W_MAIN_H
    #undef W_BUTTON_H
    #undef W_1

};
