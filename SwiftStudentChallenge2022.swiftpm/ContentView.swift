import SwiftUI

struct ContentView: View {
  @State var page = "Home"
  
  var body: some View {
    VStack {
      if page == "Home" {
        HomeView(page: $page)
      } else if page == "ARView" {
        GameView(page: $page)
      }
      else if page == "Instructions" {
        InstructionsView(page: $page)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
