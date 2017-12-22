import Vapor
import AuthProvider
import Sessions
import HTTP

final class Routes: RouteCollection {
	
	let view: ViewRenderer
	let uploadDir: String
	let passwordMiddleware: PasswordAuthenticationMiddleware<User>
	let persistMiddleware: PersistMiddleware<User>
	let sessionsMiddleware: SessionsMiddleware
	let redirectMiddleware: RedirectMiddleware
	
	init(_ view: ViewRenderer, uploadDir: String) {
        self.view = view
		self.uploadDir = uploadDir
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
		
		_ = AdminController(view, routeBuilder: adminBuilder)
		_ = UploadController(view, uploadDir: uploadDir, routeBuilder: adminBuilder)

		let loginBuilder = builder.grouped([
			self.sessionsMiddleware,
			self.persistMiddleware
		])
		_ = LoginController(view, routeBuilder: loginBuilder)
		_ = SearchController(view, routeBuilder: loginBuilder)
		
		_ = try PageController(view, adminRouteBuilder: adminBuilder, publicRouteBuilder: loginBuilder)
		_ = try ArticleController(view, adminRouteBuilder: adminBuilder, publicRouteBuilder: loginBuilder)
	}
}
