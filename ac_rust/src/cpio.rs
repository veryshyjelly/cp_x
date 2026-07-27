pub use proconio::marker::{Bytes, Chars};

use std::fmt::{Display, Formatter};
use std::iter::FromIterator;

// ==========================================
// 1. OUTPUT FORMATTING (Kept from your original)
// ==========================================

pub enum CPResult<T, E>
where
    T: Display,
    E: Display,
{
    Success(T),
    Failure(E),
}

#[macro_export]
macro_rules! unwrap {
    ($value:expr) => {
        match $value {
            Ok(v) => v,
            Err(e) => return Failure(e),
        }
    };
}

impl<T, E> From<Result<T, E>> for CPResult<T, E>
where
    T: Display,
    E: Display,
{
    fn from(value: Result<T, E>) -> Self {
        use CPResult::*;
        match value {
            Ok(v) => Success(v),
            Err(e) => Failure(e),
        }
    }
}

impl<S, T> Display for CPResult<S, T>
where
    S: Display,
    T: Display,
{
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            CPResult::Success(v) => write!(f, "{v}"),
            CPResult::Failure(v) => write!(f, "{v}"),
        }
    }
}

pub struct Boolean<const CASE: u8>(bool);
pub type Bool = Boolean<0>;
pub type BOOL = Boolean<1>;

impl From<bool> for Bool {
    fn from(value: bool) -> Self { Boolean(value) }
}

impl From<bool> for BOOL {
    fn from(value: bool) -> Self { Boolean(value) }
}

impl<const CASE: u8> Display for Boolean<CASE> {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        let res = if self.0 { "Yes" } else { "No" };
        if CASE == 1 {
            write!(f, "{}", res.to_uppercase())
        } else {
            write!(f, "{res}")
        }
    }
}

pub struct ListOf<const SEP: char, T>(pub Vec<T>);
pub type Words<T> = ListOf<' ', T>;
pub type Lines<T> = ListOf<'\n', T>;

pub fn words_of<T>(v: Vec<T>) -> Words<T> { ListOf(v) }
pub fn lines_of<T>(v: Vec<T>) -> Lines<T> { ListOf(v) }

impl<T, const S: char> From<Vec<T>> for ListOf<S, T> {
    fn from(value: Vec<T>) -> Self { ListOf(value) }
}

impl<R, const S: char> FromIterator<R> for ListOf<S, R> {
    fn from_iter<T: IntoIterator<Item = R>>(iter: T) -> Self {
        iter.into_iter().collect::<Vec<_>>().into()
    }
}

impl<T, const SEP: char> Display for ListOf<SEP, T>
where
    T: Display,
{
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        if self.0.is_empty() {
            return Ok(());
        }
        if SEP == '\0' {
            for item in &self.0 {
                write!(f, "{}", item)?;
            }
        } else {
            let mut iter = self.0.iter();
            if let Some(first) = iter.next() {
                write!(f, "{}", first)?;
                for item in iter {
                    write!(f, "{}{}", SEP, item)?;
                }
            }
        }
        Ok(())
    }
}

// ==========================================
// 2. INPUT HANDLING (Now powered by Proconio!)
// ==========================================


/// Macro for single test case problems
#[macro_export]
macro_rules! sol {
    (
        fn $name:ident (
            $( $var:ident : $ty:tt ),* $(,)?
        ) -> $ret:ty
        $body:block
    ) => {
        fn $name() -> $ret {
            ::proconio::input! {
                $( $var : $ty ),*
            }
            $body
        }

        fn main() {
            use std::io::{self, Write};
            let mut out = io::BufWriter::new(io::stdout().lock());

            let result = $name();
            writeln!(out, "{}", result).unwrap();
            out.flush().unwrap();
        }
    };
}

/// Macro for multiple test case problems
#[macro_export]
macro_rules! sol_n {
    (
        fn $name:ident (
            // Changed $ty:ty to $($ty:tt)* here as well
            $( $var:ident : $ty:tt ),* $(,)?
        ) -> $ret:ty
        $body:block
    ) => {
        fn $name() -> $ret {
            ::proconio::input! {
                $( $var : $ty ),*
            }
            $body
        }

        fn main() {
            use std::io::{self, Write};
            let mut out = io::BufWriter::new(io::stdout().lock());

            ::proconio::input! {
                t: usize,
            }

            for _ in 0..t {
                let result = $name();
                writeln!(out, "{}", result).unwrap();
            }
            out.flush().unwrap();
        }
    };
}
