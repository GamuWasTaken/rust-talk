#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: new-section, focus
#import "@preview/codly:1.3.0": *


#show: metropolis.setup.with(
  text-font: "DejaVu Sans",
  math-font: "DejaVu Math TeX Gyre",
  code-font: "JetBrainsMono NF",
)
#show: codly-init

#set grid(columns: (1fr, 1fr), align: center)
#set page(margin: (x: 3em))

#codly(
  display-name: false,
  // number-format: none,
  // zebra-fill: none,
  // stroke: none,,
  // lang-inset: 0pt,
)

#let ferris(dir: ltr, width: 260pt, type: "gesture") = scale(
    x: if dir == ltr { 1 } else { -1 } * 100%,
    image("media/ferris-"+type+".svg",
    width: width)
)

#let bg = rgb("#23373b") // dark teal
#let fg = white.darken(2%)
#let ec = red.lighten(70%)

#slide[
  #set page(header: none, footer: none, margin: 3em)

  #text(size: 2em)[*Rust*]

  A boring and expressive language

  #metropolis.divider
  
  #text(size: .8em, weight: "light")[Victor Diez Ruiz]
  
  #grid[
    #ferris(dir: rtl, width: 180pt)
  ][
    ```rust
    fn main() {
      println!("Hello 🦀");
    }
    ```
    ]
]

#slide[
  = Why Rust rocks

  #grid[
    #align(
    left,  
    metropolis.outline
    )
  ][
    #ferris()
  ]
]

#new-section[Lifetimes & Ownership]
#slide[
  = Scopes

  #grid[
    #only(1,```rust
    fn main() {
      let a = 2;
      let b = 3;
      println!("{}", a + b);
    }
    ```)
    #only(2,[
      #codly(
        highlights: (
          // scope limits
          (line: 1, start: 11, fill: blue, tag: "<scope>"),
          (line: 5, start: 1, fill: blue, tag: "</scope>"),
        ),
      )
      ```rust
      fn main() {
        let a = 2;
        let b = 3;
        println!("{}", a + b);
      }
      ```
    ])
  ][
    #ferris(width: 260pt)
  ]
]

#slide[
  = Lifetimes
  #grid[
    #ferris(dir: rtl)
  ][
    #only(1,
    ```rust
    fn main() {
      let a = 2;
      {
        let b = 3;
      }
      println!("{}", a + b);
    }
    ```
    )
    #only(2, [
      #codly(
        highlights: (
          // 'a
          (line: 1, start: 11, fill: blue, tag: "<'a>"),
          (line: 7, start: 1, fill: blue, tag: "</'a>"),
          // 'b
          (line: 3, start: 3, fill: green, tag: "<'b>"),
          (line: 5, start: 3, fill: green, tag: "</'b>"),
          // error
          (line: 6, start: 22, end: 22, fill: red),
        ),
        highlighted-lines: ((6, ec),)
      )
      ```rust
      fn main() {
        let a: 'a = 2;
        {
          let b: 'b = 3;
        }
        println!("{}", a + b);
      }
      ```
    ])
  ]
]

#slide[
  = Ownership  
  #grid[
    ```rust
    fn main() {
      let a: 'a = 2;
      {
        let b: 'b = 3;
      }
      println!("{}", a + b);
    }
    ```
  ][
    Memory representation\
    in 2/3 slides
    #ferris(type: "gesture", width: 260pt)
  ]
]

#new-section[Inmutability by default]
#slide[
  = Inmutability by default

  #grid[
    #codly(
      highlights: (
        // mut
        (line: 3, start: 7, end: 9, fill: green),
      ),
      highlighted-lines: ((5, ec),)
    )
    ```rust
    fn main() {
      let a = 2;
      let mut b = 3;

      a = 3; //  error
      b = 2; //  ok
    }
    ```
  ][
    #ferris(type: "happy", width: 260pt)
  ]
]

#new-section[Algebraic Data Types]
#slide[
  = Algebraic Data Types

  #grid[
    #ferris(type: "gesture", dir: rtl, width: 260pt)
  ][
    #one-by-one[
      ```julia bool : { true, false }```\
    ][
      ```julia   u8 : { 1, ..., 255 }```
    ]
  ]

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
