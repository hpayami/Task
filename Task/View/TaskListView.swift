//
//  TaskView.swift
//  Task
//
//  Created by PhD Hossein Payami on 5/7/23.
//

import SwiftUI
import Combine

	// MARK: - TaskView



struct TaskListView: View {
	@StateObject var viewModel = TaskViewModel()
	@State  var newTaskTitle = ""
	@State  var newTaskDescription = ""
	@State  var showCompletedTasks = false
	@State  var showError = false


	var body: some View {
		NavigationView {


		VStack {

//				TemplateTop()
//					.edgesIgnoringSafeArea(.all)


			VStack {
				HStack{

					TextField("Title", text: $newTaskTitle)
						.font(.custom("MarkPro", size: 17))
						.padding()


						.cornerRadius(25)
						.overlay(
							RoundedRectangle(cornerRadius: 25)
								.stroke ( Color("Secondary").opacity(1), lineWidth: 1)


						)



						.padding(.horizontal)
						.keyboardType(.alphabet)
						.imageScale(.medium)

				}
				HStack{
					TextField("Description", text: $newTaskDescription)

						.font(.custom("MarkPro-Medium", size: 17))
						.padding()

						.cornerRadius(25)
						.overlay(
							RoundedRectangle(cornerRadius: 25)
								.stroke ( Color("Secondary").opacity(1), lineWidth: 1)

						)


						.padding(.horizontal)
						.keyboardType(.alphabet)
						.imageScale(.medium)
				}
				HStack {
					Button {
						viewModel.addTask(title: newTaskTitle, taskDescription: newTaskDescription)
						newTaskTitle = ""
						newTaskDescription = ""

					} label: {
						Text("Add New Task")
							.font(.custom("MarkPro", size: 17))
							.bold()
							.foregroundColor(.white)

					}.frame(width: 342, height: 50)
						.background(Color(.black))
						.cornerRadius(25)
				}.frame(width: 342, height: 50)
					.background(Color(.gray))
					.cornerRadius(25)
					.padding([.top], 20)
					.padding([.bottom], 49)
					.padding([.trailing, .leading], 24)

			}
			.padding()

			HStack{
				Toggle("Show Done Task", isOn: $showCompletedTasks)
			}
			.padding()

			List {
				ForEach(viewModel.filteredTasks) { task in
					TaskRow(task: task, onToggle: { completed in
						var updatedTask = task
						updatedTask.completed = completed
						viewModel.updateTask(task: updatedTask)
					})
				}


				.onMove( perform: { indices, newOffset in
					viewModel.tasks.move(fromOffsets: indices, toOffset: newOffset)
					viewModel.filteredTasks = viewModel.tasks
					viewModel.saveTasks()
				})
				.onDelete { indexSet in
					viewModel.deleteTask(task: viewModel.filteredTasks[indexSet.first!])
				}
			}.onAppear(){
				viewModel.fetchTasks()
			}
			.listStyle(PlainListStyle())


		}
		.toolbar {
			EditButton()

		}
		}

					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.background(Color("Background3"))
					.edgesIgnoringSafeArea(.all)



			.statusBarHidden()
			.navigationBarBackButtonHidden()

	}
}
struct TaskRow: View {
	let task: Task
	let onToggle: (Bool) -> Void
	var body: some View {
		HStack {
			Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
				.foregroundColor(task.completed ? .green : .gray)
				.onTapGesture {
					onToggle(!task.completed)
				}
			VStack(alignment: .leading) {
				Text(task.title)
					.font(.headline)
				Text(task.taskDescription)
					.font(.subheadline)
			}
		}
	}
}
