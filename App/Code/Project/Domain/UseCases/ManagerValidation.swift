import Foundation

public class ManagerValidation {

    static public func isUsernameValid(_ username: String?) -> Bool {
        guard let username = username else {
            return false
        }
        let isValidLength = username.length > 3
        let isValidEmail = self.isEmailValid(username)
        return isValidLength && isValidEmail
    }

    static public func isEmailValid(_ email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        let isEmailValid = self.isEmailValid(email)
        return isEmailValid
    }

    static public func isPasswordValid(_ password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        let isValidLength = password.length > 4
        return isValidLength
    }

    static public func isPasswordRepeatValid(password: String?, passwordRepeat: String?) -> Bool {
        guard isPasswordValid(password) == true else {
            return false
        }
        let isValidMatch = password == passwordRepeat
        return isValidMatch
    }

    fileprivate static func isEmailValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._!#$%’*+-/=?^_`{|}~]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
