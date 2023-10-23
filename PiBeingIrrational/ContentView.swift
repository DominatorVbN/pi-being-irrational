//
//  ContentView.swift
//  PiBeingIrrational
//
//  Created by Amit Samant on 23/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var angle: Double = 0
    @State var rate: Double = .pi
    @State var pointSet: [CGPoint] = []
    @State var isAnimating = false
    @State var isSheetPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Path { path in
                        path.addLines(pointSet)
                    }
                    .stroke(style: .init(lineWidth: 0.5))
                    .foregroundColor(Color(uiColor: .label))
                    LineHandShape(angle: angle, rate: rate) { endPoint in
                        DispatchQueue.main.async {
                            pointSet.append(endPoint)
                        }
                    }
                    .stroke(style: .init(lineWidth: 2))
                    .onAppear {
                        animate()
                    }
                    .foregroundColor(Color(uiColor: .label))
                }
                Button {
                    if !isAnimating {
                        isAnimating = true
                        animate()
                    } else {
                        isAnimating = false
                    }
                } label: {
                    if isAnimating {
                        Text("Stop")
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Start")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(Color(uiColor: .label))
                .foregroundColor(Color(uiColor: .systemBackground))
                
                Link(destination: URL(string: "https://www.instagram.com/reel/CyrFBptrYC9/?igshid=MzRlODBiNWFlZA==")!, label: {
                    Text("Inspired by fascinating.fractals from instagram ↗")
                })
                .font(.caption)
                .tint(Color(uiColor: .label))
            }
            .padding()
            .navigationTitle("Pi Being Irrational")

        }
    }
    
    func animate() {
        guard isAnimating else {
            return
        }
        withAnimation(.linear(duration: 1)) {
            angle = angle + 360
        } completion: {
            animate()
        }
    }
}

#Preview {
    ContentView()
}

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.x)
        hasher.combine(self.y)
    }
}
