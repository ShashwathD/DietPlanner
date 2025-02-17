//
//  DietPlan.swift
//  Project
//
//  Created by Shashwath Dinesh on 2/15/25.
//


import CoreML
import SwiftUI

struct DietPlan: View {
    
    @State var preferred: String
    @State var age: String
    @State var weight: String
    @State var height: String
    @State var dietCulture: String
    @State var healthRestrictions: String
    @State var dietGoal: String
    
    @State private var avoidList: String = "Loading..."
    @State private var recommendList: String = "Loading..."
    @State private var dietPlan: String = "Generating your diet plan..."
    
    @State public var sectionColor: Color = Color.lightGreen

    var body: some View {
        VStack {
             Text("Diet Recommendations")
                 .font(.largeTitle)
                 .padding(10)
             
             VStack(alignment: .leading, spacing: 10) {
                 Text("🚫 Foods to Avoid:")
                     .font(.headline)
                     .foregroundColor(.red)
                 Text(avoidList)
                     .padding()
                     .background(Color.red.opacity(0.1))
                     .cornerRadius(10)
                 
                 Text("✅ Recommended Foods:")
                     .font(.headline)
                     .foregroundColor(.green)
                 Text(recommendList)
                     .padding()
                     .background(Color.green.opacity(0.1))
                     .cornerRadius(10)
             }
             .padding()
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("📋 Your Comprehensive Diet Plan")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text(dietPlan)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
            }
            .padding()
            
            Spacer()
             
             Spacer()
         }
         .onAppear {
             fetchRecommendations()
         }.navigationTitle("Your Diet Plan").background( Color.black).scrollContentBackground(.hidden).foregroundColor(.white)
    }
    
    func fetchRecommendations() {
        avoidance()
        recommendation()
    }
    
    func avoidance() {
        do {
            let config = MLModelConfiguration()
            let model = try DietAvoidance(configuration: config)
            
            let prediction = try model.prediction(Age_Range: age, Weight_Range: weight, Height_Range: height, Diet_Culture: dietCulture, Health_Restriction: healthRestrictions, Diet_Goal: dietGoal)
            
            avoidList = prediction.Avoid
            
        } catch {
            avoidList = "Error fetching avoidance data."
            print("Error making avoidance prediction: \(error)")
        }
    }
    
    func recommendation() {
        do {
            let config = MLModelConfiguration()
            let model = try DietRecommend(configuration: config)
            
            let prediction = try model.prediction(Age_Range: age, Weight_Range: weight, Height_Range: height, Diet_Culture: dietCulture, Health_Restriction: healthRestrictions, Diet_Goal: dietGoal)
            
            recommendList = prediction.Recommend
            
        } catch {
            recommendList = "Error fetching recommendation data."
            print("Error making recommendation prediction: \(error)")
        }
    }
    
    func generateDietPlan() {
        let prompt = """
        Based on the following information, generate a detailed diet plan:
        - Diet Goal: \(dietGoal)
        - Foods to Avoid: \(avoidList)
        - Recommended Foods: \(recommendList)

        Provide a structured meal plan for breakfast, lunch, dinner, and snacks that aligns with the given diet goal and dietary preferences.
        """
        
        fetchChatGPTResponse(prompt: prompt) { response in
            DispatchQueue.main.async {
                dietPlan = response
            }
        }
    }
    
    func fetchChatGPTResponse(prompt: String, completion: @escaping (String) -> Void) {
        let apiKey = "YOUR-API-KEY"
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
           
        let requestData: [String: Any] = [
            "model": "gpt-4",
            "messages": [["role": "user", "content": prompt]],
            "max_tokens": 250
        ]
           
        guard let jsonData = try? JSONSerialization.data(withJSONObject: requestData) else {
            completion("Error creating JSON request")
            return
        }
           
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
           
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching ChatGPT response: \(error)")
                completion("Error generating diet plan.")
                return
            }
               
            guard let data = data else {
                completion("No data received.")
                return
            }
               
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let choices = jsonResponse?["choices"] as? [[String: Any]],
                    let message = choices.first?["message"] as? [String: Any],
                    let content = message["content"] as? String {
                    completion(content)
                } else {
                    completion("Invalid response from AI.")
                }
            } catch {
                print("Error parsing JSON: \(error)")
                completion("Failed to process response.")
            }
        }.resume()
    }
}

//#Preview {
//    DietPlan()
//}
