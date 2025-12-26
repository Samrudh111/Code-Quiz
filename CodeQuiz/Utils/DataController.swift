//
//  DataController.swift
//  CodeQuiz
//
//  Created by Samrudh S on 12/25/25.
//

import Foundation
import CoreData
import Combine

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CodeQuiz")
    init() {
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Core Data failed to load - \(error.localizedDescription)")
            }
        }
    }
}
