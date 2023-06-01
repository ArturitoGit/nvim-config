# Configuration NeoVim

- [ ] Mode debug pour java
- [X] Restreindre l'auto-complétion à certains fichiers
- [ ] Configuration LSP pour SQL
- [X] Déterminer des raccourcis pour les tests
- [X] Mettre tous les raccourcis au propre
- [X] Trouver une alternative à NerdTree
        (i) Apparemment NerdTree est plus complexe qu'il en a l'air, on peut créer des sous menus à la main !
        A voir s'il est plus intéressant de trouver une alternative "out of the box"
        -> Il y a déjà un menu, accessible avec la touche "m" depuis le menu principal
- [X] Trouver l'usage de vim.lsp.buf.execute_command
- [-] Coder un programme en java, pour challenger la qualité de Neovim
- [X] Activer la couleur dans la console d'execution des tests unitaires / Les autres consoles ?
        -> Il suffit d'utiliser :term -> vim-test le fait par défaut
- [X] Comprendre le mécanisme des fenêtres :
        * Comment TestNearest fait pour ouvrir un terminal qui se ferme lorsqu'on appuie sur q ? C'est un nouveau buffer dans la même fenêtre ?
        * Est-il possible de stacker des fenetres les unes sur les autres ? Je ne crois pas, puisque :new split l'ecran de base
        * Comment faire alors pour revenir au dernier buffer sans quitter la fenêtre
        Réponse : Pour fermer le buffer courant (sans fermer la fenêtre), il faut faire "bd"
        donc si je fais bd depuis un terminal ouvert je reviens au dernier buffer (à condition que le terminal ai été ouvert dans une nouveau buffer)
- [X] Paramètrer le live_grep de telescope pour ignorer les répertoires comme /target
- [X] Faire un alias pour transformer :make en :term make
      (!) Pas sûr que cela soit possible ... à voir si ça ne serait pas plus simple de créer ma propre commande ? voir utiliser vim-test

## A améliorer pour pouvoir développer en Java

- [ ] Gestion des modules :
    - [ ] Création
    - [ ] Déplacement
- [ ] Génération classe de test
- [ ] 
