use std::{iter::Peekable, str::Chars};
// Look for words
enum Token<'a> {
    LParen,
    RParen,
    Comma,
    Number(u32),
    Name(String),
    EOF,
}

struct Lexer<'a> {
    input: Peekable<Chars<'a>>,
    tokens: Vec<Token<'a>>,
}

impl<'a> Lexer<'a> {
    fn lex(&mut self) -> Option<Token<'a>> {
        let Some(next) = self.input.next() else {
            return Some(Token::EOF);
        };

        Some(match next {
            '(' => Token::LParen,
            ')' => Token::RParen,
            ',' => Token::Comma,
            // TODO: eat more digits
            num if num.is_digit(10) => {
                let mut number = num.to_string();
                while self.input.peek().map_or(false, |peek| peek.is_digit(10)) {}
                return num.to_digit(10).map(Token::Number);
            }

            _ => return None,
        })
    }
}

// Look for sentences
struct Parser<'a> {
    input: Vec<Token<'a>>,
}

enum Operation {
    Mul(i32, i32),
}

impl<'a> Parser<'a> {
    fn parse(&mut self) -> Vec<Operation> {
        vec![]
    }
}
