#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: new-section, focus
#import "@preview/zebraw:0.5.5": zebraw

#show: zebraw.with(
  lang: false,
)

#show: metropolis.setup.with(
  text-font: "DejaVu Sans",
  math-font: "DejaVu Math TeX Gyre",
  code-font: "JetBrainsMono NF",
)
#let bg = rgb("#23373b") // dark teal
#let fg = white.darken(2%)

#let show-code(lines: (), code) = {
  reveal-code(
    code,
    lines: lines,
    after: gray,
    full: false
  )
}

#let side-by-side(..body) = stack(
  dir: ltr,
  spacing: 1fr,
  [],
  ..body,
  []
)

#slide[
  #set page(header: none, footer: none, margin: 3em)

  #text(size: 2em)[*Rust*]

  A boring and expressive language

  #metropolis.divider
  
  #text(size: .8em, weight: "light")[Victor Diez Ruiz]

  
  #place(bottom + right, dy: -30pt,
    ```rust
    fn main() {
      println!("Hello world 🦀");
    }
    ```
  )

  #place(bottom + right, scale(x: 100%,
    image("media/rustacean-flat-gesture.svg", width: 160pt)
  ))
    
]

#slide[
  = Why Rust rocks

  #side-by-side[
    #metropolis.outline
  ][
    #image("media/rustacean-flat-happy.svg", width: 260pt)
  ]
]

#new-section[Lifetimes & Ownership]
#slide[
  = Scopes

  #side-by-side[
    #block(width: 50%, radius: 50pt)[
    ```rust
    fn main() {
      let a = 2;
      let b = 3;

      println!("{}", a + b);
    }
    ```
  ]][
    #image("media/rustacean-flat-gesture.svg", width: 260pt)
  ]
]

#slide[
  = Lifetimes
  #side-by-side[
    #scale(x: -100%, image("media/rustacean-flat-gesture.svg", width: 260pt))
  ][
    #only(1, ```rust
    fn main() {
      let a = 2;
      { let b = 3; }

      println!("{}", a + b);
    }
    ```)
    #only(2, ```rust
    fn main() {
      let a = 2;
      { let b = 3; }

      println!("{}", a + b);
    }
    ```)
  ]
]

#slide[
  = Ownership  
  #side-by-side[
    ```rust
    fn main() {
      let a = 2;
      let b = 3;

      println!("{}", a + b);
    }
    ```
  ][
    Memory representation\
    todo
    #image("media/rustacean-flat-happy.svg", width: 260pt)
  ]
]

#new-section[Inmutability by default]
#slide[
  = Inmutability by default

  #side-by-side[
    ```rust
    fn main() {
      let a = 2;
      let mut b = 3;

      a = 3; //  error
      b = 2; //  ok
    }
    ```
  ][
    #image("media/rustacean-flat-gesture.svg", width: 260pt)
  ]
]

#new-section[Algebraic Data Types]
#slide[
  = Algebraic Data Types
  product sum power

  #toolbox.pdfpc.speaker-note("Math with types!")
]


#new-section[Pattern Matching]
#slide[
  = Pattern Matching

  destructurar por destructurar

]

#new-section[Traits]
#slide[
  = Traits

  interfaces pero mucho mejor
]

#new-section[Macros]
#slide[
  = Macros

  python en rust?!?!
]

#slide[
  #show: focus
  Something very important
]
