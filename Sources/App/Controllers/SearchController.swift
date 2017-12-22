import Vapor
import HTTP

final class SearchController {

	let view: ViewRenderer
	let routeBuilder: RouteBuilder
	
	init(_ view: ViewRenderer, routeBuilder: RouteBuilder) {
		self.view = view
		self.routeBuilder = routeBuilder
		addRoutes()
	}
	
	func search(_ request: Request) throws -> ResponseRepresentable {
		let search = request.query?["search"]?.string ?? ""
		let pages = try PageProvider.shared.allPages()
		let results = try ArticleProvider.shared.articlesWithKeywordPaginated(search, count: 10, request: request)
		let resultsWithShortBody = try results.makeNode(in: ArticleContext.short)
		
		return try view.makeSearchResultsView(request, search: search, pages: pages, results: resultsWithShortBody)
	}
	
	private func addRoutes() {
		routeBuilder.get("search", handler: search)
	}
}
