import Paginator

extension ViewRenderer {
	
	func makePageView(_ request: Request, pages: [Page], page: Page? = nil, articles: Node?) throws -> View {
		return try self.make("page", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"pages": pages,
			"page":  page as Any,
			"articles": articles as Any
			], for: request
		)
	}
	
	func makePageListView(_ request: Request, pages: [Page], title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/pages/listPages", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user":  user,
			"pages": pages,
			"title": title
			], for: request
		)
	}

	func makeNewPageView(_ request: Request, title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/pages/newPage", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"title": title,
			], for: request
		)
	}
	
	func makeEditPageView(_ request: Request, page: Page, title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/pages/editPage", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"page": page,
			"title": title,
			], for: request
		)
	}
}
