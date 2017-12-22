import Paginator

final class PageProvider {
	
	static func allPages() throws -> [Page] {
		return try Page
			.makeQuery()
			.sort(Page.createdAtKey, .descending)
			.all()
	}
	
	static func pageWithSlug(_ slug: String) throws -> Page? {
		return try Page
			.makeQuery()
			.filter("slug", .equals, slug)
			.first()
	}
	
	static func pagesWithKeyword(_ keyword: String) throws -> [Page] {
		return try Page
			.makeQuery()
			.or() { orGroup in
				try orGroup.filter("name", .contains, keyword)
				try orGroup.filter("body", .contains, keyword)
			}
			.sort(Page.createdAtKey, .descending)
			.all()
	}
	
	static func pageWithId(_ id: String) throws -> Page? {
		return try Page
			.find(id)
	}
	
	static func pagesWithKeywordPaginated(_ keyword: String, count: Int, request: Request) throws -> Paginator<Page> {
		return try Page
			.makeQuery()
			.or() { orGroup in
				try orGroup.filter("name", .contains, keyword)
				try orGroup.filter("body", .contains, keyword)
			}
			.sort(Page.createdAtKey, .descending)
			.paginator(count, request: request)
	}
}
