//
//  WebNode.swift
//  ARSample
//
//  Created by 築山朋紀 on 2018/12/13.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import ARKit
import SceneKit
import WebKit

class WebNode: SCNNode {
    
    init(image:UIImage, width: CGFloat) {
        super.init()
        let panelNode = SCNNode(geometry: SCNBox(width: width, height: width * 0.5, length: 0, chamferRadius: 0))
        
        let material_front = SCNMaterial()
        material_front.diffuse.contents = image
        let material_other = SCNMaterial()
        material_other.diffuse.contents = UIColor.clear
        panelNode.geometry?.materials = [material_front, material_other, material_front, material_other, material_other, material_other]
        
        addChildNode(panelNode)
    }
    
    /// view to image
    func createImage(view:UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        view.isHidden = false // 画像を取得する間だけ表示
        view.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.isHidden = true // 再び非表示
        return image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class customView: UIView {
    
    let label = UILabel()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        label.text = "ともき"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.font = .boldSystemFont(ofSize: 125)
        label.frame = self.bounds
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
