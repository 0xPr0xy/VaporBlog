import Vapor
import HTTP

final class PageController {
	
	let view: ViewRenderer
	let config: Config
	let adminRouteBuilder: RouteBuilder
	let publicRouteBuilder: RouteBuilder
	
	init(_ view: ViewRenderer, _ config: Config, adminRouteBuilder: RouteBuilder, publicRouteBuilder: RouteBuilder) throws {
		self.view = view
		self.config = config
		self.adminRouteBuilder = adminRouteBuilder
		self.publicRouteBuilder = publicRouteBuilder
		
		try self.addRoutes()
	}
	
	// MARK: - Public Routes -
	
	func view(_ request: Request) throws -> ResponseRepresentable {
		let slug = request.uri.lastPathComponent ?? ""
		let page = try PageProvider.pageWithSlug(slug)
		let articles = try page?.articles.all().paginator(3, request: request)
		let articlesWithShortBody = try articles?.makeNode(in: ArticleContext.short)

		let pages = try PageProvider.allPages()
		
		return try view.makePageView(request, config, pages: pages, page: page, articles: articlesWithShortBody)
	}
	
	// MARK: - Private Routes -
	
	func list(_ request: Request) throws -> ResponseRepresentable {
		let pages = try PageProvider.allPages()
		let title = "Pages Admin"
		
		return try view.makePageListView(request, pages: pages, title: title)
	}
	
	func new(_ request: Request) throws -> ResponseRepresentable {
		let title = "New Page"
		
		return try view.makeNewPageView(request, title: title)
	}
	
	func save(_ request: Request) throws -> ResponseRepresentable {
		guard let name = request.formURLEncoded?["name"]?.string else {
			throw Abort.badRequest
		}
		
		let page = Page(name: name)
		if let body = request.formURLEncoded?["body"]?.string {
			page.body = body
		}
		try page.save()
		
		self.publicRouteBuilder.get(page.slug, handler: view)
		
		return Response(redirect: "/admin/pages")
	}
	
	func showEdit(_ request: Request) throws -> ResponseRepresentable {
		let page = try getPage(request)
		let title = "Edit Page"
		
		return try view.makeEditPageView(request, page: page, title: title)
	}
	
	func edit(_ request: Request) throws -> ResponseRepresentable {
		let page = try getPage(request)
		
		guard
			let name = request.formURLEncoded?["name"]?.string
		else {
			throw Abort.badRequest
		}
		
		page.name = name
		
		if let body = request.formURLEncoded?["body"]?.string {
			page.body = body
		}
		
		try page.save()
		
		return Response(redirect: "/admin/pages")
	}
	
	func delete(_ request: Request) throws -> ResponseRepresentable {
		let page = try getPage(request)
		try page.delete()
		
		return Response(redirect: "/admin/pages")
	}
	
	// MARK: - Private Methods -
	
	private func getPage(_ request: Request) throws -> Page {
		guard let id = request.parameters["id"]?.string! else {
			throw Abort.badRequest
		}
		
		guard let page = try PageProvider.pageWithId(id) else {
			throw Abort.notFound
		}
		
		return page
	}
	
	private func addRoutes() throws {
		adminRouteBuilder.get("admin/pages", handler: list)
		adminRouteBuilder.get("admin/pages/new", handler: new)
		adminRouteBuilder.post("admin/pages/save", handler: save)
		adminRouteBuilder.get("admin/pages/:id/show", handler: showEdit)
		adminRouteBuilder.post("admin/pages/:id/edit", handler: edit)
		adminRouteBuilder.get("admin/pages/:id/delete", handler: delete)
		
		publicRouteBuilder.get(handler: view)
		
		try Page.all().forEach { (page) in
			publicRouteBuilder.get(page.slug, handler: view)
		}
	}
}
