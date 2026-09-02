public import Collection_Slice

extension Parser {

    public struct End<Input: Collection.Slice.`Protocol`> {

        @inlinable
        public init() {}
    }
}

extension Parser.End where Input: Collection.Slice.`Protocol` {

    public enum Error: Swift.Error, Equatable {
        case expectedEnd(remaining: Int)
    }
}

extension Parser.End: Parser.`Protocol` {

    public typealias Output = Void

    public typealias Failure = Parser.End<Input>.Error

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) {
        guard input.isEmpty else {
            throw .expectedEnd(remaining: input.parserRemainingCount)
        }
    }
}
