import Leaf

class TemplateVariable: BasicTag {
	
	public enum Error: Swift.Error {
		case expectedTemplateConfig
		case expectedOneArgument(got: Int)
		case expectedStringArgument
	}
	
	let name = "templateVariable"
	let templateVariables: Config
	
	init(config: Config) throws {
		guard let templateVariables = config["template"] else {
			throw Error.expectedTemplateConfig
		}
		
		self.templateVariables = templateVariables
	}
	
	func run(arguments: ArgumentList) throws -> Node? {
		guard arguments.list.count == 1 else {
			throw Error.expectedOneArgument(got: arguments.count)
		}
		
		guard let string = arguments.first?.string else {
			throw Error.expectedStringArgument
		}
		
		let components = string.components(separatedBy: ".")
		guard let variable = templateVariables[components] else {
			return nil
		}
		
		return variable.makeNode(in: nil)
	}
}

