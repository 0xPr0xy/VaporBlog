import Foundation

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
	
	func deleteFromRequest(_ request: Request) throws {
		let upload = try getFromRequest(request)
		
		do {
			try FileManager.default.removeItem(atPath: upload.path)
			try upload.delete()
		} catch {
			throw Abort.serverError
		}
	}
	
	func createFromRequest(_ request: Request, path: String) throws {
		guard let fileBytes = request.formData?["file"]?.part.body else {
			throw Abort.badRequest
		}
		
		guard let fileName = request.formData?["file"]?.filename else {
			throw Abort.badRequest
		}
		
		let safeFilename = fileName.urlQueryPercentEncoded
		let fileUrl = URL(fileURLWithPath: path)
			.appendingPathComponent(safeFilename, isDirectory: false)
		
		do {
			let data = Data(bytes: fileBytes)
			try data.write(to: fileUrl)
		} catch {
			throw Abort.serverError
		}
		
		do {
			let newUpload = Upload(name: fileName, path: fileUrl.relativePath)
			try newUpload.save()
		} catch {
			throw Abort.serverError
		}
	}
	
	func getFromRequest(_ request: Request) throws -> Upload {
		guard let id = request.parameters["id"]?.string! else {
			throw Abort.badRequest
		}
		
		guard let upload = try uploadWithId(id) else {
			throw Abort.notFound
		}
		
		return upload
	}
}
