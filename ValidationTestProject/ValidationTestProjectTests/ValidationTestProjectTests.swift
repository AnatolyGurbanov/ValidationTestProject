//
//  ValidationTestProjectTests.swift
//  ValidationTestProjectTests
//
//  Created by Anatoly Gurbanov on 15.02.2021.
//

import XCTest
@testable import ValidationTestProject

class ValidationTestProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmailValidation() throws {
        let validator = EmailValidator()
        let shortEmail = try? validator.validated( "ab")
        XCTAssertNil(shortEmail)
        
        let tooLongEmail = try? validator.validated("ABCDEFGHIJKLMNOPQRSTUVWXY@gmail.com") //36 chars
        XCTAssertNil(tooLongEmail)
        
        let whitespaceEmail = try? validator.validated("a cv as@gmail.com")
        XCTAssertNil(whitespaceEmail)
        
        let specialCharactersEmail = try? validator.validated("a#as!@gmail.com")
        XCTAssertNil(specialCharactersEmail)
        
        let dotStartedEmail = try? validator.validated(".aas@gmail.com")
        XCTAssertNil(dotStartedEmail)
        
        let validMixedWithNumberEmail = "and.123@GMAIL.COM"
        let validatedNumbersEmail = try? validator.validated(validMixedWithNumberEmail)
        XCTAssertEqual(validMixedWithNumberEmail, validatedNumbersEmail)
        
        let validMixedWithMinusEmail = "and-123@GMAIL.COM"
        let validatedMinusEmail = try? validator.validated(validMixedWithMinusEmail)
        XCTAssertEqual(validMixedWithMinusEmail, validatedMinusEmail)
        
        let mixedWithNumbers2 = try? validator.validated("123as@gmail.com")
        XCTAssertNil(mixedWithNumbers2)
        
        let validUsername = "validemail@gmail.com"
        let validatedUsername = try? validator.validated(validUsername)
        XCTAssertEqual(validUsername, validatedUsername)
    }

    func testNicknameValidation() throws {
        let validator = UserNameValidator()
        let shortUsername = try? validator.validated( "ab")
        XCTAssertNil(shortUsername)
        
        let tooLongUsername = try? validator.validated("ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFG") //33 chars
        XCTAssertNil(tooLongUsername)
        
        let whitespaceUsername = try? validator.validated("a cv as")
        XCTAssertNil(whitespaceUsername)
        
        let specialCharactersUsername = try? validator.validated("a#as!")
        XCTAssertNil(specialCharactersUsername)
        
        let mixedWithNumbers = try? validator.validated("arlind123")
        XCTAssertNil(mixedWithNumbers)
        
        let mixedWithNumbers2 = try? validator.validated("123arl12ind123")
        XCTAssertNil(mixedWithNumbers2)
        
        let validUsername = "arlind"
        let validatedUsername = try? validator.validated(validUsername)
        XCTAssertEqual(validUsername, validatedUsername)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
