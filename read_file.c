#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "read_file.h"

void reset_file(FILE* file)
{
	fseek(file,0,SEEK_SET);
}

void print_file(FILE* file)
{
	int c = 0;
	while((c = getc(file)) != EOF)
		putchar(c);
}

int instruction(char* str)
{
	int i = 0;
	int j = 0;
	int flag = 1;

	if(str[0]=='<') 
	{
		if(str[strlen(str)-1]!='>'){
			printf("close with '>'\n");
		}

		else{
			for(j=1; j < strlen(str) - 2; j++)
				flag &= ('0' <= str[j]) && (str[j] <= '9');
			if(!flag)
				return -1;
			return NUM_COMMAND-1;
		}
	}

	for(i=0; i<NUM_COMMAND-1; i++)
		if(!strcmp(str, COMMAND[i])) return i;

	return -1;
}

void command_list(FILE* yyin)
{
	if(yyin!=NULL){
		print_file(yyin);
		reset_file(yyin);
	}	

	else {
		printf("file opening failed.\n");
	}
}

void command_quit()
{
	exit(0);
}

void command_run()
{
	printf("INPUT : RUN\n");
	yyparse();
}

void command_line(FILE* yyin, char* str)
{
	if(str[strlen(str)-1]!='>'){
		printf("close with '>'\n");
	}

	else{
		char str2[10];
		memcpy(str2,&str[1],((int)strlen(str))-2);
		str2[strlen(str2)]='\0';
		int num=atoi(str2);
		if(yyin!=NULL) {
			char* c;
			char* pstr;
			char strTemp[255];
			const char * delimeter=" ";
			char line[255];
			while(!feof(yyin)){
				pstr=fgets(strTemp,sizeof(strTemp),yyin);
				strcpy(line,strTemp);
				c=strtok(pstr,delimeter);
				if(atoi(c)==atoi(str2)){
					printf("%s",line);
					reset_file(yyin);
					return;
				}
			}	
			printf("Wrong line number!\n");
			reset_file(yyin);
		}
	}
}
