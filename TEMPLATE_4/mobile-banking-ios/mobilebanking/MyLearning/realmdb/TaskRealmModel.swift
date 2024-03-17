//
//  TaskRealmModel.swift
//  mobilebanking
//
//  Created by Daniel Kimani on 08/03/2024.
//

import Foundation
import RealmSwift

class TaskRealmModel: Object,Identifiable {
    @Persisted var id: UUID = UUID()
    @Persisted var title: String = ""
    @Persisted var details: String?
    @Persisted var isCompleted: Bool = false
}
