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
    private var hogeView = SCNNode()
    
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
        hogeView.removeFromParentNode()
        let baseView = customView(frame: view.bounds)
        guard let image = createImage(view: baseView) else { return }
        let node = WebNode(image: image, panelColor: UIColor.green, width: 0.5)
        
        let position = SCNVector3(x: 0, y: 0, z: -1) // ノードの位置は、左右：0m 上下：0m　奥に100cm
        if let camera = sceneView.pointOfView {
            node.position = camera.convertPosition(position, to: nil) // カメラ位置からの偏差で求めた位置
        }
        sceneView.scene.rootNode.addChildNode(node) // 生成したノードをシーンに追加する
        hogeView = node
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
}
