//
//  ViewController.swift
//  ARSample
//
//  Created by 築山朋紀 on 2018/12/01.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.showsStatistics = true
        sceneView.scene = SCNScene()
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let node = SCNNode() // ノードを生成
        node.geometry = SCNBox(width: 0.2, height: 0.1, length: 0, chamferRadius: 0)
        let material = SCNMaterial() // マテリアル（表面）を生成する
        material.diffuse.contents = randomColor()
        node.geometry?.materials = [material] // 表面の情報をノードに適用
        
        let position = SCNVector3(x: 0, y: 0, z: -0.5) // ノードの位置は、左右：0m 上下：0m　奥に50cm
        if let camera = sceneView.pointOfView {
            node.position = camera.convertPosition(position, to: nil) // カメラ位置からの偏差で求めた位置
        }
        sceneView.scene.rootNode.addChildNode(node) // 生成したノードをシーンに追加する
    }
    
    // ランダムな色の生成
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random() % 10) * 0.1
        let green = CGFloat(arc4random() % 10) * 0.1
        let blue = CGFloat(arc4random() % 10) * 0.1
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
        
    }
}
