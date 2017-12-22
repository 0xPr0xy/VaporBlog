import Paginator

final class PageProvider {
	
	static let shared = PageProvider()
	private init() {}
	
	func allPages() throws -> [Page] {
		return try Page
			.makeQuery()
			.sort(Page.idKey, .ascending)
			.all()
	}
	
	func pageWithSlug(_ slug: String) throws -> Page? {
		return try Page
			.makeQuery()
			.filter("slug", .equals, slug)
			.first()
	}

	func pageWithId(_ id: String) throws -> Page? {
		return try Page
			.find(id)
	}
	
	func createFromRequest(_ request: Request) throws -> Page {
		guard let name = request.formURLEncoded?["name"]?.string else {
			throw Abort.badRequest
		}
		
		let page = Page(name: name)
		if let body = request.formURLEncoded?["body"]?.string {
			page.body = body
		}
		
		if let intro = request.formURLEncoded?["intro"]?.string {
			page.intro = intro
		}
		
		try page.save()
		
		return page
	}
	
	func editFromRequest(_ request: Request) throws {
		let page = try getFromRequest(request)
		
		guard
			let name = request.formURLEncoded?["name"]?.string
		else {
			throw Abort.badRequest
		}
		
		page.name = name
		
		if let body = request.formURLEncoded?["body"]?.string {
			page.body = body
		}
		
		if let intro = request.formURLEncoded?["intro"]?.string {
			page.intro = intro
		}
		
		try page.save()
	}
	
	func deleteFromRequest(_ request: Request) throws {
		let page = try getFromRequest(request)
		try page.delete()
	}
	
	func getFromRequest(_ request: Request) throws -> Page {
		guard let id = request.parameters["id"]?.string! else {
			throw Abort.badRequest
		}
		
		guard let page = try pageWithId(id) else {
			throw Abort.notFound
		}
		
		return page
	}
}
