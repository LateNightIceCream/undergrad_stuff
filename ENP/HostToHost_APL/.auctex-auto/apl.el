(TeX-add-style-hook
 "apl"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt" "a4paper")))
   (TeX-run-style-hooks
    "latex2e"
    "\"/home/zamza/Documents/HS/Notes Template/preamble"
    "article"
    "art11")
   (TeX-add-symbols
    '("code" 1))
   (LaTeX-add-labels
    "beep"
    "gwin"
    "glin"
    "forv"
    "fwconfig1"
    "fwconfig2"
    "vm_port_fw"
    "fwdoof"
    "fwdoof2"
    "fwaus"))
 :latex)

