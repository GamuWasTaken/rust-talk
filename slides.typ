#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: new-section, focus

#show: metropolis.setup.with(
  text-font: "DejaVu Sans",
  math-font: "DejaVu Math TeX Gyre",
  code-font: "JetBrainsMono NF",
  footer: [hola]
)
// Remove the footer
#set page(footer: [])

#let show-code(lines: (), code) = {
  reveal-code(
    code,
    lines: lines,
    after: gray,
    full: false
  )
}

#show raw.where(lang: "rust"): it => box(
  inset: (y: 1em, x: .1em),
  radius: 15pt,
  it
)


#slide[
  #set page(header: none, footer: none, margin: 3em)

  #text(size: 2em)[
    *Rust*
  ]

  Un lenguaje expresivo y aburrido

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Victor Diez Ruiz

  
  #place(bottom + right, dy: -30pt,
    ```rust
fn main() {
  println!("Hello world 🦀");
}
    ```
  )

  #place(bottom + center, scale(x: -100%,
    image("media/rustacean-flat-gesture.svg", width: 160pt)
  ))
    
]

// #slide[
//   = ¿Qué vamos a ver?

//   #metropolis.outline
// ]

#new-section[Lenguaje]

#slide[
  = Variables y literales
  #show-code(lines: (1,2,3,4),
  ```rust
    let numero = 9_000_000_0_00_000;
    let flotante = 3.141592654;
    let texto = "hola";
    let booleano = true;
  ```
  )
  

]

#slide[
  slide without a title
]

#new-section[My second section]

#slide[
  = Heron algorithm

  ```julia
  function heron(x)
      r = x
      while abs(r^2 - x) > eps()
          r = (r + x / r) / 2
      end
      return r
  end

  @test heron(42) ≈ sqrt(42)
  ```
]

#slide[
  #show: focus
  Something very important
]
