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
		let results = try PageProvider.pagesWithKeyword(search)
		
		return try view.makeSearchResultsView(request, config, search: search, pages: pages, results: results)
	}
	
	private func addRoutes() {
		routeBuilder.get("search", handler: search)
	}
}
