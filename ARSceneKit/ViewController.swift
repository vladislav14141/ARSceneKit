//
//  ViewController.swift
//  ARSceneKit
//
//  Created by Миронов Влад on 23/03/2019.
//  Copyright © 2019 Миронов Влад. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.debugOptions = [.showWorldOrigin, .showFeaturePoints]
        
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/house1.scn")!
        let node = SCNNode()
        sceneView.scene = scene
        
        for x in stride(from: Float(-3), through: 3, by: 0.5) {
            node.addChildNode(loadTree(x: x, y: 0, z: -4.5))
            node.addChildNode(loadTree(x: x, y: 0, z: -5.0))
            node.addChildNode(loadTree(x: x, y: 0, z: -5.5))
            
            guard x < Float(-0.5)  || x > Float(0.5) else {continue}
            node.addChildNode(loadTree(x: x, y: 0, z: 0))
            node.addChildNode(loadTree(x: x, y: 0, z: -0.5))
            node.addChildNode(loadTree(x: x, y: 0, z: -1.0))
            
        }
        
        for z in stride(from: Float(0), through: -5.5, by: -0.5) {
            node.addChildNode(loadTree(x: 3, y: 0, z: z))
            node.addChildNode(loadTree(x: 2.5, y: 0, z: z))

            node.addChildNode(loadTree(x: -3, y: 0, z: z))
            node.addChildNode(loadTree(x: -2.5, y: 0, z: z))

        }
       
      
        sceneView.scene.rootNode.addChildNode(node)
        
        // Set the scene to the view
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    func loadTree(x: Float = 0, y: Float = 0, z: Float = 0) -> SCNNode {
        let node = SCNNode()
        node.position = SCNVector3(x, y, z)
        node.scale = SCNVector3(0.25, 0.25, 0.25)
        
        let stall = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 2))
        stall.position.y = 1
        stall.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        node.addChildNode(stall)
        
        let crown = SCNNode(geometry: SCNSphere(radius: 0.5))
        crown.position.y = 2
        crown.geometry?.firstMaterial?.diffuse.contents = UIColor.green
        node.addChildNode(crown)
        
        return node
    }

}
