final class PageProvider {
	static func allPages() throws -> [Page] {
		return try Page
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
				try orGroup.filter("slug", .contains, keyword)
			}.all()
	}
	
	static func pageWithId(_ id: String) throws -> Page? {
		return try Page
			.find(id)
	}
}
