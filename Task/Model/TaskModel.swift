//
//  TaskModel.swift
//  Task
//
//  Created by PhD Hossein Payami on 5/7/23.
//

import Foundation
	// MARK: - TaskModel

struct Task: Codable, Identifiable {
	var id, title, taskDescription,createdAt: String
	var completed: Bool
	 
}
