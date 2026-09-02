public import Collection_Slice
public import Parser

extension Parser {

    public struct Rest<Input: Collection.Slice.`Protocol`>: Parser.`Protocol` {

        public typealias Output = Input

        public typealias Failure = Never

        @inlinable
        public init() {}

        @inlinable
        public borrowing func parse(_ input: inout Input) -> Output {
            let result = input
            input = input[input.endIndex...]
            return result
        }
    }
}
