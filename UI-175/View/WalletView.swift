//
//  WalletView.swift
//  UI-174
//
//  Created by にゃんにゃん丸 on 2021/05/06.
//

import SwiftUI

struct WalletView: View {
    @State var selectedTab = "Incomings"
    @Namespace var animation
    
    @State var weeks : [Week] = []
    
    @State var currentday = Week(day: "", date: "", amountSpent: 0)
    
    @Environment(\.presentationMode) var present
    var body: some View {
        VStack{
            
            
            HStack{
                
                
                Button(action: {
                    
                    present.wrappedValue.dismiss()
                    
                }, label: {
                    Image(uiImage: #imageLiteral(resourceName: "m1"))
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                })
                
                Spacer(minLength: 0)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(uiImage: #imageLiteral(resourceName: "menu"))
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                })
                
            }
            .padding()
            
            Text("Staties")
                .font(.title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.leading)
                
            
            
            HStack{
                
                Text("Incomings")
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(
                        ZStack{
                            
                            
                            
                            if selectedTab == "Incomings"{
                                
                                Color.white
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    
                    )
                    .foregroundColor(selectedTab == "Incomings" ? .black : .white)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                            
                            
                            selectedTab = "Incomings"
                        }
                    }
                
                
                Text("OutComing")
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .background(
                        ZStack{
                            
                            
                            
                            if selectedTab == "OutComing"{
                                
                                Color.white
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    
                    )
                    .foregroundColor(selectedTab == "OutComing" ? .black : .white)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)){
                            
                            
                            selectedTab = "OutComing"
                        }
                    }
                
                
                
            }
            .padding(.vertical,7)
            .padding(.horizontal)
            .background(Color.black.opacity(0.25))
            .cornerRadius(22)
            .padding(.top,5)
            
            
            
            HStack(spacing:35){
                
                ZStack{
                    
                    Circle()
                        .stroke(Color.white,lineWidth: 22)
                    
                    let progress = currentday.amountSpent / 500
                    
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.yellow,style: StrokeStyle(lineWidth: 22, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: -90))
                    
                    
                    Image(systemName: "dollarsign.square")
                        .font(.system(size: 55, weight: .bold))
                        .foregroundColor(.black)
                    
                    
                    
                    
                    
                    
                }
                .frame(maxWidth: 180)
                VStack(alignment: .leading, spacing: 15, content: {
                    
                    
                    
                    
                    Text("Spent")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    let amount = String(format: "%.2f", currentday.amountSpent)
                    
                    
                    Text("$\(amount)")
                        .foregroundColor(.gray)
                    
                    Text("MAXIUM")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    
                    Text("$500")
                        .foregroundColor(.gray)
                    
                })
                .frame(maxWidth: .infinity,alignment: .leading)
                
                
            }
            .padding(.leading,30)
            
            ZStack{
                
                if getRect().height < 750{
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                       BottomSheet(weeks: $weeks, currentday: $currentday)
                        .padding([.horizontal,.top])
                        .padding(.bottom)
                    })
                    
                }
                else{
                    BottomSheet(weeks: $weeks, currentday: $currentday)
                    .padding([.horizontal,.top])
                }
                
            }
            
            
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            .background(Color.white.clipShape(CustomShape(radi: 35, corner: [.topLeft,.topRight])) .ignoresSafeArea(.all, edges: .bottom))
            
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("bg").ignoresSafeArea())
        .onAppear(perform: {
            getWeekDays()
        })
    }
    
    func getWeekDays(){
        
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: Date())
        
        guard let startData = week?.start else {return}
        
        for index in 0..<7{
            
            guard let date = calendar.date(byAdding: .day, value: index, to: startData) else {return}
            
            let formatter = DateFormatter()
            
            formatter.dateFormat = "EEE"
            
            var day = formatter.string(from: date)
            
            day.removeLast()
            
            
            formatter.dateFormat = "dd"
            
            let dateString = formatter.string(from: date)
            
           
            weeks.append(Week(day: day, date: dateString, amountSpent: index == 0 ? 60 : CGFloat(index) * 70))
            
            
        }
        self.currentday = weeks.first!
        
        
        
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}

struct CustomShape : Shape {
    var radi : CGFloat
    var corner : UIRectCorner
    func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radi, height: radi))
        
        return Path(path.cgPath)
    }
}

struct BottomSheet : View {
    @Binding var weeks : [Week]
    @Binding var currentday : Week
    var body: some View{
        
        VStack{
            
            Capsule()
                .fill(Color.gray)
                .frame(width: 100, height: 2)
            
            
            HStack(spacing:15){
                
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Your Burance")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Text("May 6 2020")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                })
                
                Spacer(minLength: 0)
                
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "square.and.arrow.up.fill")
                        .font(.title2)
                        .foregroundColor(.black)
                        .offset(y: -5)
                })
                
                
                
            }
            .padding(.top)
            
            HStack{
                
                Text("22.306.07")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                    
                
                Image(systemName: "arrow.up")
                .foregroundColor(.gray)
                
                
                Text("15%")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                
            }
            .padding(.top,8)
            
            HStack(spacing:15){
                
                
                ForEach(weeks){week in
                    
                    VStack(alignment: .leading, spacing: 5, content: {
                        
                        
                        Text(week.day)
                            .fontWeight(.bold)
                            .foregroundColor(currentday.id == week.id ? Color.white.opacity(0.8) : .black)
                        
                        Text(week.date)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(currentday.id == week.id ? .white : .black)
                        
                        
                    })
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow.opacity(currentday.id == week.id ? 1 : 0))
                    .clipShape(Capsule())
                    
                    .onTapGesture {
                        currentday = week
                    }
                    
                    
                    
                }
                
            }
            .padding(.top,20)
            
            
            NavigationLink(destination: RotationView().navigationBarHidden(true)) {
                
                
                Image(uiImage: #imageLiteral(resourceName: "right-arrow"))
                 .resizable()
                 .renderingMode(.template)
                 .frame(width: 35, height: 35)
                 .foregroundColor(.white)
                 .padding(.vertical,12)
                 .padding(.horizontal,50)
                 .background(Color.primary)
                 .clipShape(Capsule())
           
                
            }
            
           
             
        
            
        }
    }
}
