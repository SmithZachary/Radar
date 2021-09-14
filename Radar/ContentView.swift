//
//  ContentView.swift
//  Radar
//
//  Created by Zach Smith on 9/13/21.
//

import SwiftUI

struct Marker: Identifiable, Hashable {
    var id: Int
    var offet: CGFloat
    var degrees: Double
}

struct Radar: View {
    @State private var rotation: Double = 0
    @State private var opasity: Double = 1
    
    private var markers: [Marker] = []
    private var marker: [Marker] = []
    private var scannerTailColor: AngularGradient = AngularGradient(
        gradient: Gradient(colors: [Color.black]),
        center: .center
    )
    
    init() {
        self.markers = randomMarkersList()
        self.marker = randomMarkersList()
        self.scannerTailColor = AngularGradient(
            gradient: Gradient(colors: [color.opacity(0), color.opacity(1)]),
            center: .center
        )
    }
    
    var body: some View {
        VStack{
        Text("EP-3 ARIES")
            .font(.title)
            .bold()
            .underline()
           
       
                
            
        ZStack {
          
            offWhite.edgesIgnoringSafeArea(.all)
            Image("ep3")
                 .resizable()
                 .frame(width: 400, height: 300, alignment: .top)
                 .position(x: 200, y:150.0)
               
            Circle()
                .fill(offWhite)
                .frame(width: self.scannerSize, height: self.scannerSize)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
            // Markers
            ForEach(marker, id: \.self) { m in
                Circle()
                    .opacity(self.opasity)
                    .animation(
                        Animation
                            .linear(duration: self.scannerSpeed)
                            .repeatForever(autoreverses: false)
                            .delay((self.scannerSpeed / 360) * (90 + m.degrees))
                    )
                    .frame(width: self.markerSize, height: self.markerSize)
                    .foregroundColor(Color.green)
                    .offset(x: m.offet, y: 0)
                    .rotationEffect(.degrees(m.degrees))
                .blur(radius: 6)
            }
            ForEach(markers, id: \.self) { m in
                Circle()
                    .opacity(self.opasity)
                    .animation(
                        Animation
                            .linear(duration: self.scannerSpeed)
                            .repeatForever(autoreverses: false)
                            .delay((self.scannerSpeed / 360) * (90 + m.degrees))
                    )
                    .frame(width: self.markerSize, height: self.markerSize)
                    .foregroundColor(Color.red)
                    .offset(x: m.offet, y: 0)
                    .rotationEffect(.degrees(m.degrees))
                .blur(radius: 2)
            }
            // Scanner tail
            Circle()
                .trim(from: 0, to: 0.375)
                .stroke(lineWidth: self.scannerSize / 2)
                .fill(scannerTailColor)
                .frame(width: self.scannerSize / 2, height: self.scannerSize / 2)
                .rotationEffect(.degrees(135 + self.rotation))
            
            // Scanner line
            Rectangle()
                .frame(width: 4, height: (self.scannerSize / 2))
                .offset(x: 0, y: -self.scannerSize / 4)
                .rotationEffect(.degrees(self.rotation))
                .foregroundColor(self.color)
            
            // Scanner middle point
            Circle()
                .frame(width: self.middlePointSize, height: self.middlePointSize)
                .foregroundColor(self.color)
            Text("Lucky 12")
                .bold()
                .position(x: 200, y: 550)
                .font(.title2)
                .foregroundColor(.blue)
            Text("1960-20??")
                .bold()
                .position(x: 200, y: 590)
                .font(.title2)
                .foregroundColor(.red)
                
            
        }
           
        }
     
        .onAppear {
            self.opasity = 0
            withAnimation(Animation.linear(duration: self.scannerSpeed).repeatForever(autoreverses: false)) {
                self.rotation = 360
            }
        }
    }
    func randomGMarkersList() -> [Marker] {
        
        var marker = [Marker]()
        
        for i in 0..<self.markerGCount {
            let randomXOffset = CGFloat(Int.random(in: Int(markerSize)...Int((self.scannerSize / 2) - markerSize)))
            let randomDegree = Double(Int.random(in: 0...360))
            
            marker.append(Marker(id: i, offet: randomXOffset, degrees: randomDegree))
        }
        return marker
    }
    
    
    
    func randomMarkersList() -> [Marker] {
        
        var markers = [Marker]()
        
        for i in 0..<self.markerCount {
            let randomXOffset = CGFloat(Int.random(in: Int(markerSize)...Int((self.scannerSize / 2) - markerSize)))
            let randomDegree = Double(Int.random(in: 0...360))
            
            markers.append(Marker(id: i, offet: randomXOffset, degrees: randomDegree))
        }
        return markers
    }
    
    
    // MARK: - Drawing constants
    
    let degrees: Double = 90
    let middlePointSize: CGFloat = 15
    let scannerSize: CGFloat = 300
    let markerSize: CGFloat = 10
    let markerCount: Int = 7
    let markerGCount: Int = 4
    let scannerSpeed: Double = 3.0
    let color: Color = .green
    let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

struct Radar_Previews: PreviewProvider {
    static var previews: some View {
        Radar()
    }
}
