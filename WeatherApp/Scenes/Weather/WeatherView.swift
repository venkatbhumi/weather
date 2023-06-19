//
//  WeatherRow.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import SwiftUI
import Kingfisher

struct WeatherView: View {
    @Binding var weather: Weather
    @Binding var isShowing: Bool
    @State  var scale = 1.2
    @State  var showAnimation = false
    @State  var offset = CGRect.infinite.maxY
    @StateObject var viewModel: DailyWeatherView.ViewModel



    var valueDetector:Bool{
        weather.cityName != nil
    }


    var body: some View {
        VStack(spacing:30){
            LottieView(name:"weatherNew",loopMode: .loop)
                .scaleEffect(scale)
                .animation(.linear(duration:0.9), value: scale)
                .hidden(showAnimation)

            if valueDetector {
                createWeatherView(weather: weather, {

                    viewModel.showMoreTrigger = true

                }).frame(maxWidth:.infinity,alignment: .leading)
                    .padding()
                    .scaleEffect(scale)
                                .onAppear {
                                    showAnimation = true
                                    let baseAnimation = Animation.easeIn(duration:0.5)
                                    let repeated = baseAnimation.repeatCount(1)
                                    withAnimation(repeated) {
                                        scale = 1.0
                                    }
                                }
            }else{
                noResultView(value: weather.cod)
            }

        }

    }

    @ViewBuilder
    func noResultView<T>(value:T?) -> some View{
        if value != nil{
            Text("🔎 No Search Results.")
                .offset(y:offset)
                .font(.system(size: 20, weight: .light))
                .foregroundColor(.white)
                .onAppear{
                    showAnimation = false
                    scale = scale - 0.45
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {_ in
                        offset = CGRect.zero.minY - 50
                    }

                }
        }
    }



    @ViewBuilder
    func createWeatherView(weather: Weather,_ buttonTrigger:@escaping ()->()) -> some View{
        VStack(alignment: .leading,spacing:5) {
            HStack(){
                Text(weather.cityName?.capitalized ?? "")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30, weight: .bold))
                KFImage(weather.iconUrl)
                    .resizable()
                    .frame(width:50, height: 50)
            }
            Text("\((weather.date ?? 0).convertToFormat())")
                .foregroundColor(Color.white)
                .font(.system(size: 15, weight: .light))
                .padding(.bottom,20)

            Text(
                "Average Temperature: \(weather.avgTemparature)° C")
                .foregroundColor(Color.white)
                .font(.subheadline)
            
            Text("Pressure: \(weather.pressure ?? 0) hPa")
                .foregroundColor(Color.white)
                .font(.subheadline)
            
            Text("Humidity: \(weather.humidity ?? 0)%")
                .foregroundColor(Color.white)
                .font(.subheadline)
                .padding(.bottom,20)
            HStack(spacing: 30){
                VStack(alignment: .leading,spacing:5){
                    Text("\(weather.description?.uppercased() ?? "")")
                        .foregroundColor(Color.white)
                        .font(.title3)
                        .foregroundColor(Color.backgroundColor)
                    Text("Feels Like: \(weather.feelslike)° C")
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                    
                    Text("Visibility: \((weather.visibility)/1000) km")
                        .foregroundColor(Color.white)
                        .font(.subheadline)
                        .padding(.bottom,25)
                     
                    .foregroundColor(Color.blue)

                }
            }
            Spacer(minLength:200)
        }
    }

    func LoadMore(){

    }
}



