//
//  ColorViewController.swift
//  Notes
//
//  Created by Marian Stanciulica on 18/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import UIKit

protocol ColorViewControllerDelegate {
    
    func controller(_ controller: ColorViewController, didPick color: UIColor)
    
}

class ColorViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    // MARK: -
    
    var delegate: ColorViewControllerDelegate?
    
    // MARK: -
    
    var color: UIColor = .white
    
    // MARK: - VIew Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Choose Color"
        
        setupView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Notify Delegate
        delegate?.controller(self, didPick: colorView.backgroundColor ?? .white)
    }
    
    // MARK: - View Methods
    
    private func setupView() {
       setupSliders()
        setupColorView()
    }
    
    // MARK: -
    
    private func setupSliders() {
        // Helpers
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        // Extract Components
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // Configure Sliders
        redSlider.value = Float(r)
        greenSlider.value = Float(g)
        blueSlider.value = Float(b)
    }
    
    private func setupColorView() {
        updateColorView()
    }
    
    private func updateColorView() {
        // Create Color
        let color = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
        
        // Configure Color View
        colorView.backgroundColor = color
    }

    
    @IBAction func colorDidChange(_ sender: UISlider) {
        // Update View
        updateColorView()
    }
    
}








