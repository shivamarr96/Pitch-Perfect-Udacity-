//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Shivam Arora on 31/10/16.
//  Copyright © 2016 Shivam Arora. All rights reserved.
//

import UIKit
import  AVFoundation

class PlaySoundsViewController: UIViewController {
    var recordedAudioURL: URL!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var stopTimer:Timer!
    enum ButtonType: Int { case slow = 0,fast,chipmunk,vader,echo,reverb }
    
    override func viewDidLoad() {
        setupAudio();
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        print("Play Sound Button Pressed")
        switch(ButtonType(rawValue:sender.tag)!)
        {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 2.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(reverb:true)
        case .reverb:
            playSound(echo:true)
            
        }
        configureUI(.playing)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        print("Stop Audio Button Pressed")
        stopAudio()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
