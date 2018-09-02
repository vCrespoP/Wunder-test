import Foundation

public extension NSAttributedString {

    func trimmed(_ set: CharacterSet) -> NSAttributedString {
        let result = self.mutableCopy()

        // Trim leading characters from character set.
        while true {
            let range = ((result as AnyObject).string as NSString).rangeOfCharacter(from: set)

            guard range.length != 0 && range.location == 0 else {
                break
            }

            (result as AnyObject).replaceCharacters(in: range, with: "")
        }

        // Trim trailing characters from character set.
        while true {
            let range = ((result as AnyObject).string as NSString).rangeOfCharacter(from: set, options: .backwards)

            guard range.length != 0 && NSMaxRange(range) == (result as AnyObject).length else {
                break
            }

            (result as AnyObject).replaceCharacters(in: range, with: "")
        }

        return result as! NSAttributedString
    }
}

public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()

    result.append(left)
    result.append(right)

    return result
}

