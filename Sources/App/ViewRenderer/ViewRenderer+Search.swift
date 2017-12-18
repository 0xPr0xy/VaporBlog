extension ViewRenderer {

	func makeSearchResultsView(_ request: Request, _ config: Config, search: String, pages: [Page], results: [Page]) throws -> View {
		return try self.make("search", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"searchTerm": search,
			"pages": pages,
			"results": results,
			"google_analytics_identifier" : config["third_party", "ga_identifier"]?.string ?? false
			], for: request
		)
	}
}
