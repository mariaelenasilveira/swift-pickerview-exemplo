//
//  ViewController.swift
//  PickerViewExemplo
//
//  Created by Mariaelena Nascimento Silveira on 26/07/19.
//  Copyright © 2019 Mariaelena Nascimento Silveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cidadePartidaTextField: UITextField!
    @IBOutlet weak var cidadeDestinoTextField: UITextField!
    
    @IBOutlet var mensagemRespostaLabel: UIView!
    @IBOutlet weak var okBotao: UIButton!
    
    @IBOutlet weak var dataPartidaTextField: UITextField!
    @IBOutlet weak var dataRetornoTextField: UITextField!
    
    
    var textFieldPickerView: UITextField?
    
    let listaCidadesPartida = ["Areia Branca", "Caicó", "Currais Novos", "Ceará Mirim", "Extremoz", "Florânia", "Galinhos", "Goianinha", "João Câmara", "Jandaíra", "Macau", "Mossoró", "Macaíba", "Natal", "Parnamirim", "São José de Mipibú"]
    let listaCidadesDestino = ["Alto do Rodrigues","Brejoes", "Caiçara", "Fortaleza", "Recife", "Joao Pessoa", "Salvador", "Olinda", "Terezina", "Sao Luis","Maceió"]
    var listaPickerView: [String] = []
    
    var cidadeSelecionada: String = ""
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        configurarPickerView()
    }
    
    // Nessa configuracao foi adicionado ao pickerview e ao datePicker a barra com opcoes ok e cancelar
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
        
        //PickerView
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        cidadePartidaTextField.inputView = pickerView
        cidadePartidaTextField.inputAccessoryView = toolBar
        cidadeDestinoTextField.inputView = pickerView
        cidadeDestinoTextField.inputAccessoryView = toolBar
        
        //DatePicker
        datePicker.datePickerMode = .date
        dataPartidaTextField.inputView = datePicker
        dataPartidaTextField.inputAccessoryView = toolBar
        dataRetornoTextField.inputView = datePicker
        dataRetornoTextField.inputAccessoryView = toolBar
    }
    
}


extension ViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldPickerView = textField
        
        // ao iniciar a edicao do textField, seleciona com qual lista vamos o popular
        switch textField {
        case cidadePartidaTextField:
            cidadeSelecionada = listaCidadesPartida.first!
            listaPickerView = listaCidadesPartida
        default:
            cidadeSelecionada = listaCidadesDestino.first!
            listaPickerView = listaCidadesDestino
        }
    }
    
    @objc func okClick() {
        guard let textFieldPickerView = textFieldPickerView else { return }
        if textFieldPickerView == dataPartidaTextField || textFieldPickerView == dataRetornoTextField {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            textFieldPickerView.text = formatter.string(from: datePicker.date)
        } else {
            textFieldPickerView.text = cidadeSelecionada
            textFieldPickerView.resignFirstResponder()
        }
        self.view.endEditing(true)
    }
    
    @objc func cancelarClick() {
        if let textFieldPickerView = textFieldPickerView {
            cidadeSelecionada = ""
            textFieldPickerView.text = nil
            textFieldPickerView.resignFirstResponder()
        }
        self.view.endEditing(true)
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
        cidadeSelecionada = listaPickerView[row]
    }
    
    
}

