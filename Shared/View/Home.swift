//
//  Home.swift
//  SwiftUI_FurnitureUIApp
//
//  Created by park kyung seok on 2022/07/10.
//

import SwiftUI

struct Home: View {
    
    @State var furnitures: [Furniture] = [
        Furniture(name: "Side Table", description: "Amazing stylish and widely selled table !!!", price: "$200", image: "sideTable"),
        Furniture(name: "Desktop Table", description: "Best IKEA Table at afforable price.", price: "$200", image: "desktopTable"),
        Furniture(name: "Table Clock", description: "Best selling table and widely selled table !!!", price: "$200", image: "clock")
    ]
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
           
            VStack(spacing: 18) {
                
                HStack {
                    Button(action: {}) {
                        Image(systemName: "sidebar.left")
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "slider.vertical.3")
                            .font(.title2)
                    }
                }
                .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Furniture in\nUnique Style")
                        .font(.largeTitle.bold())
                    
                    Text("We have wid range of furniture")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 20)
                
                // iOS15では、foreachから直接 bindingを渡すことができる
                ForEach($furnitures) { $furniture in
                    CardView(furniture: $furniture)
                }
               
            }
            .padding()
            .padding(.bottom, 50)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    
    @Binding var furniture: Furniture
    @GestureState var gestureOffset: CGFloat = 0
    @State var offsetX: CGFloat = 0
    @State var lastStoredOffset: CGFloat = 0
    
    var body: some View {
       
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(furniture.name)
                    .fontWeight(.bold)
                
                Text(furniture.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(furniture.price)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(furniture.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
        }
        .padding()
        .background(Color("Card").cornerRadius(15))
        .contentShape(Rectangle()) // Gestureを枠いっぱい使用するために、shapeで囲む
        
        .offset(x: offsetX)
        .gesture(
            
            DragGesture()
                .updating($gestureOffset, body: { value, out, _ in
                    
                    out = value.translation.width
                })
                .onEnded({ value in
                    //指を離した時に呼ばれる
                    
                    //　指を離したタイミングで Dragした距離
                    // Dragした方向は - つまり 左Drag
                    if value.translation.width < 0 && -value.translation.width > 100 {
                        offsetX = -100
                    } else {
                        offsetX = 0
                    }
                    
                    
                    //手を離した時の値を保持
                    lastStoredOffset = offsetX
                })
            
        )
        .animation(.easeInOut, value: offsetX == lastStoredOffset) // offset == 0 or offset == 100 どちらの場合にはanimationをかける
        .onChange(of: gestureOffset) { newValue in
            // Drag中にきめ細かく呼ばれる
  
            //  dragした分の値  +  指を離した時のdragした距離が 0より上の場合、つまり　右へ dragした場合には
            // セルを移動させないように 0 を設定
            if gestureOffset + lastStoredOffset > 0 {
                offsetX = 0
            } else {
                
                // dragした方向が左なので移動させる
                offsetX = (gestureOffset +  lastStoredOffset)

            }
            
            
            
        }
        // セルの背景に ボタンを配置
        .background(
            ZStack(alignment: .trailing) {
                Color("Brown")
                
                VStack(spacing: 35) {
                    
                    Button(action: {}) {
                        Image(systemName: "pencil.circle.fill")
                            .font(.title2)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "cart.fill")
                            .font(.title2)
                    }
                    
                }
                .padding(.trailing, 30)
                .foregroundColor(.white)
            }
            .cornerRadius(15)
        )
    }
}
