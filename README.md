# swift-collection-parser

Parser combinators over collection-slice input.

`swift-<domain>-parser` molecules come in two species, distinguished by which
slot of `parse: (inout Input) throws(Failure) -> Output` the domain occupies:

- **Data-lift** (swift-pair-parser, swift-either-parser, swift-always-parser,
  swift-lazy-parser, swift-product-parser): a *value* of the domain type is
  itself interpreted as a parser. The domain occupies the parser slot, so the
  types spell `Pair.Parser`, `extension Either: Parser.Protocol`.
- **Input-capability** (this package, swift-cursor-parser): the domain names a
  *capability of the input state*, and buys combinators that are undefinable
  without it. No collection value is or holds a parser, so the types
  correctly stay `Parser.*` with a `where Input:` constraint.

This package is the fragment available when input is a copyable collection
slice — where positions index into a shared base and backtracking is plain
value-semantic reassignment: whole-input matching, exact consumption and
discarding, prefix parsing, consuming the remainder, and matching the end of
a slice. Combinators that must backtrack over inputs that cannot be copied
live in swift-cursor-parser instead.

The package intentionally has no umbrella product. Import only the focused
product needed by a grammar.
