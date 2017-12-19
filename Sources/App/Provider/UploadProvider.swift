final class UploadProvider {
	
	static func allUploads() throws -> [Upload] {
		return try Upload
			.all()
	}
	
	static func uploadWithId(_ id: String) throws -> Upload? {
		return try Upload
			.find(id)
	}
}
