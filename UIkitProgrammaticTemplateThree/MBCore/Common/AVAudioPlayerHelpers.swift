//
//  AVAudioPlayerHelpers.swift
//  MB
//
//  Created by Damaris Muhia on 28/07/2023.
//


import AVFoundation

var player : AVAudioPlayer = AVAudioPlayer()

func playSound(resource:String,ext:String){

    let url = Bundle.main.url(forResource: resource, withExtension: ext)

    do{

        player = try AVAudioPlayer(contentsOf: url!)

        player.play()

    }catch{

        debugPrint("Error playing sound \(error.localizedDescription)")

    }

}
