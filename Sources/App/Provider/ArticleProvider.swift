final class ArticleProvider {
	
	static func allArticles() throws -> [Article] {
		return try Article
			.all()
	}
	
	static func articleWithId(_ id: String) throws -> Article? {
		return try Article
			.find(id)
	}
}

