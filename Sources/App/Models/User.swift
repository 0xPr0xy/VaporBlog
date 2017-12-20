import FluentProvider
import HTTP
import Fluent
import AuthProvider

final class User: Model, PasswordAuthenticatable, SessionPersistable {
	
	var username: String
	var password: String
	
	let storage = Storage()

	init(username: String, password: String) {
		self.username = username
		self.password = password
	}
	
	init(row: Row) throws {
		username = try row.get("email")
		password = try row.get("password")
	}
	
	func makeRow() throws -> Row {
		var row = Row()
		try row.set("email", username)
		try row.set("password", password)
		
		return row
	}
}

extension User: NodeRepresentable {
	
	func makeNode(in context: Context?) throws -> Node {
		var node = Node(context)
		try node.set("username", username)
		try node.set("id", id)
		
		return node
	}
}

extension User: Preparation {
	
	static func prepare(_ database: Database) throws {
		try database.create(self) { builder in
			builder.id()
			builder.string("email")
			builder.string("password")
		}
	}
	
	static func revert(_ database: Database) throws {
		try database.delete(self)
	}
}
