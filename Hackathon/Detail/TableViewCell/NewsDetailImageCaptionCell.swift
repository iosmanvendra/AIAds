//
//  NewsDetailImageCaptionCell.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 19/11/24.
//

import UIKit

protocol ReadAloudDelegate: AnyObject {
    func didTapReadAloud(withLanguage language: LanguageCode, withSummary isOn: Bool, withMaleVoice: Bool)
}

class NewsDetailImageCaptionCell: UITableViewCell {
    @IBOutlet weak var btn_language: UIButton!
    
    @IBOutlet weak var summarySwitch: UISwitch!
    @IBOutlet weak var voiceswitch: UISwitch!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    weak var delegate: ReadAloudDelegate?

    var pickerView: UIPickerView!
    let languageOptions: [LanguageCode] = [.English, .Hindi, .Assamese, .Bangla, .Gujurati, .Kannada, .Malayalam, .Manipuri, .Marathi, .Panjabi]
    
    // This is the selected value that will appear on the button
    var selectedLanguage: LanguageCode?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(imgStr: String, caption: String?) {
        self.newsImageView.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "placeholder"))
        captionLabel.text = caption
    }
    @IBAction func action_language(_ sender: Any) {
        // Create a picker view
        pickerView = UIPickerView()
        pickerView.frame = CGRect(x: 0, y: 150, width: self.contentView.frame.width, height: 300)
//        pickerView.delegate = self
//        pickerView.dataSource = self
        
        // Create an action sheet to display the picker view
        let alert = UIAlertController(title: "Select a Language", message: nil, preferredStyle: .actionSheet)
        
        // Add the picker view to the action sheet
        alert.view.addSubview(pickerView)
        
//        // Set up constraints to position the picker in the action sheet
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        pickerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 20).isActive = true
//        pickerView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor).isActive = true
//        pickerView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor).isActive = true
//        pickerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        for languageOption in languageOptions {
            let language = String(describing: languageOption)
            
            let optionAction = UIAlertAction(title: language, style: .default) { [weak self] action in
                // Use 'action.title' directly instead of 'optionAction.title'
                self?.selectedLanguage = LanguageCode(name: action.title ?? "English")
                self?.btn_language.setTitle(action.title ?? "English", for: .normal)
            }
            alert.addAction(optionAction)
        }
        
        // Add a Done button to the action sheet
        let doneAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
//            if let selectedLanguage = self?.selectedLanguage {
//                self?.btn_language.setTitle(selectedLanguage.rawValue.capitalized, for: .normal)
//            }
        }
        
        alert.addAction(doneAction)
        
        // Show the action sheet
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    @IBAction func action_voiceswitch(_ sender: Any) {
    }
    @IBAction func action_summarySwitch(_ sender: Any) {
    }
    @IBAction func action_readAloud(_ sender: Any) {
        delegate?.didTapReadAloud(withLanguage: selectedLanguage ?? .English, withSummary: summarySwitch.isOn, withMaleVoice: !voiceswitch.isOn)
    }
}

extension NewsDetailImageCaptionCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - UIPickerView DataSource & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1  // One column of options
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let language = LanguageCode.allCases[row]
        return String(describing: language) //language.rawValue.capitalized // Display the language name as the title
    }
    
    // Update the selected value when an option is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = languageOptions[row]
    }
}
