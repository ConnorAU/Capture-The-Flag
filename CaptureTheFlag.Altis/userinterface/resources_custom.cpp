class CaptureTheFlag_UI_NotifFeed_Text: CaptureTheFlag_3DEN_ctrlStructuredText {
    //size="0.012*safezonew";
	//size="0.01*safezonew";
    size="0.0242424";
};

class CaptureTheFlag_UI_VehicleShop_SliderButton: CaptureTheFlag_3DEN_ctrlButtonPicture {
	w="0.101649";
	h="0.0754211";

   	colorBackground[]={0,0,0,0};
   	colorBackgroundDisabled[]={0,0,0,0};
   	colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
   	colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
};
class CaptureTheFlag_UI_ClothingShop_SliderButton: CaptureTheFlag_UI_VehicleShop_SliderButton {
	w="0.0580851";
};
class CaptureTheFlag_UI_WeaponShop_SliderButton_Long: CaptureTheFlag_UI_VehicleShop_SliderButton {
	w="0.106071";
};
class CaptureTheFlag_UI_WeaponShop_SliderButton_Short: CaptureTheFlag_UI_ClothingShop_SliderButton {};
class CaptureTheFlag_UI_SkillShop_SkillContainer: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {
    #define SK_MAIN_W 0.1975
    #define SK_MAIN_H 0.387644
    #define SK_BUTTON_H 0.04

    w=(SK_MAIN_W);
    h=(SK_MAIN_H);

    class controls {
        class background: CaptureTheFlag_3DEN_ctrlStaticBackground {
            w=(SK_MAIN_W);
            h=(SK_MAIN_H);

            colorBackground[]={0,0,0,0.4};
        };
        class title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            idc=10;
            style=2;

            w=(SK_MAIN_W);
            h=(SK_BUTTON_H);
            sizeex=SZ_sizeEx_04;

            colorBackground[]={0,0,0,0};
        };
        class container: CaptureTheFlag_3DEN_ctrlControlsGroup {
            y=(SK_BUTTON_H);
            w=(SK_MAIN_W);
            h="0.267644";

            class HScrollBar: HScrollBar {
                height=0;
            };
            class controls {
                class img1: CaptureTheFlag_3DEN_ctrlStaticPictureKeepAspect {
                    idc=11;

                    x="0";
                    y="0.0025";
                    w="0.0395001";
                    h=(SK_BUTTON_H);
                };
                class img2: img1 {
                    idc=12;

                    x="0.0395001";
                };
                class img3: img1 {
                    idc=13;

                    x="0.079";
                };
                class img4: img1 {
                    idc=14;

                    x="0.1185";
                };
                class img5: img1 {
                    idc=15;

                    x="0.158";
                };
                class description: CaptureTheFlag_3DEN_ctrlStaticMulti {
                    idc=16;

                    y="0.045";
                    w="0.195";
                    h="0.222636";
                    sizeex=SZ_sizeEx_04;

                    colorBackground[]={0,0,0,0};
                };
            };
        };
        class upgradeButton: CaptureTheFlag_3DEN_ctrlButton {
            idc=17;
            style=2;

            sizeEx=SZ_sizeEx_04;
            x="0";
            y="0.307644";
            w=(SK_MAIN_W);
            h=(SK_BUTTON_H);

            colorBackground[]={0,0,0,0};
            colorBackgroundActive[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            colorBackgroundDisabled[]={0,0,0,0};
            colorFocused[]={"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",0.9};
            font="RobotoCondensed";
        };
        class enableButton: upgradeButton {
            idc=18;

            y="0.347644";
        };
    };

    #undef SK_MAIN_W
    #undef SK_MAIN_H
    #undef SK_BUTTON_H    
    
};
