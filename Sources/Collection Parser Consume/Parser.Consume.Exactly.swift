public import Collection_Slice
public import Parser

extension Parser.Consume {

    public struct Exactly<Input: Collection.Slice.`Protocol`>: Parser.`Protocol` {

        public typealias Output = Input

        public typealias Failure = Error

        @usableFromInline
        let count: Int

        @inlinable
        public init(_ count: Int) {
            self.count = count
        }

        @inlinable
        public borrowing func parse(_ input: inout Input) throws(Failure) -> Output {
            var endIndex = input.startIndex
            var actualCount = 0
            while actualCount < count, endIndex < input.endIndex {
                endIndex = input.index(after: endIndex)
                actualCount += 1
            }

            guard actualCount == count else {
                throw .countTooLow(expected: count, got: actualCount)
            }

            let result = input[input.startIndex..<endIndex]
            input = input[endIndex...]
            return result
        }
    }
}

extension Parser.Consume.Exactly {

    public enum Error: Swift.Error, Sendable, Equatable {

        case countTooLow(expected: Int, got: Int)
    }
}
