#define PREFIX "\x05[xG]"
#define COLOUR "\x05"

stock void PrintMessage(int client, const char[] phrase) {
	PrintToChat(client, "%s %t.", PREFIX, phrase);
}
stock void PrintMessageTI1(int client, const char[] phrase, int intArg) {
	PrintToChat(client, "%s%t.", PREFIX, phrase, intArg);
}

stock void PrintMessageEx(int client, const char[] phrase) {
	PrintToChat(client, "%s%t.", COLOUR, phrase);
}
stock void PrintMessageExTI1(int client, const char[] phrase, int intArg) {
	PrintToChat(client, "%s%t.", COLOUR, phrase, intArg);
}

stock void PrintMessageAll(const char[] phrase) 
{
	for (int client = 1; client <= MaxClients; client++) 
	{
		if (IsClientInGame(client))
		{
			PrintMessage(client, phrase);
		}
	}
}

stock void PrintMessageAllEx(const char[] phrase) 
{
	for (int client = 1; client <= MaxClients; client++) 
	{
		if (IsClientInGame(client))
		{	
			PrintMessageEx(client, phrase);
		}
	}
}

stock void PrintMessageAllTS1(char[] transString, char[] stringArg) 
{
	for (int client = 1; client <= MaxClients; client++) 
	{
		if (IsClientInGame(client))
		{	
			PrintToChat(client, "%s %t!", PREFIX, transString, stringArg);	
		}
	}
}

stock void PrintMessageAllTI1(char[] transString, int intArg) 
{
	for (int client = 1; client <= MaxClients; client++)
	{
		if (IsClientInGame(client))
		{
			PrintToChat(client, "%s %t!", PREFIX, transString, intArg);
		}
	}	
}
