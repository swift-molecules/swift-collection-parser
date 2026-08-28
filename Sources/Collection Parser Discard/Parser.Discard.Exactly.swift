public import Collection_Slice

extension Parser.Discard {

    public struct Exactly<Input: Collection.Slice.`Protocol`> {
        @usableFromInline
        let count: Int

        @inlinable
        public init(_ count: Int) {
            self.count = count
        }
    }
}

extension Parser.Discard.Exactly: Parser.`Protocol` {

    public typealias Output = Void

    public typealias Failure = Error

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) {
        do throws(Parser.Consume.Exactly<Input>.Error) {
            _ = try Parser.Consume.Exactly<Input>(count).parse(&input)
        } catch {
            switch error {
            case .countTooLow(let expected, let got):
                throw .countTooLow(expected: expected, got: got)
            }
        }
    }
}

extension Parser.Discard.Exactly {

    public enum Error: Swift.Error, Sendable, Equatable {

        case countTooLow(expected: Int, got: Int)
    }
}
