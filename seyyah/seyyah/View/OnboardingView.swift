//
//  OnboardingView.swift
//  seyyah
//
//  Created by semihkesgin on 31.08.2024.
//  Thanks for this open-source onboarding screen juanjovn/craion-onboarding.
//

import SwiftUI
import Lottie
import AuthenticationServices


enum Step {
    case start
    case appear
    case down
    case text
    case cloud
    case name
    case country
    case finish
}
    
struct OnboardingView: View {
    @FocusState private var isTextFieldFocused: Bool
    
    let backgroundColor: Color = .background
    let accentColor: Color = .backgroundText
    
    @State var step: Step = .start
    @State var arrowOffset: CGFloat = -3
    @State var cardRotation: CGFloat = 15
    @State var logoOpacity: CGFloat = 0
    @State var buttonOpacity: CGFloat = 0
    @State var cardsDownOpacity: CGFloat = 0
    @State var cloudOpacity: CGFloat = 0
    @State var navigate = false
    @State var user: User = User(id: UUID().uuidString, name: "", date: Date().subtractingYears(4))
    @State private var selectedCountryFlag: String = UserDefaults.standard.string(forKey: "selectedCountry") ?? "🇺🇸"
        @State private var isShowingSheet = false
    
    var cardsOpacity: CGFloat {
        switch step {
        case .start:
            0
        default:
            1
        }
    }
    
    var cardYOffset: CGFloat {
        if step == .text {
            if UIScreen.isSE {
                UIScreen.height / 1.9
            } else {
                UIScreen.height / 1.7
            }
            
        } else {
            0
        }
    }
    
    var cardXOffset: CGFloat {
        if step == .text {
            cardsXOffset
        } else {
            0
        }
    }
    
    var demoCardRotation: CGFloat {
        if step == .text {
            cardRotation
        } else {
            360
        }
    }
    
    var finishRotation: CGFloat {
        if step == .finish {
            30
        } else {
            0
        }
    }
    
    var cardsYOffset: CGFloat {
        switch step {
        case .start:
            100
        case .appear:
            15
        case .down:
            UIScreen.height / 1.5
        case .text:
            UIScreen.height / 1.5
        case .cloud:
            200
        case .name:
            0
        case .country:
            0
        case .finish:
            0
        }
    }
    
    var cardsDownYOffset: CGFloat {
        switch step {
        case .start:
            0
        case .appear:
            0
        case .down:
            UIScreen.height / 3
        case .text:
            UIScreen.height / 3
        case .cloud:
            50
        case .name:
            0
        case .country:
            0
        case .finish:
            0
        }
    }
    
    var cardsCloudOffset: CGFloat {
        if step == .cloud {
            cardsYOffset - 50
        } else {
            0
        }
    }
    
    var cardsUserDataOffset: CGFloat {
        if step == .country || step == .name {
            150
        } else {
            0
        }
    }
    
    var cardsXOffset: CGFloat {
        switch step {
        case .start:
            500
        default:
            110
        }
    }
    
