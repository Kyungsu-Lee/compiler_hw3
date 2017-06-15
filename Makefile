# Makefile

FILES	= Lexer.c Parser.c read_file.c main.c
CC	= gcc
CFLAGS	= -g 

test:		$(FILES)
		$(CC) $(CFLAGS) $(FILES) -o basic -lfl -ly

Lexer.c:	Lexer.l 
		flex Lexer.l

Parser.c:	Parser.y Lexer.c
		bison Parser.y

clean:
		rm -f *.o *~ Lexer.c Lexer.h Parser.c Parser.h basic
