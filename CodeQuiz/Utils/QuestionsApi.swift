//
//  QuestionsApi.swift
//  CodeQuiz
//
//  Created by Samrudh S on 11/29/25.
//

import Foundation

final class QuestionAPI {
    static let shared = QuestionAPI()
    private init() {}

    // For simulator hitting Flask on same Mac:
    // - Use http://127.0.0.1:5000
    // For real device on same Wi-Fi:
    // - Use http://<your-mac-LAN-ip>:5000
    //private let baseURL = URL(string: "http://127.0.0.1:5000")!
    private let baseURL = URL(string: "http://192.168.1.7:5001")!

    struct QuestionRequest: Encodable {
        let language: String
        let topic: String
        let difficulty: String
        let questionCount: Int
    }

    func generateQuestions(language: String, topic: String, difficulty: Difficulty, count: Int) async throws -> [QAai] {
        let url = baseURL.appendingPathComponent("generate-questions")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = QuestionRequest(
            language: language,
            topic: topic,
            difficulty: difficulty.rawValue,
            questionCount: count
        )

        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(QuestionResponse.self, from: data)
        return decoded.questions
    }
}
