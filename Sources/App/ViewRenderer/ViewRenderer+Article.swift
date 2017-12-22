extension ViewRenderer {
	
	func makeArticleView(_ request: Request, pages: [Page], article: Article) throws -> View {
		return try self.make("article", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"article": article,
			"pages": pages
			], for: request
		)
	}
	
	func makeArticleListView(_ request: Request, articles: [Article], title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/articles/listArticles", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user":  user,
			"articles": articles,
			"title": title
			], for: request
		)
	}
	
	func makeNewArticleView(_ request: Request, pages: [Page], title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/articles/newArticle", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"title": title,
			"pages": pages
			], for: request
		)
	}
	
	func makeEditArticleView(_ request: Request, article: Article, pages: [Page], title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/articles/editArticle", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"article": article,
			"title": title,
			"pages": pages
			], for: request
		)
	}
}
