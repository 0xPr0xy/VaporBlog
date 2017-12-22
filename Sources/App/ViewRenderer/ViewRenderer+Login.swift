extension ViewRenderer {
	
	func makeLoginView(_ request: Request, pages: [Page]) throws -> View {
		return try self.make("login", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"pages": pages
			], for: request
		)
	}
}
