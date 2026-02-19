import SwiftUI

struct ReadingView: View {
    @EnvironmentObject var appState: AppState
    let passage: Passage
    
    @State private var scrollProgress: Double = 0
    @State private var contentHeight: CGFloat = 0
    @State private var viewportHeight: CGFloat = 0
    
    private let readCompletionThreshold = 0.95
    var canTakeQuiz: Bool { appState.canTakeQuiz(for: passage) }
    
    var body: some View {
        VStack(spacing: 0) {
            // Nav bar
            HStack {
                Button {
                    appState.goHome()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                        .background(Color.white.opacity(0.08))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                Text("Reading")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(DS.label3)
                
                Spacer()
                
                Color.clear.frame(width: 36, height: 36)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.black.opacity(0.85))
            
            // Content
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(passage.category.rawValue)
                        .font(.system(size: 12, weight: .bold))
                        .textCase(.uppercase)
                        .tracking(1)
                        .foregroundStyle(passage.category.color)
                        .padding(.bottom, 12)
                    
                    Text(passage.title)
                        .font(.system(size: 28, weight: .bold))
                        .tracking(-0.8)
                        .lineSpacing(2)
                        .padding(.bottom, 8)
                    
                    Text(passage.subtitle)
                        .font(.system(size: 15))
                        .foregroundStyle(DS.label3)
                        .padding(.bottom, 4)
                    
                    Text("Source: \(passage.source)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(DS.label4)
                        .padding(.bottom, 24)
                    
                    // Passage text
                    Text(passage.content)
                        .font(.system(size: 16.5))
                        .lineSpacing(10)
                        .foregroundStyle(DS.label2)
                        .padding(.bottom, 36)
                    
                    // Progress section
                    VStack(spacing: 8) {
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(DS.surface3)
                                    .frame(height: 4)
                                
                                Capsule()
                                    .fill(DS.accent)
                                    .frame(width: geo.size.width * scrollProgress, height: 4)
                                    .animation(.easeOut(duration: 0.3), value: scrollProgress)
                            }
                        }
                        .frame(height: 4)
                        
                        HStack {
                            Text("Reading progress")
                            Spacer()
                            Text("\(Int(scrollProgress * 100))%")
                        }
                        .font(.system(size: 13))
                        .foregroundStyle(DS.label3)
                    }
                    .padding(18)
                    .background(DS.surface)
                    .clipShape(RoundedRectangle(cornerRadius: DS.cardRadius))
                    .padding(.bottom, 16)
                    
                    // Quiz CTA (only shows after reading is effectively finished)
                    if canTakeQuiz {
                        VStack(spacing: 10) {
                            Text("Nice. You finished reading.")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(DS.label3)

                            PrimaryButton(title: "Take Quiz", icon: "brain") {
                                appState.markPassageReadyForQuiz(passage.id)
                                appState.navigate(to: .quiz(passage))
                            }
                        }
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                        .padding(.bottom, 20)
                    } else {
                        HStack(spacing: 6) {
                            Image(systemName: "book.closed")
                                .font(.system(size: 12, weight: .semibold))
                            Text("Finish reading to unlock quiz")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        .foregroundStyle(DS.label4)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 20)
                    }
                    
                    if scrollProgress < 0.3 {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.down")
                                .font(.system(size: 11))
                            Text("Scroll to read")
                                .font(.system(size: 12))
                        }
                        .foregroundStyle(DS.label4)
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: ScrollOffsetKey.self, value: geo.frame(in: .named("scroll")).origin.y)
                            .onAppear {
                                contentHeight = geo.size.height
                            }
                            .onChange(of: geo.size.height) { _, h in
                                contentHeight = h
                            }
                    }
                )
            }
            .coordinateSpace(name: "scroll")
            .onPreferenceChange(ScrollOffsetKey.self) { offset in
                let scrollable = contentHeight - viewportHeight
                if scrollable > 0 {
                    withAnimation(.easeOut(duration: 0.2)) {
                        scrollProgress = min(1, max(0, Double(-offset) / scrollable))
                    }
                    if scrollProgress >= readCompletionThreshold {
                        appState.markPassageReadyForQuiz(passage.id)
                    }
                }
            }
            .background(
                GeometryReader { geo in
                    Color.clear.onAppear {
                        viewportHeight = geo.size.height
                    }
                }
            )
        }
        .background(DS.bg)
    }
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
