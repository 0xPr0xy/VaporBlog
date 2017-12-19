final class Fixtures {
	
	enum FixtureError: Error {
		case fixtureDoesNotExist
	}
	
	public static func load(config: Config) throws {
		let blogPage = Page(name: "Blog")
		try blogPage.save()
		
		let blogArticleOne = Article(name: "article 1 name", body: "article body", page: blogPage)
		try blogArticleOne.save()
		
		let blogArticleTwo = Article(name: "article 2 name", body: "article body", page: blogPage)
		try blogArticleTwo.save()
		
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
