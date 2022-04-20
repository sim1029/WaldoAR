//
//  ARView.swift
//  SwiftStudentChallenge2022
//
//  Created by Simon Schueller on 4/19/22.
//

import SwiftUI
// MARK: - ARViewIndicator
struct ARViewIndicator: UIViewControllerRepresentable {
  typealias UIViewControllerType = ARView
  
  func makeUIViewController(context: Context) -> ARView {
    return ARView()
  }
  
  func updateUIViewController(_ uiViewController:
                              ARViewIndicator.UIViewControllerType, context:
                              UIViewControllerRepresentableContext<ARViewIndicator>) { }
}


import Foundation
import ARKit

class ARView: UIViewController, ARSKViewDelegate, SKSceneDelegate  {
  
  var arView: ARSKView {
    return self.view as! ARSKView
  }
  
  override func loadView() {
    self.view = ARSKView(frame: .zero)
  }
  
  var isWorldSetup = false
  
  private func setUpWorld() {
    guard let currentFrame = arView.session.currentFrame
    else { return }
    
    // Create a transform with a translation of 0.2 meters in front of the camera.
    var translation = matrix_identity_float4x4
    translation.columns.3.z = -0.2
    let transform = simd_mul(currentFrame.camera.transform, translation)
    
    // Add a new anchor to the session.
    let anchor = ARAnchor(transform: transform)
    arView.session.add(anchor: anchor)
    
    isWorldSetup = true
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    arView.delegate = self
    let scene = SKScene(size: view.bounds.size)
    scene.scaleMode = .resizeFill
    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    scene.delegate = self
    arView.presentScene(scene)
    arView.showsFPS = true
    arView.showsNodeCount = true
  }
  
  func update(_ currentTime: TimeInterval, for scene: SKScene) {
    if !isWorldSetup {
      setUpWorld()
    }
  }
  
  
  // MARK: - Functions for standard AR view handling
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let configuration = ARWorldTrackingConfiguration()
    arView.session.run(configuration)
    arView.delegate = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    arView.session.pause()
  }
  
  // MARK: - ARSKViewDelegate
  func sessionWasInterrupted(_ session: ARSession) {}
  
  func sessionInterruptionEnded(_ session: ARSession) {}
  
  func session(_ session: ARSession, didFailWithError error: Error)
  {}
  
  func session(_ session: ARSession, cameraDidChangeTrackingState
               camera: ARCamera) {}
  
  func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
    return SKLabelNode(text: "👾")
  }
  
}
