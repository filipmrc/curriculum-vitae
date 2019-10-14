(TeX-add-style-hook
 "tccv"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("scrartcl" "10pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "hmargin=1.25cm" "vmargin=1.25cm" "twocolumn" "columnsep=1.25cm")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "scrartcl"
    "scrartcl10"
    "geometry"
    "bookman"
    "etoolbox"
    "hyperref"
    "marvosym"
    "needspace"
    "tabularx"
    "xcolor")
   (TeX-add-symbols
    '("personal" ["argument"] 4)
    '("ucwords" ["argument"] 1)
    '("ifjob" 3)
    '("directlua" 1)
    "sc"
    "rm"
    "sf"
    "tt"
    "bf"
    "it"
    "sl"
    "raising"
    "boxwidth"
    "inskip"
    "unbaseline")
   (LaTeX-add-environments
    "eventlist"
    "yearlist"
    "factlist")
   (LaTeX-add-xcolor-definecolors
    "link"))
 :latex)

