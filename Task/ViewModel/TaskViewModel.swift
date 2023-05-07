//
//  TaskViewModel.swift
//  Task
//
//  Created by PhD Hossein Payami on 5/7/23.
//

import Foundation
import SwiftUI
import Foundation
import Combine

class TaskViewModel: ObservableObject {
	@Published var tasks: [Task] = []
	@Published var filteredTasks: [Task] = []

	private var cancellables: Set<AnyCancellable> = []

	init() {
		fetchTasks()
	}

	func fetchTasks() {
		URLSession.shared.dataTaskPublisher(for: URL(string: "https://mockapi.io/projects/645766030c15cb1482079add/tasks")!)
			.map { $0.data }
			.decode(type: [Task].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.sink { completion in
				switch completion {
					case .finished:
						break
					case .failure(let error):
						print("Error fetching tasks: \(error.localizedDescription)")
				}
			} receiveValue: { [weak self] tasks in
				self?.tasks = tasks
				self?.filteredTasks = tasks
			}
			.store(in: &cancellables)
	}

	func addTask(title: String, taskDescription: String) {
		let task = Task(
			id: UUID().uuidString,
			title: title,
			taskDescription: taskDescription,
			createdAt: "\(Date().timeIntervalSince1970)", completed: false
		)
		tasks.append(task)
		filteredTasks = tasks
		saveTasks()
	}

	func updateTask(task: Task) {
		if let index = tasks.firstIndex(where: { $0.id == task.id }) {
			tasks[index] = task
			filteredTasks = tasks
			saveTasks()
		}
	}

	func deleteTask(task: Task) {
		tasks.removeAll(where: { $0.id == task.id })
		filteredTasks = tasks
		saveTasks()
	}

	func filterTasks(completed: Bool) {
		filteredTasks = tasks.filter { $0.completed == completed }
	}

	func saveTasks() {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(tasks) {
			UserDefaults.standard.set(encoded, forKey: "tasks")
		}
	}
}

