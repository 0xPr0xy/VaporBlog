import Paginator

extension ViewRenderer {
	
	func makePageView(_ request: Request, pages: [Page], page: Page? = nil, articles: Node?, slug: String?) throws -> View {
		return try self.make("page", [
			"currentSlug": slug ?? "",
			"pages": pages,
			"page":  page as Any,
			"articles": articles as Any
			], for: request
		)
	}
	
	func makePageListView(_ request: Request, pages: [Page]) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/pages/listPages", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user":  user,
			"pages": pages,
			"title": "Pages Admin"
			], for: request
		)
	}

	func makeNewPageView(_ request: Request) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/pages/newPage", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"title": "New Page",
			], for: request
		)
	}
	
	func makeEditPageView(_ request: Request, page: Page) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/pages/editPage", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"page": page,
			"title": "Edit Page",
			], for: request
		)
	}
}
