//
//  ContentView.swift
//  Memorize
//
//  Created by  Artem Mazheykin on 24.05.2022.
//

import SwiftUI

class House {
    var ownerDetails: (() -> Void)?

    func printDetails() {
        print("This is a great house.")
    }

    deinit {
        print("I'm being demolished!")
    }
}

class Owner {
    var houseDetails: (() -> Void)?

    func printDetails() {
        print("I own a house.")
    }

    deinit {
        print("I'm dying!")
    }
}

print("Creating a house and an owner")

do {
    let house = House()
    let owner = Owner()
    house.ownerDetails = owner.printDetails
    owner.houseDetails = {[weak house] in house?.printDetails()}
}

print("Done")

struct ContentView: View {
    
    
    
    var emojis = ["🚂", "🚀","🚁","🚜","🚗","🚕","🚙","🚌","🚎","🏎","🚚","🚓","🚑","🚒","🚐","🛻","🚛","🛵","🏍","🛺","🚔","🚍","🚘","🚖"]
    @State var emojiCount = 24
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(emojis[0..<emojiCount  ], id: \.self) { emoji in
                        CardView(content: emoji ).aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack{
                remove
                Spacer()
                add
            }.font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var remove: some View{
        Button {
            if emojiCount > 1{
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View{
        Button {
            if emojiCount < emojis.count{
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct CardView: View{
    var content: String
    @State var isFaceUp: Bool = true

    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape .fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
