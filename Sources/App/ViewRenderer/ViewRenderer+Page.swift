import Paginator

extension ViewRenderer {
	
	func makePageView(_ request: Request, _ config: Config, pages: [Page], page: Page? = nil, articles: Paginator<Article>?) throws -> View {
		return try self.make("page", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"pages": pages,
			"page":  page ?? false,
			"articles": articles ?? [],
			"google_analytics_identifier" : config["third_party", "ga_identifier"]?.string ?? false,
			"disqus_name" : config["third_party", "disqus_name"]?.string ?? false
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
