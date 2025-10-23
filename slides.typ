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
    image("media/ferris-"+type+".svg", width: width)
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
  = Save the environment
  #grid[
    #only(2, codly(
      highlights: (
        // scope limits
        (line: 1, start: 11, fill: blue, tag: "<scope>"),
        (line: 5, start: 1, fill: blue, tag: "</scope>"),
      ),
    ))
    ```rust
    fn main() {
      let a = 2;
      let b = 3;
      println!("{}", a + b);
    }
    ```
  ][
    #only(1, ferris())
    #only(2, ferris(type: "happy"))
  ]

  #toolbox.pdfpc.speaker-note("Scopes")
]

#slide[
  = Everything eventually dies
  #grid[
    #only(1, ferris(dir: rtl))
    #only(2, ferris(type: "happy"))
  ][
    #only(2, codly(
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
    ))
    ```rust
    fn main() {
      let a = 2;
      {
        let b = 3;
      }
      println!("{}", a + b);
    }
    ```
  ]
  #toolbox.pdfpc.speaker-note("Lifetimes")
]

#slide[
  = Sir that's mine
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
    #ferris()
  ]
  #toolbox.pdfpc.speaker-note("Ownership")
]

#new-section[Inmutability by default]
#slide[
  = Can't touch this

  #grid[
    #only(2, codly(
        highlights: (
          // mut
          (line: 3, start: 7, end: 9, fill: green),
        ),
        highlighted-lines: ((5, ec),)
    ))
    
    ```rust
    fn main() {
      let a = 2;
      let mut b = 3;

      a = 3;
      b = 2;
    }
    ```
  ][
    #only(1, ferris())
    #only(2, ferris(type: "happy"))
  ]
]

#new-section[Algebraic Data Types]
#slide[
  = Types as numbers ?!?!?!

  #grid[
    #only("-3", ferris(dir: rtl))
    #only("4", ferris(type: "happy"))
  ][
    #set align(left)
    #only("4")[
      ```julia !    : {             } = 0```\
      #toolbox.pdfpc.speaker-note("Cannot be built")
    ]
    #only("3-")[
      ```julia unit : { ()          } = 1```\
      #toolbox.pdfpc.speaker-note("Can always be built")
    ]
    #only("1-")[
      ```julia bool : { true, false } = 2```\
    ]
    #only("2-")[
      ```julia u8   : { 0, ..., 255 } = 256```\
    ]
  ]

  #toolbox.pdfpc.speaker-note("bool{2} -> u8{256} -> unit{1} -> never{0}")
]

#slide[
  = Math with types ?!?!
  #grid[
    // Addition
    #only("1-2")[
      Addition\
      ```julia bool{2} + unit{1} = 3```
    ]
    #only("2")[
      ```rust
      enum MaybeBool {
        Some(bool),
        None
      }
      ```
    ]
    #only("3")[
      ```rust
      enum Directions {
        North,
        East,
        West,
        South,
      }
      ```
    ]
  ][
    #only("-2", ferris(dir: ltr))
    #only("3", ferris(type: "happy"))
  ]
]

#slide[
  = More math with types ?!
  #grid[
    #only("1", ferris(dir: rtl))
    #only("2", ferris(type: "happy"))
  ][
    // Multiplication
    #only("1-")[
      Multiplication\
      ```julia bool{2} * Direction{4} = 8```
    ]
    #only("2")[
      ```rust
      struct Robot {
        lastDir: Direction,
        enabled: bool
      }
      ```
    ]
  ]
]

#slide[
  = What the `****` is $"bool"^"bool"$ ?!

  #grid(columns: (2fr, 1fr))[
    #only("1-")[
      Exponentiation\
      ```julia bool{2} ^ bool{2} = 4```
    ]
    #only("2")[
      ```rust
      fn id   (v: bool) -> bool { v     }
      fn not  (v: bool) -> bool { !v    }
      fn true (_: bool) -> bool { true  }
      fn false(_: bool) -> bool { false }
      ```
    ]
  ][
    #only("-1", ferris())
    #only("2", ferris(type: "happy"))
  ]
  #toolbox.pdfpc.speaker-note("1² != 2¹")
]

#new-section[Error handling]
#slide[
  = I don't like exceptions
  #grid(columns: (2fr, 3fr))[
    #only("-1", ferris(dir: rtl))
    #only("2", ferris(type: "happy"))
  ][
    #only("1")[
      ```rust
      fn try_parse(input: String)
        -> Option<Phone>;
      ```
    ]
    #only("2")[
      ```rust
      enum Option<T> {
        Some(T),
        None
      }
      ```
    ]
  ]
  #toolbox.pdfpc.speaker-note("Errors as values")
]

#slide[
  = Without exception, no exception is good
  #grid(columns: (2fr, 3fr))[
    #only("-1", ferris(dir: rtl))
    #only("2", ferris(type: "happy"))
  ][
    #only("1")[
      ```rust
      fn try_parse(input: String)
        -> Result<Phone, ParseError>;
      ```
    ]
    #only("2")[
      ```rust
      enum Result<T, E> {
        Ok(T),
        Err(E)
      }
      ```
    ]
  #toolbox.pdfpc.speaker-note("ParseError could be an enum")
  ]
]

#new-section[Pattern Matching]
#slide[
  = Not like tinder

  destructurar por destructurar
  // destructure types
  // wildcards
  // 

]

#new-section[Traits]
#slide[
  = A good way to #text(style: "oblique", "interface") with other code

  #grid[
    #only("1", ferris(dir: rtl))
  ][
    ```rust
    trait 
    ```    
  ]
]

#new-section[Macros]
#slide[
  = Macros

  python en rust?!?!
  // macro-rules
  // procmacros
  // derive macros
]

#new-section[Ecosystem]
#slide[
  // Cargo
  // Rustdoc
  // Comunity
]

#slide[
  #show: focus
  Something very important

]
