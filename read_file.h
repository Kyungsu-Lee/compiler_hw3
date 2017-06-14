#ifndef __READ_FILE
#define __READ_FILE

#include <stdio.h>

static const int NUM_COMMAND = 4;

static const char* COMMAND[] = 
{
	"LIST"		//0
	,"RUN"		//1
	,"QUIT"		//2
	,"<LINE_NUM>"	//3
};

void reset_file(FILE* file);
void print_file(FILE* file);
int instruction(char* str);

void command_list(FILE* file);
void command_quit();
void command_run();
void command_line();

#endif
