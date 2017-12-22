import Paginator

final class ArticleProvider {
	
	static func allArticles() throws -> [Article] {
		return try Article
			.makeQuery()
			.sort(Article.createdAtKey, .descending)
			.all()
	}
	
	static func articleWithId(_ id: String) throws -> Article? {
		return try Article
			.find(id)
	}
	
	static func articlesWithKeywordPaginated(_ keyword: String, count: Int, request: Request) throws -> Paginator<Article> {
		return try Article
			.makeQuery()
			.or() { orGroup in
				try orGroup.filter("name", .contains, keyword)
				try orGroup.filter("body", .contains, keyword)
			}
			.sort(Article.createdAtKey, .descending)
			.paginator(count, request: request)
	}
}

