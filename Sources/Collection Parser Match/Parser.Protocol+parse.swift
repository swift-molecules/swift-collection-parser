import Collection_Parser_End
public import Collection_Slice

extension Parser {

    public enum Collection {}
}

extension Parser.Collection {

    public enum Error: Swift.Error, Equatable {
        case expectedEnd(remaining: Int)
    }
}

extension Parser.`Protocol` {

    public func parse(
        _ input: consuming Input
    ) throws(Either<Failure, Parser.Collection.Error>) -> Output
    where Input: Collection.Slice.`Protocol` & Copyable, Output: Escapable {
        var input = input
        let output: Output
        do throws(Failure) {
            output = try parse(&input)
        } catch {
            throw .left(error)
        }
        guard input.isEmpty else {
            throw .right(.expectedEnd(remaining: input.parserRemainingCount))
        }
        return output
    }
}

extension Parser.`Protocol` where Failure == Parser.Collection.Error {

    public func parse(_ input: consuming Input) throws(Parser.Collection.Error) -> Output
    where Input: Collection.Slice.`Protocol` & Copyable, Output: Escapable {
        var input = input
        let output = try parse(&input)
        guard input.isEmpty else {
            throw .expectedEnd(remaining: input.parserRemainingCount)
        }
        return output
    }
}
