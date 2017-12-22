import Vapor
import HTTP

final class PageController {
	
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
		let slug = request.uri.lastPathComponent ?? ""
		
		if slug.isEmpty {
			if let page = try PageProvider.shared.pageWithId("1") {
				return Response(redirect: page.slug)
			}
		}

		let page = try PageProvider.shared.pageWithSlug(slug)
		let articles = try ArticleProvider.shared.articlesFromPage(page!, request: request)
		let articlesWithShortBody = try articles.makeNode(in: ArticleContext.short)
		let pages = try PageProvider.shared.allPages()
		
		return try view.makePageView(request, pages: pages, page: page, articles: articlesWithShortBody, slug: slug)
	}
	
	// MARK: - Private Routes -
	
	func list(_ request: Request) throws -> ResponseRepresentable {
		let pages = try PageProvider.shared.allPages()
		
		return try view.makePageListView(request, pages: pages)
	}
	
	func new(_ request: Request) throws -> ResponseRepresentable {
		return try view.makeNewPageView(request)
	}
	
	func save(_ request: Request) throws -> ResponseRepresentable {
		let page = try PageProvider.shared.createFromRequest(request)
		
		self.publicRouteBuilder.get(page.slug, handler: view)
		
		return Response(redirect: "/admin/pages")
	}
	
	func showEdit(_ request: Request) throws -> ResponseRepresentable {
		let page = try PageProvider.shared.getFromRequest(request)

		return try view.makeEditPageView(request, page: page)
	}
	
	func edit(_ request: Request) throws -> ResponseRepresentable {
		try PageProvider.shared.editFromRequest(request)
		
		return Response(redirect: "/admin/pages")
	}
	
	func delete(_ request: Request) throws -> ResponseRepresentable {
		try PageProvider.shared.deleteFromRequest(request)
		
		return Response(redirect: "/admin/pages")
	}
	
	// MARK: - Private Methods -
	
	private func addRoutes() throws {
		adminRouteBuilder.get("admin/pages", handler: list)
		adminRouteBuilder.get("admin/pages/new", handler: new)
		adminRouteBuilder.post("admin/pages/save", handler: save)
		adminRouteBuilder.get("admin/pages/:id/show", handler: showEdit)
		adminRouteBuilder.post("admin/pages/:id/edit", handler: edit)
		adminRouteBuilder.get("admin/pages/:id/delete", handler: delete)
		
		publicRouteBuilder.get(handler: view)
		try PageProvider.shared.allPages().forEach { (page) in
			publicRouteBuilder.get(page.slug, handler: view)
		}
	}
}
