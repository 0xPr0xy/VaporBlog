import Vapor
import HTTP
import AuthProvider

final class LoginController {
	
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
		let pages = try PageProvider.allPages()
		
		return try view.makeLoginView(request, config, pages: pages)
	}
	
	func login(_ request: Request) throws -> ResponseRepresentable {
		guard
			let username = request.formURLEncoded?["username"]?.string,
			let password = request.formURLEncoded?["password"]?.string
		else {
			throw Abort.badRequest
		}
		
		let credentials = Password(username: username, password: password)
		let user = try User.authenticate(credentials)
		
		request.auth.authenticate(user)
		
		return Response(redirect: "admin")
	}
	
	private func addRoutes() {
		routeBuilder.get("login", handler: index)
		routeBuilder.post("login", handler: login)
	}
}
