import Foundation
import FluentProvider
import Slugify

final class Page: Model, Parameterizable {
	
	var name: String
	var slug: String
	
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
	}
	
	func makeRow() throws -> Row {
		var row = Row()
		try row.set("name", name)
		try row.set("slug", slug)
		
		return row
	}
}

extension Page: NodeRepresentable {
	
	func makeNode(in context: Context?) throws -> Node {
		var node = Node(context)
		try node.set("name", name)
		try node.set("slug", slug)
		try node.set("id", id)
		
		return node
	}
}

extension Page: Preparation {
	
	static func prepare(_ database: Database) throws {
		try database.create(self) { pages in
			pages.id()
			pages.string("name")
			pages.string("slug", unique: true)
		}
	}
	
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}
