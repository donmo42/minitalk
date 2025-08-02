#include "minitalk.h"

void	ft_handler(int sig, siginfo_t *info, void *c)
{
	static int	character = 0;
	static int	bit = 7;
	pid_t		client_pid;

	(void)c;
	client_pid = info->si_pid;
	if (sig == SIGUSR1)
		character |= (1 << bit);
	bit--;
	if (bit < 0)
	{
		if (character == 0)
			ft_printf("\nmessage recu par le serveur\n");
		ft_printf("%c", character);
		character = 0;
		bit = 7;
		if (kill(client_pid, SIGUSR2) == -1)
			perror("Erreur kill");
	}
}

int	main(int ac, char **av)
{
	struct sigaction sa;
	(void)av;
	if (ac != 1)
	{
		ft_printf("\033[91mError: wrong format.\033[0m\n");
		ft_printf("\033[33mTry: ./server\033[0m\n");
		return (1);
	}
	ft_printf("📡 Serveur PID: %d\n", getpid());
	sa.sa_sigaction = ft_handler;
	sa.sa_flags = SA_SIGINFO;
	sigemptyset(&sa.sa_mask);
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (1)
		pause();
	return (0);
}