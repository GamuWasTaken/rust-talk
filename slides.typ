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
#let memory(..content) = box(width: 70%, grid(
      columns: (1fr,) * 4,
      rows: (5pt, 5pt, 1em + 10pt),
      fill: (x, y) => if y == 2 { bg.lighten(60%) },
      stroke: (x, y) => if y == 2 { bg + 2pt },
      inset: 5pt,

      ..content.pos().map(e => {
        (
          if e.life.contains(1) {grid.cell(
            y: 0,
            fill: lime,
            stroke: (left: lime + 2pt, y: lime)
          )[]},
          if e.life.contains(0) {grid.cell(
            y: 1,
            fill: orange,
            stroke: (left: orange + 2pt, y: orange)
          )[]},
          grid.cell(y: 2, fill: aqua.lighten(60%), e.content)
        )
      }).flatten()
    ))
      
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

    #only("1", {
      memory()
      codly(
        highlights: (
          (line: 1, start: 11, end: 11, fill: orange, tag: "<'a>"),
          (line: 2, start: 10, end: 11, fill: orange),
        ),
        highlighted-lines: ((2, aqua.lighten(60%)),)
      )
    })
    #only("2", {
      memory((content: [2], life: (0,)))
      codly(
        highlights: (
          (line: 1, start: 11, end: 11, fill: orange, tag: "<'a>"),
          (line: 3, start: 3, end: 3, fill: lime, tag: "<'b>"),
          (line: 4, start: 12, end: 13, fill: lime),
        ),
        highlighted-lines: ((4, aqua.lighten(60%)),)
      )
    })
    #only("3", {
      memory((content: [2], life: (0,)),(content: [3], life: (0,1)))
      codly(
        highlights: (
          (line: 1, start: 11, end: 11, fill: orange, tag: "<'a>"),
          (line: 3, start: 3, end: 3, fill: lime, tag: "<'b>"),
          (line: 5, start: 3, end: 3, fill: lime, tag: "</'b>"),
          (line: 6, start: 22, end: 22, fill: red),
        ),
        highlighted-lines: ((6, aqua.lighten(60%)),)
      )
    })
    #only("4", {
      memory((content: [2], life: (0,)),)
      codly(
        highlights: (
          (line: 1, start: 11, end: 11, fill: orange, tag: "<'a>"),
          (line: 3, start: 3, end: 3, fill: lime, tag: "<'b>"),
          (line: 5, start: 3, end: 3, fill: lime, tag: "</'b>"),
          (line: 6, start: 22, end: 22, fill: red),
          (line: 7, start: 1, end: 1, fill: orange, tag: "</'a>"),
        ),
      )
    })
    #only("5", {
      memory()
    })
    
    #ferris()
    
  ]
  #toolbox.pdfpc.speaker-note("Ownership")
  // TODO Explain ownership
  // references
  // mut references
  // generics with lifetimes
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
      ```julia bool{2} + unit{1} = {3}```
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
      ```julia unit{1} * 4 = {4}```
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
      ```julia bool{2} * Direction{4} = {8}```
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
      ```julia bool{2} ^ bool{2} = {4}```
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
  = Without exception
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

  #grid(columns: (2fr, 1fr))[
    #only("2", codly(
      highlights: (
        (line: 2, start: 6, end: 10, fill: green),
        (line: 4, start: 7, end: 11, fill: green),
      ),
    ))
    ```rust
    match result {
      Ok(phone) 
        println!("tlf: {}", phone),
      Err(cause) 
        println!("error: {}", cause)
    }
    ```
  ][
    #only("-1", ferris())
    #only("2", ferris(type: "happy"))
  ]
]

#slide[
  = Why stop there?
  #grid(columns: (2fr, 3fr))[
    #only("-2", ferris(dir: rtl))
    #only("3", ferris(type: "happy"))
  ][
    #only("1-2")[
      #one-by-one[
        ```rust
        let Ok(theme) = get_theme()
          else { return CannotGetTheme; };
        ```
      ][
        
        ```rust
        let theme = get_theme()?;
        ```
      ]
    ]
    #only("3")[
      ```rust
      while let Some(e) = iter.next() {
        ...
      }
      ```
    ]
  ]
]

#new-section[Traits]
#slide[
  = A good way to #text(style: "oblique", "interface") with other code

  #grid(columns: (3fr, 1fr))[
    ```rust
    trait Iterator {
      type Item;

      fn next(&mut self) -> Option<Self::Item>;
      fn count(self) -> usize
        where Self: Sized { ... }
    }
    ```    
  ][
    #ferris()
  ]

  // Explain Associated types
  // Self
  // where clause
  // required methods
  // provided methods
  //
  // useful std traits
  //
  // Note, in java when interface is used information is lost
  //   you go up in the inheritance tree, loosing the knoledge of what type you were
  //   in rust there is no inheritance tree, just a list of traits, therefore you don't loose info
]

#slide[
  = Usefulness is also a trait

  #grid()[
    #ferris(dir: rtl)
  ][
    #item-by-item[
      / Debug : 
      / Default : 
      / Clone, Copy : 
      / std\:\:ops\:\:\* : 
      / Iterator : 
      / Drop : 
    ]
  ]
]

#new-section[Macros]

#slide[
  = Python in Rust !?!?
  // https://docs.rs/inline-python/latest/inline_python/
  #grid[]
]

#slide[
  = Write macros with macros!
  #grid[]
]

#slide[
  = As easy as ```#[derive(Debug)]```
  #grid[]
]

#new-section[Ecosystem]
#slide[
  = Bateries mostly included!
  // std
  //   smart pointers (for heap allocation) (Box, Rc, Arc, ...)
  #grid[]
]

#slide[
  = Barman bring me my wine
  // Cargo
  #grid[]
]

#slide[
  = You don't need docs if you can read code
  // Rustdoc
  #grid[]
]

#slide[
  = Plant a tree, have a son, write a book

  #grid[]
  // Comunity (books)
]

#slide[
  #show: focus
  Something very important

]
