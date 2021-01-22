//
//  ViewController.swift
//  AR Galaxy
//
//  Created by Thiago Martins on 19/01/21.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.session.run(configuration)
        
        self.sceneView.debugOptions = [.showFeaturePoints]
        // Do any additional setup after loading the view.
        
        createBox()
        
        addPlanets()
        
        
    }
    
    func addPlanets(){
        
        let sol = planet(geometry: SCNSphere(radius: 0.028), diffuse: UIImage(named: "Sun diffuse"), emission: nil, specular: nil, normal: nil, distance: 0)
        let sunRotation = CreateRotation(duration: 4)
        sol.runAction(sunRotation)
        
        self.sceneView.scene.rootNode.addChildNode(sol)

        
        let terra = planet(geometry: SCNSphere(radius: 0.02), diffuse: UIImage(named: "Earth diffuse"), emission: UIImage(named: "Earth emission"), specular: UIImage(named: "Earth normal"), normal: UIImage(named: "Earth specular"), distance: 0.1)
        
        let earthRotation = CreateRotation(duration: 7)
        terra.runAction(earthRotation)
        
        let earthParent = SCNNode()
        let earthParentRotation = CreateRotation(duration: 15)
        earthParent.runAction(earthParentRotation)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        
        
        
        earthParent.addChildNode(terra)
        
        
        let saturno = planet(geometry: SCNSphere(radius: 0.015), diffuse: UIImage(named: "Saturn difuse"), emission: nil, specular: nil, normal: nil, distance: 0.15)
        
        let saturnParent = SCNNode()
        let saturnParentRotation = CreateRotation(duration: 19)
        saturnParent.runAction(saturnParentRotation)
        
        self.sceneView.scene.rootNode.addChildNode(saturnParent)
        saturnParent.addChildNode(saturno)
        
        let arcoScene = SCNScene(named: "arcoDeSaturno.scnassets/arcoDeSaturno.scn")
        let arcoNode = arcoScene?.rootNode.childNode(withName: "arcoDeSaturno", recursively: false)
        arcoNode?.scale = SCNVector3(0.02, 0.02, 0.02)
        arcoNode?.position = SCNVector3(0,-0.01,0)
        saturno.addChildNode(arcoNode!)
        
        
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage?, emission: UIImage?, specular: UIImage?, normal: UIImage?, distance: Double) -> SCNNode{
        
        let planet = SCNNode()
        planet.geometry = geometry
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.position = SCNVector3(distance, 0, 0)
        
        return planet
    }
    
    func CreateRotation(duration: TimeInterval) -> SCNAction{
        
        let rotation = SCNAction.rotateBy(x: 0.0, y: .pi*2, z: 0.0, duration: 4)
        let rotateForever = SCNAction.repeatForever(rotation)
        return rotateForever
        
    }
    
    
    
    func createBox(){
        let fundo = createPlan(position: SCNVector3(0, 0, -0.25), rotation: SCNVector3(0, 0, 0), texture: UIImage(named: "galaxy1"))
        self.sceneView.scene.rootNode.addChildNode(fundo)

        let direita = createPlan(position: SCNVector3(0.25,0,0), rotation: SCNVector3(0.0, .pi/2, 0.0), texture: UIImage(named: "galaxy2"))
        
        self.sceneView.scene.rootNode.addChildNode(direita)
        
        let esquerda = createPlan(position: SCNVector3(-0.25,0,0), rotation: SCNVector3(0.0, .pi/2, 0.0), texture: UIImage(named: "galaxy3"))
        
        self.sceneView.scene.rootNode.addChildNode(esquerda)
        
        let base = createPlan(position: SCNVector3(0,-0.25,0), rotation: SCNVector3(.pi/2, 0.0, 0.0), texture: UIImage(named: "galaxy4"))
        
        self.sceneView.scene.rootNode.addChildNode(base)
    }

    func createPlan(position: SCNVector3, rotation: SCNVector3, texture: UIImage!) -> SCNNode{
        
        let plane = SCNNode(geometry: SCNPlane(width: 0.5, height: 0.5))
        plane.position = position
        plane.geometry?.firstMaterial?.diffuse.contents = texture
        plane.eulerAngles = rotation
        plane.geometry?.firstMaterial?.isDoubleSided = true
        
        return plane
    }

}

