//
//  RotationView.swift
//  UI-175
//
//  Created by にゃんにゃん丸 on 2021/05/07.
//

import SwiftUI

struct RotationView: View {
    var body: some View {
        TabView{
            
            
            ForEach(datas){data in
                
                GeometryReader{proxy in
                    
                    let frame = proxy.frame(in:.global)
                    
                    ZStack{
                        
                        Color("bg")
                        
                        
                        Image(data.story)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal)
                        
                        
                        VStack(alignment: .leading, spacing: 15, content: {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                                Capsule()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(height: 2.5)
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: data.offset, height: 2.5)
                                
                                
                            })
                            
                            HStack(spacing:15){
                                
                                
                                Image(data.story)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                
                                
                                Text(data.name)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                
                                
                            }
                            
                            
                            Spacer()
                            
                            
                                
                        })
                        .padding(.all)
                           
                        
                    }
                    .frame(width: frame.width, height: frame.height)
                    .rotation3DEffect(
                        .init(degrees: getAngle(offset: frame.minX)),
                        axis: (x: 0.0, y: 1.0, z: 0.0),
                        anchor: frame.minX > 0 ? .leading : .trailing,
                     
                        perspective: 2.0
                    )
                
                
                    
                    
                }
              
                
                
            }
            
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color("bg").edgesIgnoringSafeArea(.all))
    }
    
    func getAngle(offset : CGFloat)->Double{
        
        
        let tempoffset = offset / (getRect().width)
        
        let rotation : CGFloat = 20
        
        
        return Double(tempoffset * rotation)
        
    }
}

struct RotationView_Previews: PreviewProvider {
    static var previews: some View {
        RotationView()
    }
}
struct data : Identifiable {
    var id = UUID().uuidString
    var story : String
    var name : String
    var time : String
    var offset : CGFloat
    var color : Color
}

var datas = [

    data(story: "p1", name: "What?", time: "1H", offset: 100, color: .blue),
    data(story: "p2", name: "2020", time: "2H", offset: 200, color: .red),
    data(story: "p3", name: "Tokyo", time: "3h", offset: 50, color: .purple),
    data(story: "p4", name: "Cool", time: "4h", offset: 250, color: .green),
    data(story: "p5", name: "にゃ〜", time: "5H", offset: 80, color: .orange),
    data(story: "p6", name: "にゃ〜", time: "5H", offset: 200, color: .orange),
    data(story: "p7", name: "にゃ〜", time: "5H", offset: 60, color: .orange),

]

extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
}

