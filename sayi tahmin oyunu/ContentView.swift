//
//  ContentView.swift
//  sayi tahmin oyunu
//
//  Created by Fatih Şükran on 24.03.2023.
//

import SwiftUI

struct ContentView: View {
    let maxHamle = 12
    @State var text:String = ""
    @State var randomNum = Int.random(in: 0...1000)
    @State var hamle = 12
    @State var sayi: Int = -1
    @State var state: GameState = .start
    
    var primaryColor = Color(red: 0.541, green: 0.169, blue: 0.886)
    var isGameEnd:Bool {
        state == .won || state == .lose
    }
    
    var buttonTitle: String {
        isGameEnd ? "Tekrar Oyna" : "Tahmin Et"
    }
    
    var message: String {
        switch state {
        case .start:
            return ""
        case .lose:
            return "Maalesef \(maxHamle) hamlede sayıyı tahmin edemediniz :("
        case .won:
            return "**Tebrikler, sayıyı doğru tahmin ettiniz!**"
        case .bigger:
            return "**Daha KÜÇÜK bir sayı giriniz.**"
        case .smaller:
            return "**Daha BÜYÜK bir sayı giriniz.**"
        }
    }
    
    func reset() {
        print("randomNum: \(randomNum)")
        randomNum = 11111
        print("randomNum: \(randomNum)")
        hamle = maxHamle
        state = .start
        text = ""
        sayi = -1
    }
    
    var body: some View {
        NavigationView{
            VStack() {
                Spacer()
                Text("Sayı Tahmin Oyunu")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                    .bold()
                    .padding(.top)
                    .padding(.bottom)
                if (state != .start) {
                    HStack {
                        Text("**Sayı:** \(sayi)")
                        Spacer()
                        Text("**Kalan Hamle:** \(hamle)")
                    }
                    .padding()
                }else {
                    VStack {
                        Text("Toplam Hamle Hakkın: **\(maxHamle)**")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.blue)
                        if (state == .start){
                            Text("0 ile 1000 arasında bir sayı tahmin etmeye çalış")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.blue)
                            
                        }
                        
                    }.padding(.bottom)
                }
                VStack {
                    TextField("Bir Sayı Giriniz", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(isGameEnd)
                        .onSubmit {
                            validate()
                        }.padding(.leading, 29).padding(.trailing, 21)
                    
                    if (state != .start) {
                        Text(.init(message))
                            .padding()
                            .foregroundColor(state == .won ? .green : .red)
                    }
                    
                    Button(buttonTitle) {
                        isGameEnd ? reset() : validate()
                    }
                    .padding(10)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top)
                }
                Spacer()
            }.padding(11)
        }
        
    }
    
    func validate() {
        if hamle == 0 {
            state = .lose
            return
        }
        
        guard let num = Int(text) else {
            return;
        }
        
        hamle-=1
        sayi = num
        
        if (num == randomNum) {
            state = .won
        } else if (num > randomNum) {
            state = .bigger
        } else {
            state = .smaller
        }
    }
    
}

enum GameState {
    case won, lose, start, bigger, smaller
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
