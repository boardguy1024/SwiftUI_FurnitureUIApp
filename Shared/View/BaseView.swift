//
//  BaseView.swift
//  SwiftUI_FurnitureUIApp
//
//  Created by park kyung seok on 2022/07/04.
//

import SwiftUI

struct BaseView: View {
    
    @State var currentTab = "house.fill"
    
    @State var curveAxis: CGFloat = 0
//    init() {
//        UITabBar.appearance().isHidden = false
//    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // TabView
            TabView(selection: $currentTab) {

                Home()
                    .tag("house.fill")

                Text("Search")
                    .tag("magnifyingglass.fill")

                Text("Account")
                    .tag("person.fill")
            }
            .clipShape(
                
                CustomTabCurve(curveAxis: curveAxis)
            )
            .padding(.bottom, -90)
            
            //カスタムタブバー
            HStack(spacing: 0) {
                TabButtons()
            }
            .frame(height: 50)
            .padding(.horizontal, 35)
        }
        .background(Color("Brown"))
        .ignoresSafeArea(.container, edges: .top)
    }
    
    
    // タブボタンを生成する関数1
    @ViewBuilder
    func TabButtons() -> some View {
        
        ForEach(["house.fill","magnifyingglass","person.fill"], id: \.self) { imageStr in
            
            GeometryReader { proxy in
                
                Button(action: {
                    withAnimation {
                        currentTab = imageStr
                        
                        // Updating curve Axis
                        curveAxis = proxy.frame(in: .global).midX
                        
                    }
                }) {
                    
                    Image(systemName: imageStr)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 45, height: 45)
                        .background(
                            Circle()
                                .fill(Color("Brown"))
                        )
                        .offset(y: currentTab == imageStr ? -25 : 0)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .onAppear {
                    
                    if curveAxis == 0 && imageStr == "house.fill" {
                        curveAxis = proxy.frame(in: .global).midX
                    }
                }
                
            }
            .frame(height: 40)
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
