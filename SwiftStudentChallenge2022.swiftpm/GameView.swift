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
  @Binding var page: String
  
  var body: some View {
    ZStack {
      NavigationIndicator()
      VStack {
        Spacer()
        Spacer()
        Button("Home") {
          self.page = "Home"
        }.padding()
          .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color.white).opacity(0.7))
      }
    }
  }
}

struct GameView_Previews: PreviewProvider {
  @Binding var page: String
  static var previews: some View {
    GameView(page: .constant("ARView"))
  }
}
