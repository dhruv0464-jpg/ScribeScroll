import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    @State private var didRunStartupFallback = false
    
    var body: some View {
        ZStack {
            DS.bg.ignoresSafeArea()
            
            switch appState.currentScreen {
            case .splash:
                SplashView()
                    .transition(.opacity)
                
            case .onboarding:
                OnboardingView()
                    .transition(.move(edge: .trailing))
                
            case .paywall:
                PaywallView()
                    .transition(.move(edge: .trailing))
                
            case .main:
                MainTabView()
                    .transition(.opacity)
                
            case .reading(let passage):
                ReadingView(passage: passage)
                    .transition(.move(edge: .trailing))
                
            case .quiz(let passage):
                QuizView(passage: passage)
                    .transition(.move(edge: .trailing))
                
            case .results(let score, let total, let passage):
                ResultsView(score: score, total: total, passage: passage)
                    .transition(.opacity)
                
            case .blockedOverlay(let app):
                BlockedOverlayView(blockedApp: app)
                    .transition(.move(edge: .bottom))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: appState.currentScreen)
        .onAppear {
            // Failsafe: if splash doesn't advance for any reason, continue app flow.
            guard !didRunStartupFallback else { return }
            didRunStartupFallback = true

            if case .splash = appState.currentScreen {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
                    if case .splash = appState.currentScreen {
                        appState.splashDidFinish()
                    }
                }
            }
        }
    }
}
