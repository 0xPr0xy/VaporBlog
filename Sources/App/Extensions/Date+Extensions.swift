import Fluent
import Foundation

extension Date {
	
	func formatted() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .short
		
		return dateFormatter.string(from: self)
	}
}
