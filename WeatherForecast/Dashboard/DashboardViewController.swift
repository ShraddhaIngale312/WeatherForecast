//
//  DashboardViewController.swift
//  WeatherForecast
//
//  Created by Shraddha Ingale on 9/19/20.
//  Copyright © 2020 Shraddha Ingale. All rights reserved.
//


import UIKit
import CoreData
import MBProgressHUD
class DashboardViewController: BaseViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var weatherImgView: UIImageView!
    @IBOutlet weak var cloudsAllLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    @IBOutlet weak var humidityStaticTextLabel: UILabel!
    @IBOutlet weak var tempMaxStaticTextLabel: UILabel!
    @IBOutlet weak var tempMinStaticTextLabel: UILabel!
    @IBOutlet weak var windStaticTextLabel: UILabel!
    @IBOutlet weak var cloudStaticTextLabel: UILabel!

    @IBOutlet weak var decriptnLabel: UILabel!
    @IBOutlet weak var decriptnImgView: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tempMaxView: UIView!
    @IBOutlet weak var tempMinView: UIView!
    @IBOutlet weak var windSpeedView: UIView!
    @IBOutlet weak var humidityView: UIView!

    var viewArr = [UIView]()
    var viewModel = DashboardViewModel()

    enum SignupError: Error {
        case illigalCharactersFound
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetUp()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        _ = viewArr.map({$0.setBorderWidth(width: 0, borderColor: CommonMethods.sharedInstance.blackBorderColorWithlessAlpha(), corner: 20)})
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = viewArr.map({$0.dropShadowToTF(color: .darkGray, opacity: 0.5, radius: 15, cornerRadius: 20, scale: true)})
        self.noDataLabel.dropShadowToTF(color: .darkGray, opacity: 0.5, radius: 25, cornerRadius: 30, scale: true)
        noDataLabel.setCornerRadius(25)
    }

    func basicSetUp() {
        searchTextField.setCornerRadius(15)
        noDataLabel.setCornerRadius(25)
        decriptnLabel.isHidden = true
        decriptnImgView.isHidden = true
        noDataLabel.isHidden = false
        stackView.isHidden = true
        viewArr = [tempMaxView, tempMinView, windSpeedView, humidityView]
        _ = viewArr.map({$0.isHidden = true})
        tempMaxView.isHidden = true
        tempMinView.isHidden = true
        windSpeedView.isHidden = true
        humidityView.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func setUpUI() {
        if let object = self.viewModel.dbObject {
            noDataLabel.isHidden = true
            stackView.isHidden = false
             _ = viewArr.map({$0.isHidden = false})
            if let t1 = object.value(forKey: Constants.AttributesName.cloudsAll) as? Int16 {
                cloudsAllLabel.text = String(t1) + "%"
            } else {
                cloudsAllLabel.text = "-"
            }
            if let t1 = object.value(forKey: Constants.AttributesName.humidity) as? Int16 {
                humidityLabel.text = String(t1) + "%"
            } else {
                humidityLabel.text = "-"
            }
            if let t1 = object.value(forKey: Constants.AttributesName.description) as? String {
                decriptnLabel.text = t1
                decriptnLabel.isHidden = false
                decriptnImgView.isHidden = false
            } else {
                decriptnLabel.text = "-"
            }
            if let t1 = object.value(forKey: Constants.AttributesName.temp_max) as? Double {
                tempMaxLabel.text = String(t1.rounded()) + "°"
            } else {
                tempMaxLabel.text = "-"
            }
            if let t1 = object.value(forKey: Constants.AttributesName.temp_min) as? Double {
                tempMinLabel.text = String(t1.rounded()) + "°"
            } else {
                tempMinLabel.text = "-"
            }
            if let t1 = object.value(forKey: Constants.AttributesName.windSpeed) as? Double {
                windSpeedLabel.text = String(t1.rounded())
            } else {
                windSpeedLabel.text = "-"
            }
        }
    }

    /// Update profile BUTTON ACTION
    @IBAction func searchButtonClick(_ sender: UIButton) {
        guard let txt = searchTextField.text  else {
            return
        }
        let trimmedTxt = txt.trimmingCharacters(in: .whitespaces)
        if trimmedTxt != "" {
            searchTextField.text = trimmedTxt
            self.view.endEditing(true)
            if let object = getDBObj(cityName: trimmedTxt) {
                self.viewModel.dbObject = object
                setUpUI()
            } else {
                MBProgressHUD.showAdded(to: self.view, animated: true)
                viewModel.getWeatherDataAPICall(cityNAme: trimmedTxt) { [weak self] success in
                    if let weakSelf = self {
                        DispatchQueue.main.async {
                            MBProgressHUD.hide(for: weakSelf.view, animated: true)
                            if success ?? false {
                                weakSelf.viewModel.dbObject = weakSelf.getDBObj(cityName: trimmedTxt)
                                weakSelf.setUpUI()
                            } else {
                                let cancelAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                                    weakSelf.searchTextField.text = ""
                                    weakSelf.basicSetUp()
                                })
                                weakSelf.showAlert(with: "City not found", message: "Please enter correct city Name..", actions: [cancelAction])
                            }
                        }
                    }
                }
            }
        } else {
            searchTextField.text = ""
        }
    }

    func getDBObj(cityName: String) -> NSManagedObject? {
        if let object = viewModel.retrieveData(city: cityName) {
            return object
        }
        return nil
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func isLocationValid(_ loc: String) throws {
        // Check for illigal characters
        if (loc.rangeOfCharacter(from: viewModel.invalidCharacters) != nil) {
            throw SignupError.illigalCharactersFound
        }
    }
}

extension DashboardViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
}
