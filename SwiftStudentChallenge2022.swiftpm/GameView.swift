//
//  GameView.swift
//  SwiftStudentChallenge2022
//
//  Created by Simon Schueller on 4/22/22.
//

import SwiftUI

// MARK: - NavigationIndicator
struct NavigationIndicator: UIViewControllerRepresentable {
  typealias UIViewControllerType = ARView
  
  func makeUIViewController(context: Context) -> ARView {
    return ARView()
  }
  
  func updateUIViewController(_ uiViewController:
                              NavigationIndicator.UIViewControllerType, context:
                              UIViewControllerRepresentableContext<NavigationIndicator>) { }
}

struct GameView: View {
  
  var body: some View {
    ZStack {
      Color.blue.ignoresSafeArea()
      NavigationIndicator()
        .ignoresSafeArea(.all, edges: .bottom)
    }
  }
}

struct GameView_Previews: PreviewProvider {
  static var previews: some View {
    GameView()
  }
}
