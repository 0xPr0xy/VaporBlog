extension ViewRenderer {
	
	func makeLoginView(_ request: Request, _ config: Config, pages: [Page]) throws -> View {
		return try self.make("login", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"pages": pages,
			"google_analytics_identifier" : config["third_party", "ga_identifier"]?.string ?? false
			], for: request
		)
	}
}
