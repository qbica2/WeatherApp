//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Mehmet Kubilay Akdemir on 2.02.2023.
//

import UIKit

class CityListViewController: UIViewController {
    

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource  = self
        searchTextField.delegate = self
        tableView.register(UINib(nibName: "CurrentLocationTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrentLocationTableViewCell")
        tableView.register(UINib(nibName: "CityListTableViewCell", bundle: nil), forCellReuseIdentifier: "CityListTableViewCell")
        
        searchButton.isUserInteractionEnabled = true
        let searchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(searchCity))
        searchButton.addGestureRecognizer(searchGestureRecognizer)
    }
    
}

//MARK: - TableView

extension CityListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityListTableViewCell") as! CityListTableViewCell
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "CurrentLocationTableViewCell") as! CurrentLocationTableViewCell
        
        for x in [cell, cell2] {
            x.layer.borderWidth = 1
            x.layer.cornerRadius = 12
            x.clipsToBounds = true
        }
         
        cell.backgroundColor = UIColor.red
        cell.layer.borderColor = UIColor.black.cgColor
        
        
        if indexPath.row == 0 {
            return cell2
        } else {
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
}

//MARK: - UITextField

extension CityListViewController: UITextFieldDelegate {
    
    @objc func searchCity(){
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "type city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if searchTextField.text != nil {
            performSegue(withIdentifier: "toDetail", sender: nil)
        }
        
        searchTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.cityName = searchTextField.text!
        }
    }
    
    
    
}
