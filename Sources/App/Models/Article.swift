import Foundation
import FluentProvider
import Slugify

public enum ArticleContext: Context {
	case short
}

final class Article: Model, Parameterizable {
	
	var name: String
	var body: String
	var slug: String
	var pageID: Identifier?
	
	let storage = Storage()
	
	init(name: String, body: String, page: Page) {
		self.name = name
		self.body = body
		self.pageID = page.id
		self.slug = self.name.slugify()
	}
	
	init(name: String, slug: String, body: String, page: Page) {
		self.name = name
		self.slug = slug
		self.body = body
		self.pageID = page.id
	}
	
	init(row: Row) throws {
		name = try row.get("name")
		slug = try row.get("slug")
		body = try row.get("body")
		pageID = try row.get(Page.foreignIdKey)
	}
	
	func makeRow() throws -> Row {
		var row = Row()
		try row.set("name", name)
		try row.set("slug", slug)
		try row.set("body", body)
		try row.set(Page.foreignIdKey, pageID)
		
		return row
	}
}

// MARK: - Relations -

extension Article {
	
	var page: Parent<Article, Page> {
		return parent(id: pageID)
	}

}

// MARK: - Conformance -

extension Article: NodeRepresentable {
	
	func makeNode(in context: Context?) throws -> Node {
		var node = Node(context)
		try node.set("name", name)
		try node.set("slug", slug)
		try node.set("id", id)
		try node.set("page", page.get())
		
		guard let providedContext = context else {
			try node.set("body", body)
			return node
		}

		if type(of: providedContext) != ArticleContext.self {
			try node.set("body", body)
			return node
		}
		
		switch providedContext {
			case ArticleContext.short:
				try node.set("body", partialBody(numberOfCharacters: 750))
				break
			default: break
		}
		
		return node
	}
}

extension Article: Preparation {
	
	static func prepare(_ database: Database) throws {
		try database.create(self) { article in
			article.id()
			article.string("name")
			article.string("slug", unique: true)
			article.text("body")
			article.parent(Page.self, optional: false, unique: false, foreignIdKey: Page.foreignIdKey)
		}
	}
	
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}

// MARK: Utilities

extension Article {
	
	func partialBody(numberOfCharacters: Int) -> String {
		if body.count <= numberOfCharacters {
			return body
		}
		
		return String(body.prefix(numberOfCharacters).appending("..."))
	}
}

