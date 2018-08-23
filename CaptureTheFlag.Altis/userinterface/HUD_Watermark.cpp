class CaptureTheFlag_HUD_Watermark: CaptureTheFlag_3DEN_ctrlControlsGroupNoScrollbars {

    x=(SZ_X+SZ_W)-(HUD_MAIN_W+0.015);
    y=HUD_MAIN_BLOCK_Y_FLOOR-(HUD_MAIN_H*2)+0.005;
    w=(HUD_MAIN_W);
    h=(HUD_MAIN_H);

    onLoad="['init',_this] call (missionnamespace getvariable ['CaptureTheFlag_c_ui_HUD_Watermark',{}])";

    class controls {
        class imageBlock1: CaptureTheFlag_3DEN_ctrlStaticPictureKeepAspect {
            idc=1;

            x="-0.0025";
            y="0.035";
            w="0.08";
            h="0.08";
        };
        class imageBlock2: imageBlock1 {
            idc=2;

            x="0.0675001";
        };
        class imageBlock3: imageBlock1 {
            idc=3;

            x="0.1375";
        };
        class imageBlock4: imageBlock1 {
            idc=4;

            x="0.2075";
        };

        class Title: CaptureTheFlag_3DEN_ctrlStaticTitle {
            style=2;
            text="Capture the Flag";

            x="0";
            y="0.12";
            w=(HUD_MAIN_W);
            h="0.04";
            sizeEx=SZ_sizeEx_04;

            colorBackground[]={0.2,0.2,0.2,0.05};
            colorText[]={1,1,1,0.3};
            shadow=0;
        };
        class Author: Title {
            text="by Connor";

            y="0.16";
            colorBackground[]={0.2,0.2,0.2,0.05};
        };
    };

    // defines from the main hud block
    #undef HUD_MAIN_W
    #undef HUD_MAIN_H
    #undef HUD_MAIN_BLOCK_Y_FLOOR
};