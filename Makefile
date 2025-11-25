##
## EPITECH PROJECT, 2025
## makefile
## File description:
## makefile
##

ASM = nasm

NASMFLAGS = -f elf64 -o 84shell.o

SRC = shell.asm

NAME = 84shell

all: $(NAME)

$(NAME): $(SRC)
	$(ASM) $(NASMFLAGS) $(SRC)
	ld -o $(NAME) 84shell.o
	

clean:
	rm -f *.o

fclean: clean
	rm -f $(NAME)

re: fclean all