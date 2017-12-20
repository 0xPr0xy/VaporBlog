@_exported import Vapor

extension Droplet {
	
    public func setup() throws {
		try loadFixtures()
		try setupRoutes()
    }
	
	private func setupRoutes() throws {
		let routes = Routes(view, config)
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
