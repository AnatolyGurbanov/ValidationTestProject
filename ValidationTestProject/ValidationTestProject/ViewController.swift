//
//  ValidationTestProject
//  Created by Anatoly Gurbanov on 15.02.2021.
//

import UIKit

class ValidationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    @IBOutlet weak var validationResultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        validationResultLabel.isHidden = true
    }

    @IBAction func validationTapped(_ sender: Any) {
        validate()
    }
    
    private func validate() {
        if let inputedText = textField.text, inputedText.contains("@") {
            validateEmail()
        } else {
            validateNickname()
        }
    }
    
    private func validateEmail() {
        do {
            let _ = try textField.validatedText(validationType: ValidatorType.email)
            showValidationSuccess()
        } catch(let error) {
            showValidationError(with: (error as! ValidationError).message)
        }
    }
    
    private func validateNickname() {
        do {
            let _ = try textField.validatedText(validationType: ValidatorType.username)
            showValidationSuccess()
        } catch(let error) {
            showValidationError(with: (error as! ValidationError).message)
        }
    }
    
    private func showValidationError(with error: String) {
        UIView.animate(withDuration: 1.0) {
            self.validationResultLabel.isHidden = false
            self.validationResultLabel.textColor = .systemRed
            self.validationResultLabel.text = error
        }
        
        hideValidationLabel()
    }
    
    private func showValidationSuccess() {
        UIView.animate(withDuration: 1.0) {
            self.validationResultLabel.isHidden = false
            self.validationResultLabel.textColor = .systemGreen
            self.validationResultLabel.text = "Валидация прошла успешно"
        }
        
        hideValidationLabel()
    }
    
    private func hideValidationLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 2.0) {
                self.validationResultLabel.text = ""
                self.validationResultLabel.isHidden = true
            }
        }
    }
}

