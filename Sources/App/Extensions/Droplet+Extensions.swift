@_exported import Vapor

extension Droplet {
    public func setup() throws {
		try Fixtures.load(config: config)
        let routes = Routes(view, config)
        try collection(routes)
    }
}
