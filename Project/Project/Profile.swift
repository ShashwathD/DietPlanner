//
//  Profile.swift
//  Project
//
//  Created by Shashwath Dinesh on 2/15/25.
//

import SwiftUI

struct Profile: View {
    
    @State var preferred: String
    @State public var sectionColor: Color = Color.lightGreen
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Image(systemName: "person").resizable().frame(width: 50.0, height: 50.0)
                    Text(preferred).font(.system(size: 30)).padding(15)
                }.listRowBackground(sectionColor).padding(5)
                NavigationLink (destination: RestrictionsForm().navigationBarBackButtonHidden(true)) {
                    Text("Edit Details").font(.system(size: 30)).padding(5).foregroundColor(.blue)
                }.listRowBackground(sectionColor)
            }
        }.background( Color.darkGreen).scrollContentBackground(.hidden).foregroundColor(.white).navigationTitle("Profile")
    }
}

#Preview {
    Profile(preferred: "preview")
}
