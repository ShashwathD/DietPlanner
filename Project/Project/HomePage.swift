//
//  HomePage.swift
//  Project
//
//  Created by Shashwath Dinesh on 2/15/25.
//

import CoreML
import SwiftUI



struct HomePage: View {
    
    @State var preferred: String
    @State var age: String
    @State var weight: String
    @State var height: String
    @State var dietCulture: String
    @State var healthRestrictions: String
    @State var dietGoal: String
    
    @State public var sectionColor: Color = Color.lightGreen
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink (destination: Profile(preferred: preferred)) {
                        HStack {
                            Image(systemName: "person").resizable().frame(width: 50.0, height: 50.0)
                            Text(preferred).font(.system(size: 30)).padding(15)
                        }.padding(5)
                    }.listRowBackground(sectionColor)
                }
                
                NavigationLink(destination: DietPlan(preferred: preferred, age: age, weight: weight, height: height, dietCulture: dietCulture, healthRestrictions: healthRestrictions, dietGoal: dietGoal)) {
                    VStack {
                        Image(systemName: "leaf.fill").resizable().frame(width: 50, height: 50).foregroundColor(.white)
                                        
                        Text("Get Diet Plan").font(.headline).foregroundColor(.white)
                    }.frame(width: 200, height: 100).background(Color.lightGreen).cornerRadius(20).shadow(radius: 5)
                }.padding(.top, 10)
                
            }.background( Color.darkGreen)
                .scrollContentBackground(.hidden).navigationTitle("Diet App").navigationBarTitleTextColor(.white).foregroundColor(.white)
        }
    }
}

//#Preview {
//    HomePage(preferred: "preview", age: "0-12")
//}
