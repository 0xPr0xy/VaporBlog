import Vapor
import HTTP

final class SearchController {

	let view: ViewRenderer
	let config: Config
	let routeBuilder: RouteBuilder
	
	init(_ view: ViewRenderer, _ config: Config, routeBuilder: RouteBuilder) {
		self.view = view
		self.config = config
		self.routeBuilder = routeBuilder
		self.addRoutes()
	}
	
	func search(_ request: Request) throws -> ResponseRepresentable {
		guard let search = request.query?["search"]?.string else {
			return Response(redirect: "/")
		}
		
		let pages = try PageProvider.allPages()
		let results = try ArticleProvider.articlesWithKeywordPaginated(search, count: 10, request: request)
		let resultsWithShortBody = try results.makeNode(in: ArticleContext.short)
		
		return try view.makeSearchResultsView(request, config, search: search, pages: pages, results: resultsWithShortBody)
	}
	
	private func addRoutes() {
		routeBuilder.get("search", handler: search)
	}
}
