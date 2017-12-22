import Foundation
import FluentProvider

final class Upload: Model, Parameterizable, Timestampable {
	
	var name: String
	var path: String
	
	let storage = Storage()
	
	init(name: String, path: String) {
		self.name = name
		self.path = path
	}
	
	init(row: Row) throws {
		name = try row.get("name")
		path = try row.get("path")
	}
	
	func makeRow() throws -> Row {
		var row = Row()
		try row.set("name", name)
		try row.set("path", path)
		
		return row
	}
}

// MARK: - Conformance -

extension Upload: NodeRepresentable {
	
	func makeNode(in context: Context?) throws -> Node {
		var node = Node(context)
		try node.set("name", name)
		try node.set("path", path)
		try node.set("created_at", createdAt!.formatted())
		try node.set("id", id)
		
		return node
	}
}

extension Upload: Preparation {
	
	static func prepare(_ database: Database) throws {
		try database.create(self) { pages in
			pages.id()
			pages.string("name")
			pages.string("path", unique: true)
		}
	}
	
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}

