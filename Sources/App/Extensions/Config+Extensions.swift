import LeafProvider
import FluentProvider
import MySQLProvider
import AuthProvider
import MarkdownProvider
import Paginator

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
		Node.fuzzy = [JSON.self, Node.self]

        try setupProviders()
		setupPreparations()
    }

    private func setupProviders() throws {
        try addProvider(LeafProvider.Provider.self)
		try addProvider(FluentProvider.Provider.self)
		try addProvider(MySQLProvider.Provider.self)
		try addProvider(AuthProvider.Provider.self)
		try addProvider(MarkdownProvider.Provider.self)
		try addProvider(PaginatorProvider.self)
    }
	
	private func setupPreparations() {
		self.preparations.append(Page.self)
		self.preparations.append(User.self)
		self.preparations.append(Article.self)
		self.preparations.append(Upload.self)
	}
}
