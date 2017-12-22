@_exported import Vapor

import LeafProvider

extension Droplet {
	
    public func setup() throws {
		try loadFixtures() // needs to be done before routing
		try registerRoutes()
		try registerTags()
    }
	
	private func registerTags() throws {
		if let leaf = view as? LeafRenderer {
			let tag = try TemplateVariable(config: config)
			leaf.stem.register(tag)
		}
	}
	
	private func registerRoutes() throws {
		let uploadDir = config.workDir.appending("/Public/static/uploads")
		let routes = Routes(view, uploadDir: uploadDir)
		
		try collection(routes)
	}
	
	private func loadFixtures() throws {
		if config.environment == .development {
			if try Page.all().isEmpty {
				try PageFixtures.load()
			}
		}
		
		if try User.all().isEmpty {
			guard
				let password = config["credentials", "admin_password"]?.string,
				let username = config["credentials", "admin_username"]?.string
			else {
				fatalError("set the 'admin_password' and 'admin_username' in 'credentials.json'")
			}
			
			let user = User(username: username, password: password)
			try user.save()
		}
	}
}
