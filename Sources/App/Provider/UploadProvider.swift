final class UploadProvider {
	
	static let shared = UploadProvider()
	private init() {}
	
	func allUploads() throws -> [Upload] {
		return try Upload
			.makeQuery()
			.sort(Upload.createdAtKey, .descending)
			.all()
	}
	
	func uploadWithId(_ id: String) throws -> Upload? {
		return try Upload
			.find(id)
	}
}
