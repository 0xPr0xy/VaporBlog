import Vapor
import HTTP
import AuthProvider

final class LoginController {
	
	let view: ViewRenderer
	let routeBuilder: RouteBuilder
	
	init(_ view: ViewRenderer, routeBuilder: RouteBuilder) {
		self.view = view
		self.routeBuilder = routeBuilder
		self.addRoutes()
	}
	
	func index(_ request: Request) throws -> ResponseRepresentable {
		let pages = try PageProvider.shared.allPages()
		
		return try view.makeLoginView(request, pages: pages)
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
