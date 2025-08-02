NAME_SERVER  = server
NAME_CLIENT  = client

CC           = gcc
CFLAGS       = -Wall -Wextra -Werror

SRC_SERVER   = server.c
SRC_CLIENT   = client.c

OBJ_SERVER   = $(SRC_SERVER:.c=.o)
OBJ_CLIENT   = $(SRC_CLIENT:.c=.o)

# === Librairies === #
LIBFT_DIR    = Lib
FT_LIBFT     = ft_libft
FT_PRINTF    = ftprint
LIBFT_LIB    = $(LIBFT_DIR)/$(FT_LIBFT)/libft.a
PRINTF_LIB   = $(LIBFT_DIR)/$(FT_PRINTF)/libftprintf.a
LIBFT_INC    = -I $(LIBFT_DIR)/$(FT_LIBFT)
PRINTF_INC   = -I $(LIBFT_DIR)/$(FT_PRINTF)

# Cible principale
all: $(LIBFT_LIB) $(PRINTF_LIB) $(NAME_SERVER) $(NAME_CLIENT)

# Compilation des fichiers objets (client et serveur)
$(OBJ_SERVER): $(SRC_SERVER)
	@$(CC) $(CFLAGS) $(SRC_SERVER) $(LIBFT_INC) $(PRINTF_INC) -c -o $(OBJ_SERVER)

$(OBJ_CLIENT): $(SRC_CLIENT)
	@$(CC) $(CFLAGS) $(SRC_CLIENT) $(LIBFT_INC) $(PRINTF_INC) -c -o $(OBJ_CLIENT)

# Compilation de la libft
$(LIBFT_LIB):
	@$(MAKE) -C $(LIBFT_DIR)/$(FT_LIBFT)

# Compilation de la libftprintf
$(PRINTF_LIB):
	@$(MAKE) -C $(LIBFT_DIR)/$(FT_PRINTF)

# Cible server
$(NAME_SERVER): $(OBJ_SERVER)
	@$(CC) $(CFLAGS) $(OBJ_SERVER) $(LIBFT_LIB) $(LIBFT_INC) $(PRINTF_LIB) $(PRINTF_INC) -o $(NAME_SERVER)
	@echo "🟢 [$(NAME_SERVER)] compilé avec succès"

# Cible client
$(NAME_CLIENT): $(OBJ_CLIENT)
	@$(CC) $(CFLAGS) $(OBJ_CLIENT) $(LIBFT_LIB) $(LIBFT_INC) $(PRINTF_LIB) $(PRINTF_INC) -o $(NAME_CLIENT)
	@echo "🟢 [$(NAME_CLIENT)] compilé avec succès"

# Nettoyage des fichiers objets
clean:
	@rm -f $(OBJ_SERVER) $(OBJ_CLIENT)
	@$(MAKE) clean -C $(LIBFT_DIR)/$(FT_LIBFT)
	@$(MAKE) clean -C $(LIBFT_DIR)/$(FT_PRINTF)
	@echo "🧹 Fichiers objets supprimés"

# Nettoyage complet (binaires + objets)
fclean: clean
	@rm -f $(NAME_SERVER) $(NAME_CLIENT)
	@$(MAKE) fclean -C $(LIBFT_DIR)/$(FT_LIBFT)
	@$(MAKE) fclean -C $(LIBFT_DIR)/$(FT_PRINTF)
	@echo "🧨 Binaires supprimés"

# Reconstruction complète
re: fclean all

.PHONY: all clean fclean re