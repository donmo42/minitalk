#include "minitalk.h"

void	receive_ack(int signal)
{
	if (signal == SIGUSR2)
		ft_printf("ACK reçu (SIGUSR)\n");
}
void	send_character(int pid, int c)
{
	int	bit;

	bit = 8;
	while (bit--)
	{
		if ((c >> bit) & 1)
		{
			if (kill(pid, SIGUSR1) == -1)
			{
				perror("Erreur kill SIGUSR1");
				exit(EXIT_FAILURE);
			}
		}
		else
		{
			if (kill(pid, SIGUSR2) == -1)
			{
				perror("Erreur kill SIGUSR2");
				exit(EXIT_FAILURE);
			}
		}
		usleep(200);
	}
}

int	main(int ac, char **av)
{
	int i;
	int pidserver;

	if (ac != 3 || !ft_strlen(av[2]))
		return (ft_printf("\033[91mError: wrong format.\033[0m\n", 1));
	i = 0;
	pidserver = ft_atoi(av[1]);
	signal(SIGUSR2, receive_ack);
	while (av[2][i])
	{
		send_character(pidserver, av[2][i]);
		i++;
	}
	send_character(pidserver, '\0');
	return (0);
}