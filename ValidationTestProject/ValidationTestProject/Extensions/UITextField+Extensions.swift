//
//  ValidationTestProject
//  Created by Anatoly Gurbanov on 15.02.2021.
//

import UIKit

extension UITextField {
    
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text ?? "")
    }
}
