import Vapor
import HTTP
import Foundation

final class UploadController {
	
	let view: ViewRenderer
	let routeBuilder: RouteBuilder
	let uploadDir: String
	
	init(_ view: ViewRenderer, uploadDir: String, routeBuilder: RouteBuilder) {
		self.view = view
		self.uploadDir = uploadDir
		self.routeBuilder = routeBuilder
		self.addRoutes()
	}

	private func list(request: Request) throws -> ResponseRepresentable {
		let uploads = try UploadProvider.allUploads()
		return try view.makeUploadListView(request, uploads: uploads, title: "Uploads Admin")
	}
	
	private func upload(request: Request) throws -> ResponseRepresentable {
		return try view.makeNewUploadView(request, title: "Upload File")
	}
	
	private func delete(_ request: Request) throws -> ResponseRepresentable {
		let upload = try getUpload(request)
		
		do {
			try FileManager.default.removeItem(atPath: upload.path)
			try upload.delete()
		} catch {
			throw Abort.serverError
		}
		
		return Response(redirect: "/admin/uploads")
	}
	
	private func handle(request: Request) throws -> ResponseRepresentable {
		guard let fileBytes = request.formData?["file"]?.part.body else {
			throw Abort.badRequest
		}
		
		guard let fileName = request.formData?["file"]?.filename else {
			throw Abort.badRequest
		}
		
		let fileUrl = URL(fileURLWithPath: uploadDir).appendingPathComponent(fileName.urlQueryPercentEncoded, isDirectory: false)
		
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
		
		return Response(redirect: "/admin/uploads")
	}
	
	// MARK: - Private Methods -
	
	private func getUpload(_ request: Request) throws -> Upload {
		guard let id = request.parameters["id"]?.string! else {
			throw Abort.badRequest
		}
		
		guard let upload = try UploadProvider.uploadWithId(id) else {
			throw Abort.notFound
		}
		
		return upload
	}
	
	private func addRoutes() {
		routeBuilder.get("admin/uploads/:id/delete", handler: delete)
		routeBuilder.get("admin/uploads/new", handler: upload)
		routeBuilder.get("admin/uploads", handler: list)
		routeBuilder.post("admin/uploads/new", handler: handle)
	}
}

