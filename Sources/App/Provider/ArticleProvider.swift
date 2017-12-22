import Paginator
import Fluent

final class ArticleProvider {
	
	static let shared = ArticleProvider()
	private init() {}
	
	func allArticles() throws -> [Article] {
		return try Article
			.makeQuery()
			.sort(Article.createdAtKey, .descending)
			.all()
	}
	
	func articleWithId(_ id: String) throws -> Article? {
		return try Article
			.find(id)
	}
	
	func articlesWithKeywordPaginated(_ keyword: String, count: Int, request: Request) throws -> Paginator<Article> {
		return try Article
			.makeQuery()
			.or() { orGroup in
				try orGroup.filter("name", .contains, keyword)
				try orGroup.filter("body", .contains, keyword)
			}
			.sort(Article.createdAtKey, .descending)
			.paginator(count, request: request)
	}
	
	func articlesFromPage(_ page: Page, request: Request) throws -> Paginator<Article> {
		return try page
			.articles
			.sort(Article.updatedAtKey, .descending)
			.all()
			.paginator(3, request: request)
	}
	
	func createFromRequest(_ request: Request) throws {
		guard
			let name = request.formURLEncoded?["name"]?.string,
			let body = request.formURLEncoded?["body"]?.string,
			let pageId = request.formURLEncoded?["page_id"]?.string
		else {
			throw Abort.badRequest
		}
		
		guard let page = try PageProvider.shared.pageWithId(pageId) else {
			throw Abort.badRequest
		}
		
		let article = Article(name: name, body: body, page: page)
		try article.save()
	}
	func editFromRequest(_ request: Request) throws {
		let article = try getArticleFromRequest(request)
		
		guard
			let name = request.formURLEncoded?["name"]?.string,
			let body = request.formURLEncoded?["body"]?.string,
			let pageId = request.formURLEncoded?["page_id"]?.string
		else {
			throw Abort.badRequest
		}
		
		guard let page = try PageProvider.shared.pageWithId(pageId) else {
			throw Abort.badRequest
		}
		
		article.name = name
		article.body = body
		article.pageID = page.id
		
		try article.save()
	}
	
	func deleteFromRequest(_ request: Request) throws {
		let article = try getArticleFromRequest(request)
		try article.delete()
	}
	
	func getArticleFromRequest(_ request: Request) throws -> Article {
		guard let id = request.parameters["id"]?.string! else {
			throw Abort.badRequest
		}
		
		guard let article = try articleWithId(id) else {
			throw Abort.notFound
		}
		
		return article
	}
}

