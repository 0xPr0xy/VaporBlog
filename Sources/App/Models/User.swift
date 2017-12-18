import FluentProvider
import HTTP
import Fluent
import AuthProvider

final class User: Model, PasswordAuthenticatable, SessionPersistable {
	
	var name: String
	var email: String
	var password: String
	
	let storage = Storage()

	init(name: String, email: String, password: String) {
		self.name = name
		self.email = email
		self.password = password
	}
	
	init(row: Row) throws {
		name = try row.get("name")
		email = try row.get("email")
		password = try row.get("password")
	}
	
	func makeRow() throws -> Row {
		var row = Row()
		try row.set("name", name)
		try row.set("email", email)
		try row.set("password", password)
		
		return row
	}
}

extension User: NodeRepresentable {
	
	func makeNode(in context: Context?) throws -> Node {
		var node = Node(context)
		try node.set("name", name)
		try node.set("id", id)
		
		return node
	}
}

extension User: Preparation {
	
	static func prepare(_ database: Database) throws {
		try database.create(self) { builder in
			builder.id()
			builder.string("name")
			builder.string("email")
			builder.string("password")
		}
	}
	
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}
