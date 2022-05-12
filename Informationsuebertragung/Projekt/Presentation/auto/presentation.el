(TeX-add-style-hook
 "presentation"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("beamer" "aspectratio=1610" "xcolor=table")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("siunitx" "binary-units")))
   (add-to-list 'LaTeX-verbatim-environments-local "semiverbatim")
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "href")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "colors"
    "slides/Aufgabe1"
    "slides/Aufgabe2"
    "slides/Aufgabe3"
    "slides/Aufgabe4"
    "slides/Aufgabe5"
    "slides/Aufgabe6"
    "slides/Aufgabe7"
    "slides/Aufgabe8"
    "slides/Aufgabe9"
    "beamer"
    "beamer10"
    "graphicx"
    "xcolor"
    "listings"
    "bera"
    "siunitx"
    "fontspec"
    "tgheros"
    "inconsolata")
   (TeX-add-symbols
    '("twocolumns" 3)
    "smallemskip"
    "medemskip"
    "bigemskip"
    "smallgrskip"
    "medgrskip"
    "biggrskip"))
 :latex)

