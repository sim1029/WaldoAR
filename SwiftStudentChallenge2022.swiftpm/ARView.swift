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

class ARView: UIViewController, ARSKViewDelegate {
  
  var arView: ARSKView {
    return self.view as! ARSKView
  }
  
  override func loadView() {
    self.view = ARSKView(frame: .zero)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    arView.delegate = self
    let scene = SKScene()
    arView.presentScene(scene)
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
  
}
