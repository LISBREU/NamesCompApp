//
//  ViewController.swift
//  NamesCompApp
//
//  Created by Ilnur Shabanov on 07.02.2024.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var partnersNameTF: UITextField!
    @IBOutlet weak var yourNameTF: UITextField!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ResultViewController else {return}
        destinationVC.firstName = yourNameTF.text
        destinationVC.secondName = partnersNameTF.text
    }
    @IBAction func resultButtonTapped() {
        guard let firstName = yourNameTF.text, let secondName = partnersNameTF.text else {return}
        if firstName.isEmpty || secondName.isEmpty || containDigits(name: firstName) == true || containDigits(name: secondName) == true {
            showAlert(
                title: "Names are missing",
                message: "Please correctly enter both names 😊"
            )
            return
        }
        performSegue(withIdentifier: "goToResult", sender: nil)
    }
    
    @IBAction func unwindSegueToFirstVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "unwindSegue" else {return}
        
        yourNameTF.text = ""
        partnersNameTF.text = ""
    }
    
    func containDigits(name: String) -> Bool {
        for char in name {
            if char.isNumber {
                return true
            }
        }
        return false
    }
    
}

extension FirstViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension FirstViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == yourNameTF {
            partnersNameTF.becomeFirstResponder()
        } else {
            resultButtonTapped()
        }
        return true
    }
}

