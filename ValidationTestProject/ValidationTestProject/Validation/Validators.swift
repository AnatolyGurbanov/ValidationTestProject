//
//  Validators.swift
//  ValidationTestProject
//
//  Created by Anatoly Gurbanov on 15.02.2021.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case username
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .username: return UserNameValidator()
        }
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Минимальная длина логина - 3 символа")
        }
        guard value.count < 32 else {
            throw ValidationError("Максимальная длина логина - 32 символа")
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{3,32}$",
                                       options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)
                                       ) == nil {
                throw ValidationError("Никнейм не может содержать пробелы, начинаться с чисел или других символов")
            }
        } catch {
            throw ValidationError("Никнейм не может содержать пробелы, начинаться с чисел или других символов")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        
        guard value.count >= 3 else {
            throw ValidationError("Минимальная длина логина - 3 символа")
        }
        guard value.count < 32 else {
            throw ValidationError("Максимальная длина логина - 32 символа")
        }
        
        let unacceptableCharacters = ".-0123456789"
        try unacceptableCharacters.forEach {
            if value.first == $0 {
                throw ValidationError("Логин не может начинаться на цифру, точку, минус")
            }
        }

        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,32}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Неверный почтовый ящик")
            }
        } catch {
            throw ValidationError("Неверный почтовый ящик")
        }
        return value
    }
}
