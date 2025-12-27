//
//  AuthManager.swift
//  CodeQuiz
//
//  Created by Samrudh S on 12/25/25.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
final class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    @Published var authError: String?
    private var handle: AuthStateDidChangeListenerHandle?

    init() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }

    deinit {
        if let handle { Auth.auth().removeStateDidChangeListener(handle) }
    }

    func signUp(email: String, password: String) async {
        authError = nil
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            user = result.user
        } catch {
            authError = error.localizedDescription
        }
    }

    func signIn(email: String, password: String) async {
        authError = nil
        isLoading = true
        defer { isLoading = false }

        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            user = result.user
        } catch {
            authError = error.localizedDescription
        }
    }

    func signOut() {
        authError = nil
        do {
            try Auth.auth().signOut()
            user = nil
        } catch {
            authError = error.localizedDescription
        }
    }
    
    func signInAnonymously() async{
        authError = nil
        do{
            let result = try await Auth.auth().signInAnonymously()
            user = result.user
        } catch{
            authError = error.localizedDescription
        }
    }
}
