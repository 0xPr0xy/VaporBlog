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
	let redirectMiddleware: RedirectMiddleware
	
	init(_ view: ViewRenderer, _ config: Config) {
        self.view = view
		self.config = config
		self.passwordMiddleware = PasswordAuthenticationMiddleware(User.self)
		self.persistMiddleware = PersistMiddleware(User.self)
		self.sessionsMiddleware = SessionsMiddleware(MemorySessions())
		self.redirectMiddleware = RedirectMiddleware.login()
    }
	
	func build(_ builder: RouteBuilder) throws {

		let adminBuilder = builder.grouped([
			self.redirectMiddleware,
			self.sessionsMiddleware,
			self.persistMiddleware,
			self.passwordMiddleware
		])
		
		_ = AdminController(view, config, routeBuilder: adminBuilder)
		_ = UploadController(view, config, routeBuilder: adminBuilder)

		let loginBuilder = builder.grouped([
			self.sessionsMiddleware,
			self.persistMiddleware
		])
		_ = LoginController(view, config, routeBuilder: loginBuilder)
		_ = SearchController(view, config, routeBuilder: loginBuilder)
		
		_ = try PageController(view, config, adminRouteBuilder: adminBuilder, publicRouteBuilder: loginBuilder)
		_ = try ArticleController(view, config, adminRouteBuilder: adminBuilder, publicRouteBuilder: loginBuilder)
	}
}
