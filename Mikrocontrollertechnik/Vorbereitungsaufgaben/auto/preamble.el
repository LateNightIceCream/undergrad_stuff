(TeX-add-style-hook
 "preamble"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "ngerman") ("inputenc" "utf8") ("tcolorbox" "many") ("circuitikz" "european") ("hyperref" "colorlinks=true" "pdfborder={0 0 0}" "linkcolor=gray6")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "../colors"
    "babel"
    "inputenc"
    "amsmath"
    "pgfplots"
    "tikz"
    "tcolorbox"
    "graphicx"
    "pdfpages"
    "dashrule"
    "float"
    "siunitx"
    "trfsigns"
    "booktabs"
    "circuitikz"
    "listings"
    "titlesec"
    "fontspec"
    "tgheros"
    "tgcursor"
    "sansmath"
    "geometry"
    "hyperref")
   (TeX-add-symbols
    '("commentGray" 1)
    '("inlinecode" 1)
    '("eqbox" 2)
    '("notebox" 1)
    '("plotfun" 3)
    '("minisec" 1)
    '("holine" 1)
    "dif")
   (LaTeX-add-lengths
    "smallvert")
   (LaTeX-add-tcolorbox-newtcboxes
    '("inlinebox" "" "" ""))
   (LaTeX-add-xcolor-definecolors
    "hsblue"
    "hsgrey"))
 :latex)

