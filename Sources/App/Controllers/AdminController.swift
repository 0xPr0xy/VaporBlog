import Vapor
import HTTP

final class AdminController {
	
	let view: ViewRenderer
	let routeBuilder: RouteBuilder
	
	init(_ view: ViewRenderer, routeBuilder: RouteBuilder) {
		self.view = view
		self.routeBuilder = routeBuilder
		self.addRoutes()
	}

	func index(_ request: Request) throws -> ResponseRepresentable {
		return try view.makeAdminView(request)
	}
	
	private func addRoutes() {
		routeBuilder.get("admin", handler: index)
	}
}
