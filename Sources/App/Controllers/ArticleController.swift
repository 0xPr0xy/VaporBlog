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
		let article = try getArticle(request)
		let pages = try PageProvider.shared.allPages()
		
		return try view.makeArticleView(request, pages: pages, article: article)
	}
	
	// MARK: - Private Routes -

	func list(_ request: Request) throws -> ResponseRepresentable {
		let articles = try ArticleProvider.shared.allArticles()
		let title = "Articles Admin"
		
		return try view.makeArticleListView(request, articles: articles, title: title)
	}
	
	func new(_ request: Request) throws -> ResponseRepresentable {
		let title = "New Article"
		let pages = try PageProvider.shared.allPages()
		
		return try view.makeNewArticleView(request, pages: pages, title: title)
	}
	
	func save(_ request: Request) throws -> ResponseRepresentable {
		guard
			let name = request.formURLEncoded?["name"]?.string,
			let body = request.formURLEncoded?["body"]?.string,
			let pageId = request.formURLEncoded?["page_id"]?.string
		else {
			throw Abort.badRequest
		}
		
		guard let page = try Page.find(pageId) else {
			throw Abort.badRequest
		}
		
		let article = Article(name: name, body: body, page: page)
		try article.save()
		
		return Response(redirect: "/admin/articles")
	}
	
	func showEdit(_ request: Request) throws -> ResponseRepresentable {
		let article = try getArticle(request)
		let title = "Edit Article"
		let pages = try PageProvider.shared.allPages()

		return try view.makeEditArticleView(request, article: article, pages: pages, title: title)
	}
	
	func edit(_ request: Request) throws -> ResponseRepresentable {
		let article = try getArticle(request)
		
		guard
			let name = request.formURLEncoded?["name"]?.string,
			let body = request.formURLEncoded?["body"]?.string,
			let pageId = request.formURLEncoded?["page_id"]?.string
		else {
			throw Abort.badRequest
		}
		
		guard let page = try Page.find(pageId) else {
			throw Abort.badRequest
		}
		
		article.name = name
		article.body = body
		article.pageID = page.id
		
		try article.save()
		
		return Response(redirect: "/admin/articles")
	}
	
	func delete(_ request: Request) throws -> ResponseRepresentable {
		let article = try getArticle(request)
		try article.delete()
		
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
	
	private func getArticle(_ request: Request) throws -> Article {
		guard let id = request.parameters["id"]?.string! else {
			throw Abort.badRequest
		}
		
		guard let article = try ArticleProvider.shared.articleWithId(id) else {
			throw Abort.notFound
		}
		
		return article
	}
}

