//
//  DailyWeatherView.swift
//  WeatherApp
//
//  Created by Anil on 2023
//

import SwiftUI
import Combine

struct DailyWeatherView: PatternView {
    @ObservedObject var viewModel: ViewModel
    var colors:[UIColor] = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]
    @State private var isRotating = 0.0

    
    init(viewModel: ViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]


    }
    
    var body: some View {
        GeometryReader { proxy in
            //NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors:[colors[0].color,colors[1].color]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                    ScrollView {
                        VStack{

                            SearchBar(text: $viewModel.citySearchText,
                                      placeHolder: "Search by City or Zipcode")
                            
                            LoadingView(isShowing: $viewModel.isLoading, text: .constant("")) {
                                WeatherView(weather: $viewModel.dailyWeather, isShowing: $viewModel.isLoading, viewModel: self.viewModel)
                            }
                            .frame(minWidth:proxy.size.width,minHeight:proxy.size.height*0.5)
                        }
                        
                        
                    }
                    
                }.navigationBarTitle("Weather", displayMode:.large)
           // }.navigationViewStyle(StackNavigationViewStyle())

        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherView(viewModel: .init(diContainer: .defaultValue))
    }
}
