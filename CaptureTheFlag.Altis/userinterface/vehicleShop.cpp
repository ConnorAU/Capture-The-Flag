class CaptureTheFlag_UI_VehicleShop {
    idd=-1;
    enableSimulation=1;
    movingEnable=0;
    name="CaptureTheFlag_UI_VehicleShop";
    onLoad="_this call (missionnamespace getvariable ['CaptureTheFlag_c_shop_vehicle_init',{}]);";

    #define V_MAIN_W 0.6
    #define V_MAIN_H 0.361111
    #define V_BUTTON_H 0.04

    class controls {
        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            style=2;
            text="Select a Vehicle";

            sizeEx=SZ_sizeEx_04;
            x=SZ_centerXA(V_MAIN_W);
            y=SZ_centerYA(V_MAIN_H)-V_BUTTON_H;
            w=(V_MAIN_W);
            h=(V_BUTTON_H);

            colorBackground[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class exitButton: CaptureTheFlag_3DEN_ctrlButton {
            idc=1;
            style=2;
            text="Exit Menu";

            sizeEx=SZ_sizeEx_04;
            x=SZ_centerXA(V_MAIN_W);
            y=SZ_centerYA(V_MAIN_H)+V_MAIN_H;
            w=(V_MAIN_W);
            h=(V_BUTTON_H);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
    };
    class controlsBackground {
        class container: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
            x=SZ_centerXA(V_MAIN_W);
            y=SZ_centerYA(V_MAIN_H);
            w=(V_MAIN_W);
            h=V_MAIN_H+V_BUTTON_H;

            class controls {
                class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
                    x="0";
                    y="0";
                    w=(V_MAIN_W);
                    h=V_MAIN_H+V_BUTTON_H;

                    colorBackground[]={0,0,0,0.6};
                };
                class buttonTop1: CaptureTheFlag_3DEN_ctrlButton {
                    idc=10;
                    style=2;
                    text="Land Vehicles";

                    sizeEx=SZ_sizeEx_04;
                    x="0";
                    y="0";
                    w="0.2";
                    h=(V_BUTTON_H);

                    colorBackground[]={0,0,0,0};
                    colorBackgroundDisabled[]={0,0,0,0};
                    colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    font="RobotoCondensed";
                };
                class buttonTop2: buttonTop1 {
                    idc=11;
                    text="Aircraft";

                    x="0.2";
                };
                class buttonTop3: buttonTop1 {
                    idc=12;
                    text="Recent Purchases";

                    x="0.4";
                };
                class scollerContainer: CaptureTheFlag_3DEN_ctrlControlsGroup {
                    idc=15;

                    x="0";
                    y=(V_BUTTON_H);
                    w="0.599001";
                    h="0.0888891";

                    class VScrollBar: VScrollBar {
                        width=0;
                    };
                    class HScrollBar: HScrollBar {
                        height="0.013468";
                    };
                };
                class selectedImageContainer: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
                    x="0";
                    y="0.128889";
                    w="0.23";
                    h="0.23";

                    onLoad="(_this select 0)ctrlEnable false;";

                    class controls {
                        class selectedImage: CaptureTheFlag_3DEN_ctrlStaticPicture {
                            idc=20;

                            x="-0.025";
                            y="0";
                            w="0.298999";
                            h="0.23";
                        };
                    };
                };
                class selectedDetails: CaptureTheFlag_3DEN_ctrlStructuredText {
                    idc=21;

                    x="0.231";
                    y="0.128889";
                    w="0.368999";
                    h="0.15";
                    size=SZ_sizeEx_034;

                    colorBackground[]={0,0,0,0};

                    class Attributes {
                        font="RobotoCondensed";
                    };
                };
                class selectedSkinSide: CaptureTheFlag_3DEN_ctrlButton {
                    idc=22;
                    style=2;

                    sizeEx=SZ_sizeEx_04;
                    x="0.231";
                    y="0.278889";
                    w="0.1845";
                    h=(V_BUTTON_H);

                    colorBackground[]={0,0,0,0};
                    colorBackgroundDisabled[]={0,0,0,0};
                    colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
                    font="RobotoCondensed";
                };
                class selectedSkinCamo: selectedSkinSide {
                    idc=23;

                    x="0.434499";
                };
                class selectedPurchase: selectedSkinSide {
                    idc=24;
                    text="Purchase Vehicle";

                    y="0.318889";
                    w="0.368999";
                };
            };
        };
    };

    #undef V_MAIN_W
    #undef V_MAIN_H
    #undef V_BUTTON_H

};
