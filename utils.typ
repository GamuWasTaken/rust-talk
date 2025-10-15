
#let read_theme(theme) = {
  import "@preview/pleast:0.3.0": plist
  
  return plist(read(theme, encoding: none))
    .settings.at(0)
    .settings
}

#let get_theme(name) = {
  let path = "media/" + name + ".tmTheme"
  let theme = read_theme(path)
  return (
    path,
    rgb(theme.foreground),
    rgb(theme.background),
  )
}

#let line_numbers(it) = {
  text(fill: gray)[#it.number]
  h(1em)
  it.body
}

#let slide(
  theme: "monokai",
  ..contents,
) = {

  let (path, foreground, background) = get_theme(theme)

  set text(fill: foreground, size: 3em)
  set raw(theme: path)

  show raw.line: line_numbers
  show raw: it => block(
    inset: 20pt,
    radius: 10pt,
    fill: background,
    it
  )
  set page(paper: "a4", flipped: true)

  let (content, ..notes) = contents.pos()


  page(
    fill: rgb("#454"),
    align(center + horizon, content)
  )

  page(
    fill: rgb("#222"),
    notes.fold([], (acc, e) => acc + [- #e])
  )
}

#let fragments(..arr) = {
  for (i, element) in arr.pos().enumerate() {

    slide(
      for idx in range(i+1) {
        arr.at(idx)
      }
    )
  }
}
