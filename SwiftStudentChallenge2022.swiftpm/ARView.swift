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
  var targetEmoji = ""
  var targetEmojiX = 0
  var targetEmojiY = 0
  var emojiCodes = [Int]()
  
  private func setUpWorld() {
    guard let currentFrame = arView.session.currentFrame
    else { return }
    
    targetEmojiX = Int.random(in: 0..<5)
    targetEmojiY = Int.random(in: 0..<5)
    targetEmoji = getRandomEmoji()
    
    // Create grid of transformations in front of camera
    for i in 0..<5 {
      for j in 0..<5 {
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.5
        translation.columns.3.x = -0.2 + Float(j) * 0.1
        translation.columns.3.y = 0.2 - Float(i) * 0.1
        let transform = simd_mul(currentFrame.camera.transform, translation)
        
        var emojiName = "node"
        if i == targetEmojiX && j == targetEmojiY{
          emojiName = "target"
        }
        // Add the anchors to the session
        let anchor = ARAnchor(name: emojiName, transform: transform)
        arView.session.add(anchor: anchor)
      }
    }
    
    isWorldSetup = true
  }
  
  func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
    var randomEmoji = getRandomEmoji()
    if anchor.name! == "target" {
      print("Target Emoji: \(targetEmoji)")
      randomEmoji = targetEmoji
    }
    return SKLabelNode(text: randomEmoji)
  }
  
  func getRandomEmoji() -> String {
    var emoji = ""
    while emoji == targetEmoji || emoji == "" {
      var emojiCode = Int.random(in: 129292...129535)
      emoji = String(UnicodeScalar(emojiCode) ?? "-")
      while !isEmojiSupported(emoji: emoji) || !(emojiCodes.contains(emojiCode)) {
        emojiCode = Int.random(in: 129292...129535)
        emoji = String(UnicodeScalar(emojiCode) ?? "-")
      }
      emojiCodes.append(emojiCode)
    }
    return emoji
  }
  
  func isEmojiSupported(emoji: String) -> Bool {
    let uniChars = Array(emoji.utf16)
    let font = CTFontCreateWithName("AppleColorEmoji" as CFString, 0.0, nil)
    var glyphs: [CGGlyph] = [0, 0]
    return CTFontGetGlyphsForCharacters(font, uniChars, &glyphs, uniChars.count)
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
    configuration.worldAlignment = .gravityAndHeading
    arView.session.run(configuration)
    arView.delegate = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    arView.session.pause()
  }
  
  // MARK: - ARSKViewSessionDelegate
  func session(_ session: ARSession,
               didFailWithError error: Error) {
    print("Session Failed - probably due to lack of camera access")
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    print("Session interrupted")
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
    print("Session resumed")
    arView.session.run(session.configuration!,
                       options: [.resetTracking,
                                 .removeExistingAnchors])
  }
  
  func session(_ session: ARSession, cameraDidChangeTrackingState
               camera: ARCamera) {}
  
}
