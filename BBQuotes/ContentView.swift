import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuoteView(show: "Breaking Bad")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            QuoteView(show: "Better Call Saul")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem{
                    Label("Better Call Seul", systemImage: "briefcase")
                    
                }
        }
    }
}

#Preview {
    ContentView()
        
}