    var cardsRotation: CGFloat {
        switch step {
        case .start:
            15
        case .appear:
            -15
        case .down:
            15
        case .text:
            15
        case .cloud:
            -15
        case .name:
            -15
        case .country:
            15
        case .finish:
            345
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    @State private var userID: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                if step == .finish {
                    VStack {
                        Text("Welcome")
                            .font(.system(.title, design: .rounded, weight: .medium))
                        Text("\(user.name)")
                            .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    }
                    .multilineTextAlignment(.center)
                }
                
                if step == .text {
                    VStack {
                        Spacer()
                        ScrollView {
                            VStack {
                                Text(exampleString)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .frame(maxHeight: UIScreen.height / 5)
                        .padding()
                        .background(Color.white.opacity(0))
                        .cornerRadius(10)
                    }
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal)
                    .padding(.vertical, UIScreen.height / 8)
                }
                
                if step == .down {
                    VStack(spacing: 20) {
                        Image("Logo-Text")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 180)
                        
                        Text("Your Digital Passport")
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .multilineTextAlignment(.center)
                        
                        VStack {
                            Text("For travelers like you, every journey is a story waiting to be stamped. Capture your adventures and create memories that last with every destination you visit.")
                                .font(.system(.title3, design: .rounded, weight: .light))
                                .multilineTextAlignment(.center)
                            // Animasyon daha elegant modern bir tasarıma dönüşebilir.
                            VStack {
                                LottieView(animationFileName: "animation1.json", loopMode: .playOnce)
                                    .frame(width: 200, height: 200)
                                    .scaleEffect(0.2)
                            }
                        }
                        .opacity(cardsDownOpacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                withAnimation(.easeInOut(duration: 1.5)) {
                                    cardsDownOpacity = 1
                                }
                            }
                        }
                    }
                    .transition(.opacity)
                    .transition(.push(from: .top))
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(2)
                    .padding(.top, UIScreen.height / 10)
                }
                
                if step == .text {
                    VStack() {
                        Text("Places You've Discovered")
                            .font(.system(.title, design: .rounded, weight: .bold))
                            .multilineTextAlignment(.center)
                        
                        Text("It will be saved in your digital passport.")
                            .font(.system(.title3, design: .rounded, weight: .regular))
                            .multilineTextAlignment(.center)
                    }
                    .transition(.opacity)
                    .transition(.push(from: .top))
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(8)
                }
                
                VStack {
                    ZStack {
                        VStack {
                            CardView(imageName: "Istanbul", title: "Istanbul", accentColor: accentColor)
                                .rotationEffect(Angle(degrees: -cardsRotation + cardRotation))
                                .offset(x: cardsXOffset - cardXOffset, y: cardsYOffset - cardYOffset - cardsCloudOffset)
                                .scaleEffect(step == .text && !UIScreen.isSE ? 1.3 : 1)
                                .scaleEffect(step == .cloud || step == .name || step == .country ? 1.2 : 1)
                        }
                        
                        CardView(imageName: "Barcelona", title: "Barcelona", accentColor: accentColor)
                            .rotationEffect(Angle(degrees: cardsRotation))
                            .offset(x: -cardsXOffset, y: -cardsYOffset + (cardsDownYOffset * 4))
                            .scaleEffect(step == .cloud || step == .name || step == .country ? 1.2 : 1)
                    }
                    .opacity(cardsOpacity)
                    .offset(y: -cardsUserDataOffset)
                    
                    if step == .name {
                        VStack(spacing: 0) {
                            Text("How should we call you?")
                                .font(.system(.title, design: .rounded, weight: .medium))
                            
                            VStack(spacing: 4) {
                                TextField(text: $user.name, prompt: Text("User's name"), label: {
                                    
                                })
                                .focused($isTextFieldFocused)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .submitLabel(.done)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(accentColor)
                                .font(.system(.largeTitle, design: .rounded, weight: .bold))
                                .tint(accentColor)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Button("OK") {
                                            isTextFieldFocused = false
                                        }
                                        .font(.system(.body, design: .rounded, weight: .semibold))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
                                
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: 1)
                                    .padding(.horizontal, 64)
                                    .opacity(0.5)
                            }
                            .padding(.top)
                        }
                        .offset(y: 20)
                        .transition(.opacity)
                    }
                    
                    if step == .country {
                        VStack(spacing: 20) {
                                    Text("Where are you from?")
                                        .font(.system(.largeTitle, design: .rounded).bold())
                                    
                                    Text("Click on the flag and choose your country")
                                        .tint(.pink)
                                        .foregroundStyle(.backgroundText)
                                    
                                    Button(action: {
                                        isShowingSheet.toggle()
                                    }) {
                                        Text(selectedCountryFlag)  // Seçilen bayrak buraya gelecek
                                            .font(.system(size: 50))
                                            .foregroundColor(.backgroundText)
                                            .padding()
                                            .cornerRadius(10)
                                    }
                            
                                }
                                .padding()
                                .fullScreenCover(isPresented: $isShowingSheet) {
                                    CountrySelectionView(selectedCountryFlag: $selectedCountryFlag)
                                
                                }
                        
                                .onAppear {
                                    loadSavedCountry()
                                }
                           }
                    
                    VStack(spacing: 0) {
                        Text("Welcome to ")
                            .font(.system(.title, design: .rounded, weight: .medium))
                        
                        Image("Logo-Text")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 180)
                    }
                    .opacity(logoOpacity)
                    .onAppear {
                        DispatchQueue.main.async {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                logoOpacity = 1
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            
                            withAnimation(.easeInOut(duration: 1)) {
                                buttonOpacity = 1
                            }
                            
                            withAnimation(.snappy(duration: 0.8), {
                                step = .appear
                            })
                        }
                    }
                    
