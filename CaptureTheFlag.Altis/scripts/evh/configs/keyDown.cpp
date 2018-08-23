class KeyDown {
    blockKeyPress[]={
    //  {expression,block if expression == this}
    //  {"CaptureTheFlag_evh_keyDownBlock","true"}
    };
    class ACTION {
    // ~~ ACTION KEYS
        IngamePause="lifeState player == 'Incapacitated' OR {CaptureTheFlag_evh_blockOpenPause}";
        //ShowMap="";
        //HideMap="";
        //GetOver="";
        //salute="";
        Diary="true";
        //PushToTalk="";
        //Chat="";
        MoveForward="CaptureTheFlag_session_lastMovementTick = diag_ticktime";
        MoveBack="CaptureTheFlag_session_lastMovementTick = diag_ticktime";
        TurnLeft="CaptureTheFlag_session_lastMovementTick = diag_ticktime";
        TurnRight="CaptureTheFlag_session_lastMovementTick = diag_ticktime";
        personView="lifeState player == 'Incapacitated'";
        tacticalView="true";
    // ~~ USER ACTION KEYS (Use these to allow alternative hotkeys for events)
        //User1="";
        //User2="";
        //User3="";
        //User4="";
        //User5="";
        //User6="";
        //User7="";
        //User8="";
        //User9="";
        //User10="";
        //User11="";
        //User12="";
        //User13="";
        //User14="";
        //User15="";
        //User16="";
        //User17="";
        //User18="";
        //User19="";
        //User20="";
    };
    class DIK {
    // ~~ LETTER KEYS
        //30="";	// A
        //48="";	// B
        //46="";	// C
        //32="";	// D
        //18="";	// E
        //33="";	// F
        //34="";	// G
        35="_shift";	// H
        //23="";	// I
        //36="";	// J
        //37="";	// K
        //38="";	// L
        //50="";	// M
        //49="";	// N
        //24="";	// O
        //25="";	// P
        //16="";	// Q
        //19="";	// R
        //31="";	// S
        //20="";	// T
        //22="";	// U
        47="_shift";	// V
        //17="";	// W
        //45="";	// X
        //21="";    // Y
        //44="";	// Z

    // ~~ NUMBER KEYS
        //2="";	    // 1
        //3="";	    // 2
        //4="";	    // 3
        //5="";	    // 4
        //6="";	    // 5
        //7="";	    // 6
        //8="";	    // 7
        //9="";	    // 8
        //10="";	// 9
        //11="";	// 0
        //79="";	// NUM_1
        //80="";	// NUM_2
        //81="";	// NUM_3
        //75="";	// NUM_4
        //76="";	// NUM_5
        //77="";	// NUM_6
        //71="";	// NUM_7
        //72="";	// NUM_8
        //73="";	// NUM_9
        //82="";	// NUM_0

    // ~~ FUNCTION/OTHER KEYS
        //1="";	    // ESC
        59="true";	// F1
        60="true";	// F2
        //61="";    // F3
        //62="";	// F4
        //63="";	// F5
        //64="";	// F6
        //65="";	// F7
        //66="";	// F8
        //67="";	// F9
        //68="";	// F10
        //87="";	// F11
        //88="";	// F12
        //183="";	// PRINT
        //70="";	// SCROLL
        //197="";	// PAUSE
        41="true";    // ~
        //199="";	// POS1
        //15="";	// TAB
        //28="";	// ENTER
        //211="";	// DELETE
        //14="";	// BACKSPACE
        //210="";	// INSERT
        //207="";	// END
        //201="";	// PAGEUP
        //209="";	// PAGEDOWN
        //58="";	// CAPS
        //12="";	// ß
        //13="";	// ´
        //26="";	// Ü
        //39="";	// Ö
        //40="";	// Ä
        //43="";	// #
        //86="";	// <
        //51="";	// ,
        //52="";	// .
        //53="";	// -
        //42="";	// SHIFTL
        //54="";	// SHIFTR
        //200="";	// UP
        //208="";	// DOWN
        //203="";	// LEFT
        //205="";	// RIGHT
        //69="";	// NUM
        //181="";	// NUM_/
        //55="";	// NUM_*
        //74="";	// NUM_-
        //83="";	// NUM_,
        //156="";	// NUM_ENTER
        //29="";	// STRGL
        //157="";	// STRGR
        //220="";	// WINR
        //219="";	// WINL
        //56="";	// ALT
        57="['keyDown',_this] call CaptureTheFlag_c_ui_holdAction";    // SPACE
        //184="";	// ALTGR
        //221="";	// APP
    };
};