;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "monospace" :size 14)
      doom-variable-pitch-font (font-spec :family "Fira Code"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
;(setq doom-theme 'doom-one)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(setq enable-clipboard t)
(setq enable-primary t)
(load "~/.doom.d/dired+.el")
(require 'doom-themes)

;;; Settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t  ; if nil, italics is universally disabled

      ;; doom-one specific settings
      doom-one-brighter-modeline nil
      doom-one-brighter-comments nil)

;; Load the theme (doom-one, doom-dark, etc.)
(load-theme 'doom-one t)

;;; OPTIONAL
;; brighter source buffers (that represent files)
;(add-hook 'find-file-hook #'doom-buffer-mode-maybe)
;; ...if you use auto-revert-mode
;(add-hook 'after-revert-hook #'doom-buffer-mode-maybe)
;; And you can brighten other buffers (unconditionally) with:
;(add-hook 'ediff-prepare-buffer-hook #'doom-buffer-mode)

;; brighter minibuffer when active
;(add-hook 'minibuffer-setup-hook #'doom-brighten-minibuffer)

;; Enable custom neotree theme
(doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

;; Enable nlinum line highlighting
;(doom-themes-nlinum-config)   ; requires nlinum and hl-line-mode
(map! :leader
      (:prefix-map ("o" . "open")
        :desc "Toggle neotree" "n" #'neotree-toggle)
      )
(map! :leader "f w" #'swiper-isearch)

(require 'sly)
(define-key sly-mode-map (kbd "C-c r") (lambda () (interactive) (save-buffer) (sly-compile-and-load-file) (ace-select-window) ))
(sp-local-pair 'sly-mrepl-mode "'" nil)
(sp-local-pair 'sly-mrepl-mode "`" nil)
(setq inferior-lisp-program "/usr/bin/sbcl")

(require 'ccls)
(setq ccls-executable "/usr/bin/ccls")
(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)

(require 'lsp-mode)
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)
;(add-hook 'haskell-mode-hook #'lsp)

(map! :map c++-mode-map "C-c f" #'+default/lsp-format-region-or-buffer)
(map! :map c++-mode-map "C-c r" (lambda () (interactive)
                                  (save-buffer)
                                  (async-shell-command (concat "g++ "(buffer-file-name) "&& ./a.out"))
                                  ))

(setq python-shell-interpreter "python3"
      flycheck-python-pycompile-executable "python3")

(map! :map python-mode-map "C-c r" (lambda () (interactive)
                                     (save-buffer)
                                     (async-shell-command (concat "python3 "(buffer-file-name))
                                                          )))

(map! :map python-mode-map "C-c C-c" (lambda () (interactive)
                                       (save-buffer)
                                       (run-python)
                                       (python-shell-send-buffer)
                                       (python-shell-switch-to-shell)
                                       ))

 (map! :leader "o o" (lambda () (interactive)
                           (let ((a (read-string "Enter an ssh address: ")))
                             (dired (concat "/ssh:" a ":/"))
                             )
                           ))
(use-package dante
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  )

(map! :map haskell-mode-map "C-c r" (lambda () (interactive)
                                      (save-buffer)
                                      (haskell-process-load-file)
                                      (haskell-interactive-switch)
                                      ))



;(load (expand-file-name "/home/bobby/quicklisp/setup.el"))

;(require 'cl)

;(defun reader () (ivy-read "Enter a ssh path: " (let ((smalllist "")(biglist(with-open-file (stream "/home/bobby/.zsh_history" :external-format '(:utf-8 :replacement "?"))
 ;  (loop for line = (read-line stream nil)
  ;       while line
   ;      collect line)))) (dolist (eachline biglist smalllist) (let ((filterline (string-match "(ssh|sudo ssh)[' '][a-zA-Z0-9@\.]+[^' ']" eachline)))
    ;                                                             (if (not (null filterline))
     ;                                                                (push (subseq 5 filterline) smalllist)
      ;                                                           ))))))

;(add-hook 'haskell-mode-hook #'flycheck-haskell-setup)
