//
//  ContentView.swift
//  WeatherWise
//
//  Created by Jakub Trznadel on 23/04/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            if let location = locationManager.location{
                if let weather = weather {
                    Text("Weather data fetched!")
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
            } else{
                if locationManager.isLoading{
                    LoadingView()
                } else{
                    WelcomeView().environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.756, saturation: 0.425, brightness: 1.0))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
