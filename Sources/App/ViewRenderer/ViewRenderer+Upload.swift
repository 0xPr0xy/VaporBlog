import Paginator

extension ViewRenderer {
	
	func makeUploadListView(_ request: Request, uploads: [Upload], title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/uploads/listUploads", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user":  user,
			"uploads": uploads,
			"title": title
			], for: request
		)
	}
	
	func makeNewUploadView(_ request: Request, title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/uploads/newUpload", [
			"title": title,
			"user": user
			], for: request)
	}
}
