final class PageFixtures {
	
	public static func load(config: Config) throws {
		let blogPage = Page(name: "Blog")
		blogPage.body = "Enamel pin mumblecore sriracha single-origin coffee tacos, mixtape VHS fingerstache keffiyeh. Narwhal cray yr four dollar toast. YOLO fingerstache cold-pressed wolf keytar woke neutra echo park messenger bag +1 copper mug tumblr mustache vape taxidermy. Pork belly biodiesel post-ironic whatever cold-pressed kogi try-hard marfa celiac affogato raclette migas. Blog literally lomo, try-hard williamsburg fashion axe succulents twee. Snackwave swag four loko tilde, vice echo park fanny pack af truffaut bushwick. Flannel glossier swag mlkshk. Vexillologist paleo VHS cold-pressed glossier raw denim put a bird on it hexagon twee small batch. Vape YOLO readymade poke 3 wolf moon kickstarter post-ironic twee jean shorts you probably haven't heard of them salvia single-origin coffee locavore flannel. Organic fam cold-pressed next level, dreamcatcher selfies man bun glossier. Slow-carb la croix paleo echo park pok pok cray meggings mustache bushwick. Wayfarers cray migas post-ironic blue bottle, roof party irony vaporware knausgaard chillwave vape kinfolk. Oh. You need a little dummy text for your mockup? How quaint. I bet you’re still using Bootstrap too…"
		try blogPage.save()
		
		let blogArticleOne = Article(name: "Syntax Test", body: "~~~.language-swift\nfunc helloWorld() {\n print(\"Hello, World!\")\n}\n~~~", page: blogPage)
		try blogArticleOne.save()
		
		let blogArticleTwo = Article(name: "Blue bottle snackwave", body: "Lorem ipsum dolor amet tumeric tousled selfies polaroid cardigan crucifix 3 wolf moon snackwave kickstarter bicycle rights distillery bespoke. Selvage craft beer mixtape typewriter, brunch scenester activated charcoal schlitz knausgaard cliche hot chicken glossier taiyaki affogato. PBR&B pinterest 3 wolf moon cardigan, hot chicken live-edge adaptogen readymade man bun occupy deep v. Hashtag coloring book brunch 8-bit glossier next level affogato everyday carry gastropub, poutine distillery small batch offal.", page: blogPage)
		try blogArticleTwo.save()
		
		let aboutPage = Page(name: "About")
		aboutPage.body = "Live-edge tote bag church-key keytar meggings. Four dollar toast pinterest butcher cold-pressed scenester messenger bag crucifix paleo. Neutra wayfarers tacos, hoodie iceland master cleanse blog letterpress mixtape hashtag DIY next level pour-over hella. Cardigan YOLO kickstarter, pickled four loko microdosing try-hard tbh forage cloud bread yr tumblr flannel."
		try aboutPage.save()
		
		let aboutArticleOne = Article(name: "Bitters iPhone umami pitchfork", body: "Bushwick man braid af, fanny pack brooklyn asymmetrical you probably haven't heard of them hashtag. Next level listicle plaid, cronut cred succulents ethical activated charcoal taxidermy lo-fi hot chicken. Try-hard direct trade poutine, 3 wolf moon etsy meggings art party post-ironic echo park marfa hexagon salvia selvage microdosing yr. Hot chicken tattooed everyday carry schlitz deep v, pickled try-hard PBR&B literally leggings. Pok pok jianbing 90's, taxidermy skateboard yuccie kogi cray jean shorts green juice kickstarter.", page: aboutPage)
		try aboutArticleOne.save()
		
		let projectsPage = Page(name: "Projects")
		projectsPage.body = "Pickled kogi ethical tote bag DIY, next level green juice butcher master cleanse palo santo migas woke retro gluten-free. Farm-to-table street art snackwave actually, williamsburg next level iceland meggings butcher poutine. Asymmetrical art party +1, sriracha distillery keffiyeh 90's. Pop-up raw denim DIY, paleo gastropub photo booth hell of meggings la croix bushwick lyft lomo man bun."
		try projectsPage.save()
		
		let projectsArticleOne = Article(name: "Bushwick man braid", body: "Bushwick man braid af, fanny pack brooklyn asymmetrical you probably haven't heard of them hashtag. Next level listicle plaid, cronut cred succulents ethical activated charcoal taxidermy lo-fi hot chicken. Try-hard direct trade poutine, 3 wolf moon etsy meggings art party post-ironic echo park marfa hexagon salvia selvage microdosing yr. Hot chicken tattooed everyday carry schlitz deep v, pickled try-hard PBR&B literally leggings. Pok pok jianbing 90's, taxidermy skateboard yuccie kogi cray jean shorts green juice kickstarter.", page: projectsPage)
		try projectsArticleOne.save()
	}
}
