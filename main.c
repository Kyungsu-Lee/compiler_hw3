#include "read_file.h"
#include "Parser.h"
#include "Lexer.h"

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[])
{
	yyparse();
	
	FILE *yyin = fopen(argv[1],"r");
	char str[10];

	while(yyin!=NULL && strcmp(str,"QUIT"))
	{
		fgets(str,sizeof(str),stdin);
		str[strlen(str)-1]='\0';
		char c=str[0];

		switch(instruction(str))
		{
			case 0:	command_list(yyin);		break;
			case 1: command_run();			break;
			case 2:	command_quit();			break;
			case 3:	command_line(yyin, str);	break;
			default: printf("wrong command\n");
		}
	}
	fclose(yyin);
}
