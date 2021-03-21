//
//  AppDelegate.swift
//  Polligraph
//
//  Created by Roy Park on 3/1/21.
//

import UIKit
import Firebase
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        if !AuthManager.shared.isSignedIn() || !AuthManager.shared.isVerified() {
            let navVC = UINavigationController(rootViewController: OnboardingViewController())
            navVC.navigationBar.prefersLargeTitles = true
            navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            
            window.rootViewController = navVC
        } else {
            window.rootViewController = TabBarViewController()
        }
        window.makeKeyAndVisible()
        self.window = window
        
        return true
        
//        if !AuthManager.shared.isSignedIn { // Not Sign In
//            // show onboarding page
//            window.rootViewController = TabBarViewController()
//        }
//        else { // Sign In
//            let navVC = UINavigationController(rootViewController: OnboardingViewController())
//            navVC.navigationBar.prefersLargeTitles = true
//            window.rootViewController = navVC
//        }

    }
    
    // MARK: Google SignIn Methods
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
      -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            // if there is an error
            print(error)
            return
        }
        
        print("User email: \(user.profile.email ?? "No Email")")
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        let userID = user.userID
        let idToken = user.authentication.idToken
//        let fullName = user.profile.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        AuthManager.shared.googleSignIn(with: credential) { (success) in
            if success {
                print("user is signed in")
            }
            else {
                print("error to sign in")
            }
        }
        
        
        AuthManager.shared.insertUserIntoDatabase(username: givenName! + familyName! + userID!, email: email!) { (success) in
            if success {
                print("user is in database")
            }
            else {
                print("error to insert user in database")
            }
        }

        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // perform any operations when the user disconnects from app here.
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

