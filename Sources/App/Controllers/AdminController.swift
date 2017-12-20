import Vapor
import HTTP

final class AdminController {
	
	let view: ViewRenderer
	let config: Config
	let routeBuilder: RouteBuilder
	
	init(_ view: ViewRenderer, _ config: Config, routeBuilder: RouteBuilder) {
		self.view = view
		self.config = config
		self.routeBuilder = routeBuilder
		self.addRoutes()
	}

	func index(_ request: Request) throws -> ResponseRepresentable {
		let title = "Admin"
		return try view.makeAdminView(request, config, title: title)
	}
	
	private func addRoutes() {
		routeBuilder.get("admin", handler: index)
	}
}
