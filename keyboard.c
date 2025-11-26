/*
** EPITECH PROJECT, 2025
** /home/lukas/epitech/hub/84shell
** File description:
** keyboard
*/

#define _POSIX_C_SOURCE 200809L
#include <signal.h>
#include <stdio.h>
#include <unistd.h>

void my_sigint_handler(int sig) {
    (void)sig;
    write(STDOUT_FILENO, "\n", 1);
}

void stop_sigint(void) {
    struct sigaction sa = {0};

    sa.sa_handler = my_sigint_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    if (sigaction(SIGINT, &sa, NULL) == -1)
        perror("sigaction");
    if (sigaction(SIGTSTP, &sa, NULL) == -1)
        perror("sigaction");
}