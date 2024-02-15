## Les actions personnalisées que j'ai ajoutées à VIM

 Raccourci  | Modes | Action                            |   Comment
------------------------------------------------------------------------------------------------------------------
 ù          |  vn   | Search under cursor               |   Pourrait être amélioré pour permettre la répétition
 ²          |   n   | :cprevious                        |
 é          |   n   | :cnext                            |
 è          |   -   | -                                 |
 €          |   -   | -                                 |
 °          |   -   | -                                 |
 +          |   -   | -                                 |
 £          |   -   | -                                 |
 µ          |   -   | -                                 |
 §          |   -   | -                                 |
 Left       |   n   | Scroll left                       |
 Right      |   n   | Scroll right                      |
 ^o         |  vn   | Markdown: Toggle list element     |
 ^p         |   -   | -                                 |
 ^q         |   -   | -                                 |
 ^s         |   -   | -                                 |
 ^m         |   -   | -                                 |
 ^n         |   -   | -                                 |
 ^[arrows]  |   -   | -                                 |
 ^[hjkl]    |   n   | Navigation                        |
 Alt-<CR>   |   n   | LSP: Code actions                 |   -> ^n puisque ^n est déjà pris pour auto-completion en mode Insertion
 Alt-r      |   n   | LSP: Rename                       |   -> <Leader>r pour "rename" _TODO_ Chercher/Remplacer sans LSP
 Alt-o      |   n   | LSP: Document symbols             |   -> <Leader>s pour "symbols"
 Alt-,      |   n   | LSP: Hover                        |   -> K
 Alt-,      |    i  | LSP: Signature help               |   -> <C- >, pour libérer les Alts
 Alt-t      |   n   | Test current file                 |   (x) pour les raccourcis :T*
 <C-n>      |   n   | Telescope: find file              |   (x)
 <Leader>f  |  vn   | Telescope: live grep              |   (x)
 <Leader>j  |   n   | Nerdtree: toggle                  |   (x)
 <Leader>k  |   n   | Nerdtree: open at current file    |   (x)
 <Leader>e  |   n   | NetRW: Open                       |   (x)
 <Leader>b  |   n   | gitsigns: blame line              |
 <Leader>d  |   n   | LSP: Diagnostic                   |
 <Leader>t  |   n   | Tests: Test last                  |
 <Leader>g  |  vn   | Grep under cursor                 |
 <Leader>y  |  vn   | Yank to clipboard                 |
 <Leader>l  |   n   | noh: Hide search results          |
 <Leader>r  |   n   | Save & Run configuration          |   -> Libérer pour LSP Rename (<Leader><CR> ?)

## Les actions à ajouter

* LSP: Hiérarchie
