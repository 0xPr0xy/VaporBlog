import Vapor
import AuthProvider
import Sessions
import HTTP

final class Routes: RouteCollection {
	
	let view: ViewRenderer
	let config: Config
	let passwordMiddleware: PasswordAuthenticationMiddleware<User>
	let persistMiddleware: PersistMiddleware<User>
	let sessionsMiddleware: SessionsMiddleware
	
	init(_ view: ViewRenderer, _ config: Config) {
        self.view = view
		self.config = config
		self.passwordMiddleware = PasswordAuthenticationMiddleware(User.self)
		self.persistMiddleware = PersistMiddleware(User.self)
		self.sessionsMiddleware = SessionsMiddleware(MemorySessions())
    }
	
	func build(_ builder: RouteBuilder) throws {

		let adminBuilder = builder.grouped([
			self.sessionsMiddleware,
			self.persistMiddleware,
			self.passwordMiddleware
		])
		
		_ = AdminController(view, routeBuilder: adminBuilder)
		
		let loginBuilder = builder.grouped([
			self.sessionsMiddleware,
			self.persistMiddleware
		])
		
		_ = try PageController(view, config, adminRouteBuilder: adminBuilder, publicRouteBuilder: loginBuilder)
		_ = LoginController(view, config, routeBuilder: loginBuilder)
		_ = SearchController(view, config, routeBuilder: loginBuilder)
	}
}
