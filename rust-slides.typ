
#let slide(
  ..contents
) = {

  show text: text.with(size: 3em, fill: white);

  let slide_contents = ()

  for content in contents.pos() {
    slide_contents.push(content)
    page(
      paper: "a4",
      flipped: true,
      fill: rgb("#233"),
      align(center + horizon,
        for content in slide_contents { content }
      )
    )
  }
}

#slide[
  = Rust
  === Un lenguaje moderno, seguro, y eficiente
]

#slide[
  = Tipos
  ```rust
  struct Book(Vec<Page>);
  ```
]

#slide[
  = Propiedad
]

#slide[
  = Macros
]


