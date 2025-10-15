#![allow(dead_code)]

fn main() {
    let lab = Lab::<10, 5>::new(10);

    println!("{}", lab);
}

use core::panic;
use std::fmt::Display;

use rand::prelude::*;

#[derive(Debug, Clone, Copy)]
enum Direction {
    North,
    South,
    East,
    West,
}

#[derive(Debug, Clone, Copy)]
enum Marker {
    Empty,
    Box,
    Guard(Direction),
}

impl Marker {
    fn update(&self) -> (Action, Action) {
        use Action::*;
        use Direction::*;
        use Marker::*;
        match self {
            Empty => (Nothing, Nothing),
            Box => (Nothing, Nothing),
            Guard(North) => (Move(0, -1), Change(Guard(West))),
            Guard(South) => (Move(0, 1), Change(Guard(East))),
            Guard(East) => (Move(1, 0), Change(Guard(North))),
            Guard(West) => (Move(-1, 0), Change(Guard(South))),
        }
    }
}

impl Display for Marker {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{}",
            match self {
                Marker::Empty => "·",
                Marker::Box => "#",
                Marker::Guard(Direction::North) => "^",
                Marker::Guard(Direction::South) => "v",
                Marker::Guard(Direction::East) => ">",
                Marker::Guard(Direction::West) => "<",
            }
        )
    }
}

enum Action {
    Nothing,
    Move(isize, isize),
    Change(Marker),
}

#[derive(Debug)]
struct Lab<const X: usize, const Y: usize> {
    lab: [[Marker; X]; Y],
}

impl<const X: usize, const Y: usize> Lab<X, Y> {
    fn new(box_amount: u8) -> Self {
        let mut lab = [[Marker::Empty; X]; Y];

        let mut rng = rand::rng();

        for _ in 0..box_amount {
            lab[rng.random_range(0..Y)][rng.random_range(0..X)] = Marker::Box;
        }

        let (x, y) = (rng.random_range(0..Y), rng.random_range(0..X));

        lab[x][y] = Marker::Guard(match rng.random_range(0..4) {
            0 => Direction::North,
            1 => Direction::South,
            2 => Direction::East,
            3 => Direction::West,
            _ => panic!(),
        });

        Self { lab }
    }

    fn step(&mut self) {}
}

impl<const X: usize, const Y: usize> Display for Lab<X, Y> {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        for row in self.lab {
            for marker in row {
                write!(f, "{} ", marker)?;
            }
            write!(f, "\n")?;
        }

        write!(f, "")
    }
}
