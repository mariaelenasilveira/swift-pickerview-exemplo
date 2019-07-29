//
//  ViewController.swift
//  PickerViewExemplo
//
//  Created by Mariaelena Nascimento Silveira on 26/07/19.
//  Copyright © 2019 Mariaelena Nascimento Silveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selecionePaisTextField: UITextField!
    @IBOutlet weak var selecioneEstadoTextField: UITextField!
    var textFieldPickerView: UITextField?
    
    let listaPaises = ["Brasil", "EUA", "Argentina", "Chile", "Portugal", "Canadá", "México", "Peru"]
    let listaEstados  = ["RN", "Pb", "Pe", "Ba", "RJ", "RS", "BH"]
    var listaPickerView: [String] = []
    var nome: String = ""
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configurarPickerView()
    }
    
    private func configurarPickerView(){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let okButton = UIBarButtonItem(title: "Ok", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.okClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelarButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.cancelarClick))
        
        toolBar.setItems([cancelarButton, spaceButton, okButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        selecionePaisTextField.inputView = pickerView
        selecionePaisTextField.inputAccessoryView = toolBar
        
        selecioneEstadoTextField.inputView = pickerView
        selecioneEstadoTextField.inputAccessoryView = toolBar
    }
    
}


extension ViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldPickerView = textField
        switch textField {
        case selecioneEstadoTextField:
            nome = listaEstados.first!
            listaPickerView = listaEstados
        default:
            nome = listaPaises.first!
            listaPickerView = listaPaises
        }
    }
    
    @objc func okClick() {
        if let textFieldPickerView = textFieldPickerView {
            textFieldPickerView.text = nome
            textFieldPickerView.resignFirstResponder()
            self.textFieldPickerView = nil
        }
    }
    
    @objc func cancelarClick() {
        if let textFieldPickerView = textFieldPickerView {
            textFieldPickerView.text = nil
            textFieldPickerView.resignFirstResponder()
            self.textFieldPickerView = nil
        }
    }
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listaPickerView.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listaPickerView[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nome = listaPickerView[row]
    }
    
    
}

