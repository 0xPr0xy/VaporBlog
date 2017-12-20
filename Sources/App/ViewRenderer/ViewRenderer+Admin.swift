extension ViewRenderer {
	
	func makeAdminView(_ request: Request, _ config: Config, title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		let analyticsClient = config["third_party", "ga_api_client_id"]?.string

		return try self.make("admin/admin", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"title": title,
			"analytics_client_id": analyticsClient ?? false
			], for: request
		)
	}
}
