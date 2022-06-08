public protocol ExecutableQuery {
    func getQuery() -> String
    func executeQuery(_ query: String) -> String
}
