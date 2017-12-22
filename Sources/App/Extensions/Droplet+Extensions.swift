@_exported import Vapor

import LeafProvider

extension Droplet {
	
    public func setup() throws {
		try loadFixtures()
		try setupRoutes()
		
		if let leaf = self.view as? LeafRenderer {
			leaf.stem.register(try TemplateVariable(config: self.config))
		}
    }
	
	private func setupRoutes() throws {
		let uploadDir = config.workDir.appending("/Public/static/uploads")
		let routes = Routes(view, uploadDir: uploadDir)
		try collection(routes)
	}
	
	private func loadFixtures() throws {
		
		if config.environment == .development {
			if try Page.all().isEmpty {
				try PageFixtures.load(config: config)
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
