//
//  Assignment View.swift
//  Assignment Notebook
//
//  Created by Student on 1/19/22.
//

import SwiftUI

struct Assignment_View: View {
    @ObservedObject var assignmentList = Assignment_List()
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
    static let priorities = ["Math", "English", "Science", "History", "Mobile Apps", "Team Sports"]
    
    var body: some View {
        
        NavigationView {
            Form {
                Picker("Course", selection: $course) {
                    ForEach(Self.priorities, id: \.self) { priority in
                        Text(priority)
                    }
                }
                TextField("Description", text: $description).foregroundColor(.blue)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if course.count > 0 && description.count > 0 {
                    let item = AssignmentItem(id: UUID(), course: course, description: description, dueDate: dueDate)
                    assignmentList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
        }
        
            })
        }
        
    }
}

struct Assignment_View_Previews: PreviewProvider {
    static var previews: some View {
        Assignment_View(assignmentList: Assignment_List())
    }
}

