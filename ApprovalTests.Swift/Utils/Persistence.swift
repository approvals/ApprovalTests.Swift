import Foundation

public protocol Loader {
    associatedtype T
    func load() -> T
}

public protocol Saver {
    associatedtype T
    func save(_ instanceToSave: T) -> T
}

public protocol ExecutableQuery {
    func getQuery() -> String
    func executeQuery(_ query: String) -> String
}
