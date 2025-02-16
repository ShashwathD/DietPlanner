//
//  RestrictionsForm.swift
//  Project
//
//  Created by Shashwath Dinesh on 2/15/25.
//

import CoreML
import SwiftUI

struct RestrictionsForm: View {
    
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("preferred") private var preferred: String = ""
    @AppStorage("age") private var age: String = ""
    @AppStorage("weight") private var weight: String = ""
    @AppStorage("height") private var height: String = ""
    @AppStorage("dietCulture") private var dietCulture: String = ""
    @AppStorage("healthRestrictions") private var healthRestrictions: String = ""
    @AppStorage("dietGoal") private var dietGoal: String = ""
    
    let ageRanges = ["0-12", "13-18", "19-30", "31-50", "51-65", "65+"]
    let weightRanges = ["<100 lbs", "100-130 lbs", "130-150 lbs", "150-180 lbs", "180-210 lbs", "210+ lbs"]
    let heightRanges = ["<5'0\"", "5'0\" - 5'3\"", "5'4\" - 5'6\"", "5'7\" - 5'9\"", "5'10\" - 6'0\"", "6'1\"+"]
    let dietCultures = ["None", "Vegetarian", "Vegan", "Halal", "Kosher", "Gluten-Free", "Keto", "Other"]
    let healthRestrictionsList = ["None", "Lactose Intolerance", "Nut Allergy", "Celiac (Gluten-Free)", "Diabetes", "Other"]
    let dietGoals = ["General Health", "Weight Loss", "Maintain Fitness", "Weight/Muscle Gain"]
    
    @State public var sectionColor: Color = Color.lightGreen
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Info") {
                        TextField("First Name", text: $firstName)
                        TextField("Last Name", text: $lastName)
                        TextField("Preferred Name", text: $preferred)
                    }.listRowBackground(sectionColor)
                    Section("Demographic Information") {
                        Picker("Age Range", selection: $age) {
                            ForEach(ageRanges, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(MenuPickerStyle())
                                                
                        Picker("Weight Range", selection: $weight) {
                            ForEach(weightRanges, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(MenuPickerStyle())
                                                

                        Picker("Height Range", selection: $height) {
                            ForEach(heightRanges, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(MenuPickerStyle())
                                                
                    }.listRowBackground(sectionColor)
                    Section("Diet") {
                        Picker("Dietary Preferences and Cultural Restrictions", selection: $dietCulture) {
                            ForEach(dietCultures, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        
                        Picker("Health-Based Dietary Restrictions", selection: $healthRestrictions) {
                            ForEach(healthRestrictionsList, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        
                        Picker("What’s Your Diet Goal?", selection: $dietGoal) {
                            ForEach(dietGoals, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }.listRowBackground(sectionColor)
                }
                
                NavigationLink(destination: HomePage(preferred: preferred, age: age, weight: weight, height: height, dietCulture: dietCulture, healthRestrictions: healthRestrictions, dietGoal: dietGoal).navigationBarBackButtonHidden(true)) {
                    Text("Submit")
                }.padding(10).background(Color.green).cornerRadius(10)
            }.scrollContentBackground(.hidden)
            .background( Image("healthy-eating")
                .resizable() .scaledToFill()
                .edgesIgnoringSafeArea(.vertical)
                .blur(radius: 4)).navigationTitle("Onboarding Survey").navigationBarTitleTextColor(.white).foregroundColor(.white)
        }
        
    }
}

extension Color {
    static let lightGreen = Color(red: 105 / 255, green: 214 / 255, blue: 134 / 255)
    static let darkGreen = Color(red: 72 / 255, green: 144 / 255, blue: 57/255)
}

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}


#Preview {
    RestrictionsForm()
}
