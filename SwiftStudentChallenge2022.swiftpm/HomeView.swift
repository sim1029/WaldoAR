//
//  HomeView.swift
//  SwiftStudentChallenge2022
//
//  Created by Simon Schueller on 4/22/22.
//

import SwiftUI

struct HomeView: View {
  @Binding var currImage: UIImage
  @State var currInstruction: Int = 0
  
  let imageTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    ZStack {
      Color.blue.ignoresSafeArea()
      VStack {
        HStack {
          Spacer()
          Image(systemName: "crown.fill")
            .imageScale(.large)
          Text("0")
            .font(.title)
            .fontWeight(.bold)
        }
        .padding()
        
        
        Text("Emoji Hunt")
          .font(.largeTitle)
          .fontWeight(.bold)
        
        Image(uiImage: currImage)
          .padding()
        
        Spacer()
        
        NavigationLink("New Game", destination: GameView())
        .font(.title2)
        .foregroundColor(.black)
        .frame(width: 300, height: 30)
        .padding()
        .background(.yellow)
        .cornerRadius(50)
        .padding()
        
        NavigationLink("View Instructions", destination: InstructionsView())
        .font(.title2)
        .foregroundColor(.black)
        .frame(width: 300, height: 30)
        .padding()
        .background(.yellow)
        .cornerRadius(50)
        .padding()
        
        Spacer()
      }
      .accentColor(.white)
      .foregroundColor(.white)
    }
    .onReceive(imageTimer) { _ in
      if let newImage = getRandomEmoticon() {
        currImage = newImage
      }
    }
  }
}

func getRandomEmoticon() -> UIImage? {
  var emoji = ""
  var emojiCode = Int.random(in: 0x1F600...0x1F64F)
  emoji = String(UnicodeScalar(emojiCode)!)
  while !isEmojiSupported(emoji: emoji) {
    emojiCode = Int.random(in: 0x1F600...0x1F64F)
    emoji = String(UnicodeScalar(emojiCode)!)
  }
  return emoji.textToImage()
}

func isEmojiSupported(emoji: String) -> Bool {
  let uniChars = Array(emoji.utf16)
  let font = CTFontCreateWithName("AppleColorEmoji" as CFString, 0.0, nil)
  var glyphs: [CGGlyph] = [0, 0]
  return CTFontGetGlyphsForCharacters(font, uniChars, &glyphs, uniChars.count)
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(currImage: .constant("😀".textToImage()!))
  }
}
