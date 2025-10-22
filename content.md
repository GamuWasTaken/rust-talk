
## Main idea
Part from common language and explain the new elements and the
utility of them.

- General [GN]
  - Basic types
    - Numerical
    - Bool
    - Char
    - Array
- Type System [TS]
  - Sum types
    - Fat enums
  - Product types
    - Structs
    - Tuples
  - Pattern Matching
    - Simmple Patterns
    - Destructuring
  - Generics
  - Traits
    - Impl generics
  - Collections
    - String
    - Vec
    - HashMap
    - Error handling
      - Option
      - Result
- Ownership [OW]
  - Borrow Checker
    - & (ref)
    - &mut (refmut)
  - Smart Pointers
    - Box
    - Rc & Arc
    - Ref, RefMut & RefCell
  - Lifetimes
- Good macros [GM]
  - Declarative macros
  - Derive & Proc macros
- Sugar

## Talk road map

[Language]
- Ownership
  - References
  - Lifetimes
- Algebraic data types
  + Product (Struct & Tuples)
  + Sum (Enums)
    - Impl blocks
  - Power (Functions)
    - Functions
      - Operators (just function aliases)
- Data types
  - Generics
  - Traits
- Control structures
  - If
  - Loop -> While -> For
    - hint Iterator Trait
  - Pattern matching
    - match
    - destructuring
    - let pattern
    - if let
- Macros
  - Derive
  - Rules
  - Proc
[Environment]
- Collections
  - String
  - Vec
  - HashMap
- Error handling
  - Option
  - Result
- Smart pointers
  - Box
  - Rc & Arc
[Idiomatic rust]
  - TODO
  - See all the previous points that have some sugar

  

## Advent of code
All of them have the `read input` and `iterators` duh
3. parser + interpreter (enums*, structs, pattern matching)
6. simulator (2D array, structs, enums)
11.simulator (array, enums)
14.simulator (array, structs)
15.sumulator (array, structs, enums)

## Media
- Ferris [rustacean.net](rustacean.net)

## Resources
- https://github.com/mre/idiomatic-rust
