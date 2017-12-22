import Paginator

extension ViewRenderer {

	func makeSearchResultsView(_ request: Request, search: String, pages: [Page], results: Node) throws -> View {
		return try self.make("search", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"searchTerm": search,
			"pages": pages,
			"results": results
			], for: request
		)
	}
}
