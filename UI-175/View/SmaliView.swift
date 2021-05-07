//
//  SmaliView.swift
//  UI-175
//
//  Created by にゃんにゃん丸 on 2021/05/07.
//

import SwiftUI

struct SmaliView: View {
    @State var value : CGFloat = 0.5
    var body: some View {
        VStack{
            
            
            Text("SMILE")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
            
            
            
            Spacer()
            
            
            HStack(spacing:0){
                
                ForEach(1...2,id:\.self){_ in
                    
                    
                    ZStack{
                        
                        
                        EyeShape()
                            .stroke(Color.primary,lineWidth: 5)
                            .frame(height: 100)
                           
                        
                        
                        EyeShape(value: value)
                            .stroke(Color.primary,lineWidth: 5)
                            .frame(height: 100)
                            .rotationEffect(.init(degrees: 180))
                            .offset(y: -100)
                        
                        
                        Circle()
                            .fill(Color.primary)
                            .frame(width: 13, height: 13)
                            .offset(y: -30)
                        
                    }
                    .frame(height: 100)
                }
            }
            
            
            SmileShape(value: value)
                .stroke(Color.primary,lineWidth: 3)
                .frame(height: 100)
                .padding(.top,20)
        
            
            GeometryReader{proxy in
                
                let frame = proxy.frame(in:.global).width
                
                
                ZStack(alignment:.leading){
                    
                    Color.black
                        .frame(height:2)
                
                    Image(systemName: "arrow.right")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                        .background(Color.primary)
                        .cornerRadius(10)
                        .offset(x: value * (frame - 45))
                        .gesture(DragGesture().onChanged({ value in
                            let with = frame - 45
                            let drag = value.location.x - 30
                            
                            if drag > 0 && drag <= with{
                                
                                
                                self.value = drag / with
                            }
                            
                        }))
                }
                    
                
                
                
                
                
            }
            .padding()
            .frame(height: 45)
            
            Spacer()
            
            
            NavigationLink(
                destination: WalletView().navigationBarHidden(true),
                label: {
                    
                    Text("Button")
                        .font(.title)
                        .fontWeight(.heavy)
                        .frame(width: getRect().width / 2)
                        .padding(.vertical)
                        .foregroundColor(.white)
                        .background(Color.primary)
                        .cornerRadius(10)
                        
                    
                })
                
                
            
            
           
        }
       
        .background(
        
            (value <= 0.3 ? Color.red : (value > 0.3 && value <= 0.7) ? Color.blue : Color.purple)
        
                .ignoresSafeArea(.all, edges: .all)
                .animation(.easeInOut)
        )
       
        
    }
}

struct SmaliView_Previews: PreviewProvider {
    static var previews: some View {
        SmaliView()
    }
}

struct SmileShape : Shape {
    var value : CGFloat
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            let center = rect.width / 2
            
            let downRadius : CGFloat = (115*value) - 30
            
            
            path.move(to: CGPoint(x: center - 150, y: 0))
            
            let to1 = CGPoint(x: center, y: downRadius)
            let cont1 = CGPoint(x: center - 145, y: 0)
            let cont2 = CGPoint(x: center - 145, y: downRadius)
            
            
            let to2 = CGPoint(x: center + 150, y: 0)
            let cont3 = CGPoint(x: center + 145, y: downRadius)
            let cont4 = CGPoint(x: center + 145, y: 0)
            
            path.addCurve(to: to1, control1: cont1, control2: cont2)
            
            path.addCurve(to: to2, control1: cont3, control2: cont4)
            
            
            
            
        }
    }
}


struct EyeShape : Shape {
    var value : CGFloat?
    
    func path(in rect: CGRect) -> Path {
        return Path{path in
            
            let center = rect.width / 2
            
            let downRadius : CGFloat = 55*(value ?? 1)
            
            
            path.move(to: CGPoint(x: center - 40, y: 0))
            
            let to1 = CGPoint(x: center, y: downRadius)
            let cont1 = CGPoint(x: center - 40, y: 0)
            let cont2 = CGPoint(x: center - 40, y: downRadius)
            
            
            let to2 = CGPoint(x: center + 40, y: 0)
            let cont3 = CGPoint(x: center + 40, y: downRadius)
            let cont4 = CGPoint(x: center + 40, y: 0)
            
            path.addCurve(to: to1, control1: cont1, control2: cont2)
            
            path.addCurve(to: to2, control1: cont3, control2: cont4)
            
            
            
            
        }
    }
}
