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
		addRoutes()
	}

	private func list(request: Request) throws -> ResponseRepresentable {
		let uploads = try UploadProvider.shared.allUploads()
		
		return try view.makeUploadListView(request, uploads: uploads)
	}
	
	private func upload(request: Request) throws -> ResponseRepresentable {
		return try view.makeNewUploadView(request)
	}
	
	private func delete(_ request: Request) throws -> ResponseRepresentable {
		try UploadProvider.shared.deleteFromRequest(request)
		
		return Response(redirect: "/admin/uploads")
	}
	
	private func handle(request: Request) throws -> ResponseRepresentable {
		try UploadProvider.shared.createFromRequest(request, path: uploadDir)
		
		return Response(redirect: "/admin/uploads")
	}
	
	// MARK: - Private Methods -

	private func addRoutes() {
		routeBuilder.get("admin/uploads/:id/delete", handler: delete)
		routeBuilder.get("admin/uploads/new", handler: upload)
		routeBuilder.get("admin/uploads", handler: list)
		routeBuilder.post("admin/uploads/new", handler: handle)
	}
}