                    if step == .cloud {
                        VStack {
                            Image(systemName: "icloud")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 42)
                                .foregroundStyle(accentColor)
                                .fontWeight(.regular)
                            Text("Everything is Digital")
                                .font(.system(.title, design: .rounded, weight: .medium))
                            Text("of course your trip is real")
                                .font(.system(.title3, design: .rounded, weight: .regular))
                                .lineLimit(3)
                                .multilineTextAlignment(.center)
                                .opacity(cloudOpacity)
                        }
                        .offset(y: -20)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                withAnimation(.snappy(duration: 1.5)) {
                                    cloudOpacity = 1
                                }
                            }
                        }
                    }
                    
                    ZStack {
                        CardView(imageName: "Paris", title: "Paris", accentColor: accentColor)
                            .rotationEffect(Angle(degrees: -cardsRotation - finishRotation))
                            .offset(x: cardsXOffset, y: cardsYOffset - cardsDownYOffset - (cardsCloudOffset * 0.9))
                            .scaleEffect(step == .cloud || step == .name || step == .country ? 1.2 : 1)
                        
                        CardView(imageName: "Florence", title: "Florence", accentColor: accentColor)
                            .rotationEffect(Angle(degrees: cardsRotation + finishRotation))
                            .offset(x: -cardsXOffset, y: -cardsYOffset + (cardsDownYOffset * 3) + cardsCloudOffset)
                            .scaleEffect(step == .cloud || step == .name || step == .country ? 1.2 : 1)
                    }
                    .padding(.top, 40)
                    .offset(y: cardsUserDataOffset)
                }
                
                // Sayfanın alt kısmındaki butonlar için
                VStack {
                    Spacer() // İçeriği yukarıda tutar
                    
                    if step == .finish {
                        VStack(spacing: 20) {
                            Button(action: {
                                UserDefaults.standard.set(user.name, forKey: "userName")
                                UserDefaults.standard.set(true, forKey: "onboardingCompleted")
                                navigate = true
                            }) {
                                Text("Başla")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .font(.system(.body, design: .rounded, weight: .semibold))
                                    .cornerRadius(12)
                            }
                            
                            SignInWithAppleButton(
                                .signIn,
                                onRequest: configureAppleSignIn,
                                onCompletion: handleAppleSignInResult
                            )
                            .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                            .frame(height: 50)
                            .cornerRadius(12)
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .padding(.bottom, 30)
                    } else {
                        Button(action: {
                            withAnimation {
                                advanceStep()
                            }
                        }) {
                            Image(systemName: "arrow.right")
                                .font(.system(size: 24, weight: .semibold))
                                .frame(width: 60, height: 60)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                        .opacity(step == .name && user.name.isEmpty || isTextFieldFocused ? 0 : 1)
                        .padding(.bottom, 30)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundColor)
            .foregroundStyle(accentColor)
            .navigationDestination(isPresented: $navigate) {
                HomeView()
            }
        }
        .onAppear {
            setupInitialAnimations()
        }
    }
    
    func advanceStep() {
        var nextStep: Step
        
        switch step {
        case .start:
            nextStep = .appear
        case .appear:
            logoOpacity = 0
            nextStep = .down
        case .down:
            nextStep = .text
        case .text:
            nextStep = .cloud
        case .cloud:
            nextStep = .name
        case .name:
            nextStep = .country
        case .country:
            nextStep = .finish
        case .finish:
            nextStep = .finish
        }
        
        step = nextStep
    }
    func loadSavedCountry() {
            if let savedCountry = UserDefaults.standard.string(forKey: "selectedCountry") {
                selectedCountryFlag = savedCountry
            }
        }
    
    var exampleString = "Istanbul is a city where history and modernity coexist in harmony. At every corner, you can discover remnants of various civilizations. The mesmerizing architecture of the Hagia Sophia, the impressive grandeur of the Topkapı Palace, and the graceful lines of the Süleymaniye Mosque are all evidence of Istanbul's deep-rooted history."
    
    func configureAppleSignIn(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    func handleAppleSignInResult(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            switch auth.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email
                
                // Kullanıcı bilgilerini kaydet ve işle
                userID = userIdentifier
                if let name = fullName?.givenName {
                    user.name = name
                }
                
                // Kullanıcı bilgilerini kaydet
                UserDefaults.standard.set(userID, forKey: "appleUserID")
                UserDefaults.standard.set(user.name, forKey: "userName")
                UserDefaults.standard.set(true, forKey: "onboardingCompleted")
                
                // Ana sayfaya yönlendir
                navigate = true
                
            default:
                break
            }
        case .failure(let error):
            print("Apple Sign In Hatası: \(error.localizedDescription)")
        }
    }
    
    private func setupInitialAnimations() {
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.5)) {
                logoOpacity = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 1)) {
                buttonOpacity = 1
            }
            
            withAnimation(.snappy(duration: 0.8)) {
                step = .appear
            }
        }
    }
}


#Preview {
    OnboardingView()
}


struct LottieView: UIViewRepresentable {
    
    var animationFileName: String
    let loopMode: LottieLoopMode
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFill
        return animationView
    }
}


struct CardView: View {
    @State var imageName: String
    @State var title: String
    @State var accentColor: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundStyle(.card)
               // .opacity(0.7)
                .shadow(radius: 5)
            
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(.title3, design: .rounded, weight: .semibold))
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(8.0)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(8)
        }
        .frame(maxWidth: 220, maxHeight: 200)
        .foregroundStyle(accentColor)
    }
    
}

struct User: Codable {
    let id: String
    var name: String
    var date: Date
}

extension Date {
    func age() -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        return ageComponents.year ?? 0
    }
    
    func addingYears(_ years: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: years, to: self) ?? self
    }
    
    func subtractingYears(_ years: Int) -> Date {
        return addingYears(-years)
    }
}

extension UIScreen {
    static var width: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var isSE: Bool {
        width == 375 && height == 667
    }
}
