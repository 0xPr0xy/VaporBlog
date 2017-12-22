import Vapor
import HTTP

final class ArticleController {
	
	let view: ViewRenderer
	let adminRouteBuilder: RouteBuilder
	let publicRouteBuilder: RouteBuilder
	
	init(_ view: ViewRenderer, adminRouteBuilder: RouteBuilder, publicRouteBuilder: RouteBuilder) throws {
		self.view = view
		self.adminRouteBuilder = adminRouteBuilder
		self.publicRouteBuilder = publicRouteBuilder
		
		try self.addRoutes()
	}
	
	// MARK: - Public Routes -
	
	func view(_ request: Request) throws -> ResponseRepresentable {
		let article = try ArticleProvider.shared.getArticleFromRequest(request)
		let pages = try PageProvider.shared.allPages()
		
		return try view.makeArticleView(request, pages: pages, article: article)
	}
	
	// MARK: - Private Routes -

	func list(_ request: Request) throws -> ResponseRepresentable {
		let articles = try ArticleProvider.shared.allArticles()
		
		return try view.makeArticleListView(request, articles: articles)
	}
	
	func new(_ request: Request) throws -> ResponseRepresentable {
		let pages = try PageProvider.shared.allPages()
		
		return try view.makeNewArticleView(request, pages: pages)
	}
	
	func save(_ request: Request) throws -> ResponseRepresentable {
		try ArticleProvider.shared.createFromRequest(request)
		
		return Response(redirect: "/admin/articles")
	}
	
	func showEdit(_ request: Request) throws -> ResponseRepresentable {
		let article = try ArticleProvider.shared.getArticleFromRequest(request)
		let pages = try PageProvider.shared.allPages()

		return try view.makeEditArticleView(request, article: article, pages: pages)
	}
	
	func edit(_ request: Request) throws -> ResponseRepresentable {
		try ArticleProvider.shared.editFromRequest(request)
		
		return Response(redirect: "/admin/articles")
	}
	
	func delete(_ request: Request) throws -> ResponseRepresentable {
		try ArticleProvider.shared.deleteFromRequest(request)
		
		return Response(redirect: "/admin/articles")
	}
	
	// MARK: - Private Methods -
	
	private func addRoutes() throws {
		publicRouteBuilder.get("/:slug/articles/:id", handler: view)
		
		adminRouteBuilder.get("admin/articles", handler: list)
		adminRouteBuilder.get("admin/articles/new", handler: new)
		adminRouteBuilder.post("admin/articles/save", handler: save)
		adminRouteBuilder.get("admin/articles/:id/show", handler: showEdit)
		adminRouteBuilder.post("admin/articles/:id/edit", handler: edit)
		adminRouteBuilder.get("admin/articles/:id/delete", handler: delete)
	}
}

