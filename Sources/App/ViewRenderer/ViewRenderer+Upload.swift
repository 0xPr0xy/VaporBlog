import Paginator

extension ViewRenderer {
	
	func makeUploadListView(_ request: Request, uploads: [Upload]) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/uploads/listUploads", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user":  user,
			"uploads": uploads,
			"title": "Uploads Admin"
			], for: request
		)
	}
	
	func makeNewUploadView(_ request: Request) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/uploads/newUpload", [
			"title": "Upload File",
			"user": user
			], for: request)
	}
}
