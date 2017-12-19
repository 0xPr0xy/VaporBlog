extension ViewRenderer {
	
	func makeArticleView(_ request: Request, _ config: Config, pages: [Page], article: Article) throws -> View {
		return try self.make("article", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"article": article,
			"pages": pages,
			"google_analytics_identifier" : config["third_party", "ga_identifier"]?.string ?? false,
			"disqus_name" : config["third_party", "disqus_name"]?.string ?? false
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
	
	func makeNewArticleView(_ request: Request, title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/articles/newArticle", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"title": title,
			], for: request
		)
	}
	
	func makeEditArticleView(_ request: Request, article: Article, title: String) throws -> View {
		guard let user: User = request.auth.authenticated() else {
			throw Abort.unauthorized
		}
		
		return try self.make("admin/articles/editArticle", [
			"currentSlug": request.uri.lastPathComponent ?? "",
			"user": user,
			"article": article,
			"title": title,
			], for: request
		)
	}
}
