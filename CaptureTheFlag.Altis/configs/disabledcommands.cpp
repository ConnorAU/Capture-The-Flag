/*
    COMMANDS: CREATEUNIT, CALLEXTENSION, HINT
*/

class CfgDisabledCommands
{
    class CREATEUNIT
    {
        class SYNTAX1
        {
            targets[] = {0,0,0};
            args[] = {{"STRING"},{"ARRAY"}};
        };

        class SYNTAX2
        {
            targets[] = {1,0,0};
            args[] = {{"GROUP"},{"ARRAY"}};
        };
    };
    class CALLEXTENSION
    {
        class SYNTAX1
        {
            targets[] = {1,0,0};
            args[] = {{"STRING"},{"STRING"}};
        };

        class SYNTAX2
        {
            targets[] = {1,0,0};
            args[] = {{"STRING"},{"ARRAY"}};
        };
    };
};