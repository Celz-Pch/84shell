##
## EPITECH PROJECT, 2025
## makefile
## File description:
## makefile
##

ASM = nasm
CC = clang

NASMFLAGS = -f elf64 -o 84shell.o

SRC = shell.asm

NAME = 84shell

all: $(NAME)

$(NAME): $(SRC) keyboard.c
	$(ASM) $(NASMFLAGS) $(SRC)
	$(CC) -c keyboard.c -o keyboard.o
	$(CC) keyboard.o 84shell.o -o $(NAME) -no-pie -nostartfiles

clean:
	rm -f *.o

fclean: clean
	rm -f $(NAME)

re: fclean all