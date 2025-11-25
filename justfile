
init:
    nix-shell -p pdfpc polylux2pdfpc typst tinymist evince

compile:
    typst compile --root . slides.typ
    polylux2pdfpc --root . slides.typ

run: (compile)
    pdfpc slides.pdf
