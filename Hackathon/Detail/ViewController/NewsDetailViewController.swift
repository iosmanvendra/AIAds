//
//  NewsDetailViewController.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 18/11/24.
//

import UIKit
import AVFoundation

enum LanguageCode: String, CaseIterable {
    case English = "en"
    case Hindi = "hi"
    case Assamese = "as"
    case Bangla = "bn"
    case Gujurati = "gu"
    case Kannada = "kn"
    case Malayalam = "ml"
    case Manipuri = "mni"
    case Marathi = "mr"
    case Panjabi = "pa"

    
    // Custom initializer to create LanguageCode from a name (e.g., "Hindi")
    init?(name: String) {
        switch name {
        case "English":
            self = .English
        case "Hindi":
            self = .Hindi
        case "Assamese":
            self = .Assamese
        case "Bangla":
            self = .Bangla
        case "Gujurati":
            self = .Gujurati
        case "Kannada":
            self = .Kannada
        case "Malayalam":
            self = .Malayalam
        case "Manipuri":
            self = .Manipuri
        case "Marathi":
            self = .Marathi
        case "Panjabi":
            self = .Panjabi

        default:
            return nil
        }
    }
}

class NewsDetailViewController: UIViewController, ReadAloudDelegate {
    func didTapReadAloud(withLanguage language: LanguageCode, withSummary isOn: Bool, withMaleVoice: Bool) {
        isMaleVoice = withMaleVoice
        selectedLanguage = language
        
        var storyText = ""
        if let dataSource = dataSource {
            for item in dataSource {
                if item.type == .paragraph {
                    storyText.append(item.data.0 ?? "")
                    storyText.append(" ")
                }
            }
        }
                
        self.view.showActivityIndicator()

        viewModel?.convertLanguage(withSelectedLanguage: String(describing: language), withContent: storyText, withSummaryEnable: isOn, completion: { [weak self] data in
            if let data = data {
                self?.getAudioData(withData: data)
            } else {
                DispatchQueue.main.async {
                    self?.view.hideActivityIndicator()
                }
            }
        })
    }
    
    
    @IBOutlet weak var tableVIew: UITableView!
    var viewModel: NewsViewModel?
    var feedUrl: String?
    var dataSource: [NewsDetailDataModel]?
    var audioPlayer: AVAudioPlayer?
    var isMaleVoice: Bool = true
    var selectedLanguage: LanguageCode = .English
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.showActivityIndicator()
        self.registerTableViewCells()
        
        viewModel?.fetchDetailNewsItem(urlString: feedUrl, completion: { [weak self] result in
            
            DispatchQueue.main.async {
                self?.view.hideActivityIndicator()
            }
            switch result {
            case .success(let data):
                self?.dataSource = data
                DispatchQueue.main.async {
                    self?.tableVIew.reloadData()
                }
                                                
            case .failure(let failure):
                debugPrint("failed to fetch the detail page contents", failure)
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNavBarAppearance()
    }
    
    private func getAudioData(withData data: String?) {
        viewModel?.fetchTTS(withStoryText: data, withAudioLanguageCode: selectedLanguage.rawValue, withMaleVoice: isMaleVoice, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleParsedTTS(withResponse: data)
                
            case .failure(let failure):
                debugPrint("failed to fetch the detail page contents", failure)
            }
            
            DispatchQueue.main.async {
                self?.view.hideActivityIndicator()
            }
        })
    }
    
    func handleParsedTTS(withResponse ttsResponse: TTSResponse?) {
        
        guard let ttsResponse = ttsResponse, let base64String = ttsResponse.audio.first?.audioContent else {
            print("Audio content not found in the response")
            return
        }
        
        // Convert base64 to Data
        guard let audioData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            print("Failed to decode base64 audio content")
            return
        }
        
        // Save and play the audio
        saveAndPlayAudio(audioData: audioData, format: ttsResponse.config.audioFormat)
    }
    
    func saveAndPlayAudio(audioData: Data, format: String) {
        // Create a file URL in the app's document directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileURL = documentsDirectory?.appendingPathComponent("tts_audio.\(format)")

        do {
            // Save the audio data to the file
            try audioData.write(to: fileURL!)
            print("Audio file saved at: \(fileURL!.absoluteString)")

            // Play the audio
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL!)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("Audio is playing")
        } catch {
            print("Error handling audio file: \(error.localizedDescription)")
        }
    }
    
    func registerTableViewCells() {
        NewsDetailTopAdCell.registerNib(tableVIew)
        NewsDetailHeaderInfoCell.registerNib(tableVIew)
        NewsDetailImageCaptionCell.registerNib(tableVIew)
        NewsDetailParagraphCell.registerNib(tableVIew)
        NewsDetailRelatedProductAdCell.registerNib(tableVIew)
        NewsDetailCarouselTableCell.registerNib(tableVIew)
    }
}

extension NewsDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = dataSource?[indexPath.row]
        switch item?.type {
        case .topAd:
            let cell: NewsDetailTopAdCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(adUrl: item?.data.0) //TODO: need to pass adid here
            return cell
        case .header:
            let cell: NewsDetailHeaderInfoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(headLine: item?.data.0, postTime: item?.data.1)
            return cell
            
        case .imageWithCaption:
            let cell: NewsDetailImageCaptionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            cell.configure(imgStr: item?.data.0 ?? "", caption: item?.data.1)
            return cell
            
        case .paragraph:
            let cell: NewsDetailParagraphCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(para: item?.data.0)
            return cell
            
        case .customAd:
            let cell: NewsDetailRelatedProductAdCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            cell.configure(ad: item?.ads?.first)
            return cell
            
        case .adCarousel:
            let cell: NewsDetailCarouselTableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.delegate = self
            cell.configure(ads: item?.ads ?? [])
            return cell
            
        default: break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NewsDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension NewsDetailViewController: NewsDetailProductAdCellDelegate {
    func adTapped(ad: CustomAdModel?) {
        //TODO: action to be defined here:
    }
}
