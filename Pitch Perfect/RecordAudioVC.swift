//
//  RecordAudioVC.swift
//  Pitch Perfect
//
//  Created by Shivam Arora on 27/09/16.
//  Copyright © 2016 Shivam Arora. All rights reserved.
//

import UIKit
import AVFoundation



class RecordAudioVC: UIViewController,AVAudioRecorderDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        disableStop.isEnabled=false
    }
    var audioRecorder: AVAudioRecorder!

    @IBAction func recordAudio(_ sender: AnyObject) {
        statusRecord.text="Recording in progress"
        disableRecord.isEnabled=false
        disableStop.isEnabled=true
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "/recordedVoice.wav"
        let pathArray: [String] = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents : pathArray)
       // print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.delegate=self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
    @IBOutlet weak var statusRecord: UILabel!

    @IBAction func stopAudio(_ sender: AnyObject) {
        statusRecord.text="Tap To Record"
        disableStop.isEnabled=false
        disableRecord.isEnabled=true
        audioRecorder.stop()
        let audioSession=AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
       
        print("hello recording stopped");
        if(flag)
        {
            self.performSegue(withIdentifier: "closeRecordingResources", sender: audioRecorder.url)
        }
        else
        {
        print("saving of recording failed");
        }
    
    }
    
    @IBOutlet weak var disableRecord: UIButton!
    
    @IBOutlet weak var disableStop: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "closeRecordingResources") {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
}
class ViewController:UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

