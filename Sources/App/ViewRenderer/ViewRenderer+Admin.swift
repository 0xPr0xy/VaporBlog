extension ViewRenderer {
	
	func makeAdminView(_ request: Request, title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/admin", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"title": title
			], for: request
		)
	}
}
