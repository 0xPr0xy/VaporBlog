final class Fixtures {
	
	enum FixtureError: Error {
		case fixtureDoesNotExist
	}
	
	public static func load(config: Config) throws {
		let blogPage = Page(name: "Blog")
		try blogPage.save()
		
		let aboutPage = Page(name: "About")
		try aboutPage.save()
		
		let projectsPage = Page(name: "Projects")
		try projectsPage.save()
		
		guard
			let name = config["fixture_user", "name"]?.string,
			let email = config["fixture_user", "email"]?.string,
			let password  = config["fixture_user", "password"]?.string
		else {
			throw FixtureError.fixtureDoesNotExist
		}
		
		let user = User(name: name, email: email, password: password)
		try user.save()
	}
}
