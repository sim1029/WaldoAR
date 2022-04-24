import SwiftUI

struct ContentView: View {
  @State var currImage: UIImage = "🙂".textToImage()!
  
  var body: some View {
    HomeView(currImage: $currImage)
      .navigationTitle("Home")
      .navigationBarTitleDisplayMode(.inline)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ContentView()
    }
    .tint(.white)
  }
}
