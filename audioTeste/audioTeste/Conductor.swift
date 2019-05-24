//
//  Condutor.swift
//  audioTeste
//
//  Created by Peter De Nardo on 11/02/19.
//  Copyright © 2019 Peter De Nardo. All rights reserved.
//

import Foundation
import AudioKit
import MusicTheory

enum name: String {
    case Do = "C"
    case Mi = "E"
    case Sol = "G"
}

class Conductor {
    private var sequencer = AKSequencer()
    private let oscillator = AKPWMOscillator()
    private var synthesizer = AKMIDISampler()
    private var cFlat = Note(name: "C", octave: -1)
    private var sequenceLength = AKDuration(beats: 3.0)
    private var cont = 0
    
    private var oscillator = AKF
    
    var currentTempo = 110.0 {
        didSet {
            sequencer.setTempo(currentTempo)
        }
    }
    
    var scale1 = [0, 4, 7, 9, 7, 4]
    var scale2 = [0, 4, 7, 11, 7, 4]
    
    init () {
        AudioKit.output = oscillator
//        var path = "sawPiano1"
//        do {
//            try synthesizer.loadEXS24(path)
//        } catch {
//            print("??")
//        }
        do {
            try AudioKit.start()
        } catch {
            print(1)
        }
        oscillator.start()
        
//        sequencer.enableLooping()
//        sequencer.tracks[0].setMIDIOutput(synthesizer.midiIn)
//        sequencer.setTempo(100)
//        generateSequence()
//        sequencer.play()
    }
    
    func setOscillator(frequency: Double, amplitude: Double) {
        oscillator.frequency = frequency
        oscillator.amplitude = amplitude
    }
    
    func generateSequence(_ stepSize: Float = 1 / 2) {
        
        var str : name = .Do
        
        self.cFlat = Note(name: str.rawValue,  octave: -1)
        
        let cFlatMajorScale = self.cFlat.scale("major")
        let array1 = cFlatMajorScale.values
        let a = array1.map {Int($0)}
        scale1 = [a[0], a[2], a[4], a[5], a[4], a[2]]
        
        let cFlatMinorScale = self.cFlat.scale("minor")
        let array2 = cFlatMinorScale.values
        let b = array2.map {Int($0)}
        scale2 = [b[0], b[2], b[4], b[5], b[4], a[2]]
        
        //Definindo o comprimento do beat da sequencia de acordo com o paramentro definido acima: 8s
        sequencer.setLength(sequenceLength)
        
        let numberOfSteps = Int(Float(sequenceLength.beats) / stepSize)
        print(numberOfSteps)
        
        
        for i in 0 ..< numberOfSteps {
            
            let step = Double(i) * stepSize
            let scale = scale1
           
            if cont == Int(UInt32(scale.count)) {
                cont = 0;
            }
            
            let noteToAdd = 60 + scale[cont]
            cont = cont + 1
            
            sequencer.tracks[0].add(noteNumber: MIDINoteNumber(noteToAdd),
                                                           velocity: 100,
                                                           position: AKDuration(beats: step),
                                                           duration: AKDuration(beats: 1))
            
        }
        sequencer.setLength(sequenceLength)
        sequencer.play()
    }
    
}

