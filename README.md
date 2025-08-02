🧠 LMinitalk - Projet 42
📝 Description

Minitalk est un petit projet système de l'école 42 qui met en œuvre la communication entre deux processus UNIX (un serveur et un client) à l'aide de signaux POSIX. Le but est de transmettre un message du client au serveur, caractère par caractère, en encodant chaque bit via les signaux SIGUSR1 et SIGUSR2.

Ce projet permet de comprendre les mécanismes de bas niveau comme :

    La gestion des signaux.

    L'identification des processus via leur PID.

    La transmission de données binaires entre processus sans utiliser de sockets ni de fichiers.

🔧 Fonctionnement
🖥️ Structure

    serveur : Attend les signaux du client. À chaque signal reçu (SIGUSR1 ou SIGUSR2), il reconstitue un caractère bit par bit, puis affiche le message final à l'écran.

    client : Envoie un message en convertissant chaque caractère en bits, et en envoyant un signal différent selon que le bit est 0 ou 1.

⚙️ Détails techniques
📌 PID (Process IDentifier)

Chaque processus sur un système UNIX a un identifiant unique appelé PID.
Dans ce projet :

    Le serveur affiche son PID au démarrage.

    Le client a besoin de ce PID pour savoir où envoyer les signaux.

Le client utilise ce PID pour envoyer les signaux au bon processus (le serveur). Sans le PID, le système ne saurait pas à quel processus les signaux doivent être transmis.
📡 Signaux utilisés

Deux signaux sont utilisés pour encoder les bits :

    SIGUSR1 = bit 0

    SIGUSR2 = bit 1

Le client lit chaque caractère du message, convertit chaque bit, et envoie les signaux un par un. Le serveur, quant à lui, reconstruit chaque octet reçu à l'aide des signaux et l'affiche.
🔐 Pourquoi passer par le binaire ?

Chaque caractère est représenté en binaire (8 bits) en mémoire.
Pour transmettre une donnée via des signaux (qui ne transportent pas directement des valeurs), il faut émuler l’envoi d’informations :

    Chaque bit est représenté par un signal (1 signal = 1 bit).

    Après 8 signaux (bits), on reconstitue un caractère.

    Le message est donc encodé en binaire pour être découpé signal par signal.

En résumé : on utilise les signaux pour simuler un canal de communication binaire.
📦 Compilation

Utilisez make pour compiler le projet :

make
Cela génère deux exécutables :

    server

    client
🚀 Utilisation

    Lancez le serveur :
    ./server
Il vous affichera son PID :

Dans un autre terminal, envoyez un message avec le client :

     ./client 12345 "Bonjour !"
Le serveur affichera ensuite :

            "Bonjour !"
✅  possibles

    Envoi de messages plus longs.

    Accusé de réception.

    Transmission plus rapide (optimisation du usleep()).

    Gestion d'erreurs (PID invalide, message vide, etc.).

PS : Il faut ajouter deux bibliothèques à ce projet, ou bien remplacer ft_printf par la vraie fonction printf, et ft_atoi par la fonction standard atoi.
Voici les liens vers les deux bibliothèques à ajouter : 
https://github.com/donmo42/printf </br>
https://github.com/donmo42/libft
