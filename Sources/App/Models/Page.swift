import Foundation
import FluentProvider
import Slugify

final class Page: Model, Parameterizable, Timestampable {
	
	var name: String
	var slug: String
	var intro: String?
	var body: String?
	
	let storage = Storage()
	
	init(name: String) {
		self.name = name
		self.slug = self.name.slugify()
	}
	
	init(name: String, slug: String) {
		self.name = name
		self.slug = slug
	}
	
	init(row: Row) throws {
		name = try row.get("name")
		slug = try row.get("slug")
		body = try row.get("body")
		intro = try row.get("intro")
	}
	
	func makeRow() throws -> Row {
		var row = Row()
		try row.set("name", name)
		try row.set("slug", slug)
		try row.set("body", body)
		try row.set("intro", intro)
		
		return row
	}
}

// MARK: - Relations -

extension Page {
	
	var articles: Children<Page, Article> {
		return children()
	}

}

// MARK: - Conformance -

extension Page: NodeRepresentable {
	
	func makeNode(in context: Context?) throws -> Node {
		var node = Node(context)
		try node.set("name", name)
		try node.set("body", body)
		try node.set("intro", intro)
		try node.set("slug", slug)
		try node.set("created_at", createdAt!.formatted())
		try node.set("updated_at", updatedAt!.formatted())
		try node.set("id", id)
		
		return node
	}
}

extension Page: Preparation {
	
	static func prepare(_ database: Database) throws {
		try database.create(self) { pages in
			pages.id()
			pages.string("name")
			pages.text("body", optional: true, unique: false, default: nil)
			pages.text("intro", optional: true, unique: false, default: nil)
			pages.string("slug", unique: true)
		}
	}
	
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}
