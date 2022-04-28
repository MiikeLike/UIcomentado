
//  Created by Mikel Valle on 26/04/2022.
//  Copyright © 2022 MiikeLike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var myButton: UIButton!//Botón de uso normal
    @IBOutlet weak var myPickerView: UIPickerView!//Ruleta de selección
    @IBOutlet weak var myPageControl: UIPageControl!//Número de paginas
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!//Botón que indica distintos elementos (uno,dos)
    @IBOutlet weak var mySlider: UISlider!//Barra que puede mover el usuario
    @IBOutlet weak var myStepper: UIStepper!// Botón de mas y menos
    @IBOutlet weak var mySwitch: UISwitch!//Como indica el nombre es el botón switch
    @IBOutlet weak var myProgressView: UIProgressView!//Esta acción marca la barra de progreso
    @IBOutlet weak var myActivityIndicatior: UIActivityIndicatorView!//Es la rueda de carga
    @IBOutlet weak var myStepperLabel: UILabel!//Son etiquetas sobre el Stepper
    @IBOutlet weak var mySwitchLabel: UILabel!//
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTextView: UITextView!
    
    // Variables
    
    private let myPickerViewValues = ["Uno", "Dos" , "Tres", "Cuatro", "Cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Buttons
        
        myButton.setTitle("Mi Botón", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        
        // Pickers
        
        myPickerView.backgroundColor = .gray
        myPickerView.dataSource = self
        myPickerView.delegate = self
        myPickerView.isHidden = true //Con este codigo dejamos por defecto apagado el pickerView++
        
        // PageControls
        
        myPageControl.numberOfPages = myPickerViewValues.count
        myPageControl.currentPageIndicatorTintColor = .blue
        myPageControl.pageIndicatorTintColor = .lightGray
        
        // SegmentedControls
        
        mySegmentedControl.removeAllSegments()
        for (index, value) in myPickerViewValues.enumerated() {
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        // Sliders
        
        mySlider.minimumTrackTintColor = .red
        mySlider.minimumValue = 1
        mySlider.maximumValue = Float(myPickerViewValues.count)
        mySlider.value = 1
        
        // Steppers
        
        myStepper.minimumValue = 1
        myStepper.maximumValue = Double(myPickerViewValues.count)
        
        // Switch
        
        //ESTAMOS ACCEDIENDO A SUS PROPIEDADES
        
        mySwitch.onTintColor = .blue //Le cambiamos el color
        mySwitch.isOn = false//Con este codigo le estamos diciendo que por defecto este apagado
        
        // Progress Indicators
        
        //ARRIBA LE HEMOS AÑADIDO LA ACCIÓN AL BOTÓN, CON ESTE CODIGO LE ESTAMOS AÑADIENDO FUNCIONES AL MISMO
        
        myProgressView.progress = 0//Le estamos indicando que el prograso es "0"
        
        myActivityIndicatior.color = .blue//Le estamos cambiando el color
        myActivityIndicatior.startAnimating()//Le añadimos la animación de girar
        myActivityIndicatior.hidesWhenStopped = true//Le añadimos la opción de dejar la animación cuando se muestra el pickerView
        
        // Labels
        
        myStepperLabel.textColor = .darkGray//Le estamos añadiendo color al Stepper
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 36)//Le estamos cambiando la fuente de texto
        myStepperLabel.text = "1"//Aquí estamos añadiendo que ponga 1
        
        mySwitchLabel.text = "Está apagado"//Le estamos añadiendo la etiqueta para avisar al usuario que el elementro esta apagado
        
        // TextFields
        
        myTextField.textColor = .brown
        myTextField.placeholder = "Escribe algo"
        myTextField.delegate = self
        
        // TextViews
        
        myTextView.textColor = .brown
        myTextView.delegate = self
    }
    
    // Actions
    
    @IBAction func myButtonAction(_ sender: Any) {
        
        if myButton.backgroundColor == .blue {
            myButton.backgroundColor = .green
        } else {
            myButton.backgroundColor = .blue
        }
        
        myTextView.resignFirstResponder()
    }
    
    @IBAction func myPageControlAction(_ sender: Any) {
        myPickerView.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues[myPageControl.currentPage]
        myButton.setTitle(myString, for: .normal)
        
        mySegmentedControl.selectedSegmentIndex = myPageControl.currentPage
    }
    
    @IBAction func mySegmentControlAction(_ sender: Any) {
        myPickerView.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = mySegmentedControl.selectedSegmentIndex
    }
    
    @IBAction func mySliderAction(_ sender: Any) {
        
        var progress: Float = 0//Como el progress solo entiende de valores 0 y 1 tenemos que añadir este codigo, modificando cada case para que el total sea 1
        
        switch mySlider.value {
        case 1..<2:
            mySegmentedControl.selectedSegmentIndex = 0
            progress = 0.2//Aqui le estamos indicando distinto valor al del segmento para que el progress no
        case 2..<3:
            mySegmentedControl.selectedSegmentIndex = 1
            progress = 0.4//Aqui le estamos indicando distinto valor al del segmento para que el progress no
        case 3..<4:
            mySegmentedControl.selectedSegmentIndex = 2
            progress = 0.6//Aqui le estamos indicando distinto valor al del segmento para que el progress no
        case 4..<5:
            mySegmentedControl.selectedSegmentIndex = 3
            progress = 0.8//Aqui le estamos indicando distinto valor al del segmento para que el progress no
        default:
            mySegmentedControl.selectedSegmentIndex = 4
            progress = 1//Aqui le estamos indicando distinto valor al del segmento para que el progress no
        }
        
        myProgressView.progress = progress//Le estamos modificando el progreso del ProgressView en función del Slider, estamos relacionando el valor del Slider con el de progreso.
    }
    
    //CON ESTA FUNCIÓN ESTAMOS AÑADIENDO QUE EL STEPPER FUNCIONE JUNTO CON EL
    
    @IBAction func myStepperAction(_ sender: Any) {
        
        let value = myStepper.value
        mySlider.value = Float(value)
        
        myStepperLabel.text = "\(value)"//Accedemo al Label del stepper y le estamos intepolando el valor, Importante añadirlo como "\(value)" para que muestre en pantalla el valor de value del stepper.
    }
    
    //LE ESTAMOS AÑADIENDO LA FUNCIÓN/ACCIÓN
    
    @IBAction func mySwitchAction(_ sender: Any) {
        
        if mySwitch.isOn { //Estamos accediendo acce
            myPickerView.isHidden = false //Con este codigo le decimos que si el switch este encendido no esta oculto (VISIBLE)
            myActivityIndicatior.stopAnimating()
            
            mySwitchLabel.text = "Está encendido"//Le añadimos que cuando este encendido muestre en la etiqueta el text
        } else {
            myPickerView.isHidden = true //Esta oculto,
            myActivityIndicatior.startAnimating()
            //Importante que para que este codigo funcione por defecto le tenemos que introducir en el codigo base del pickerview con myPickerView.isHidden = True(Introducido arriba)++
            mySwitchLabel.text = "Está apagado"//Con esto estamos introduciendo al codigo que si no esta encendido else esta apagado con lo cual la etiqueta se sincroniza para mostrar el text que le hayas configurado
        }
    }
    
}

// UIPickerViewDataSource, UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = row
        
        mySegmentedControl.selectedSegmentIndex = row
    }
    
}

// UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        myButton.setTitle(myTextField.text, for: .normal)
    }
    
}

// UITextViewDelegate
extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        myTextField.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        myTextField.isHidden = false
    }
    
}

