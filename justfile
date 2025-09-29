
init:
    nix-shell -p pdfpc polylux2pdfpc

compile:
    typst compile --root . rust-slides.typ
    polylux2pdfpc --root . rust-slides.typ

run: (compile)
    pdfpc rust-slides.pdf
