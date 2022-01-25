//
//  ContentView.swift
//  Assigment NoteBook
//
//  Created by Student on 1/13/22.
//

import SwiftUI
struct ContentView: View {
    
    @ObservedObject var assignmentList = Assignment_List()
    @State private var showingAddItemView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentList.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        }
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentList.items.remove(atOffsets: indexSet)
                })
            }
            .navigationBarTitle("Things", displayMode: .inline)
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {showingAddItemView = true})
                {Image(systemName: "plus")})
            
            .sheet(isPresented: $showingAddItemView, content: {
                Assignment_View(assignmentList: assignmentList)
            })
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AssignmentItem: Identifiable, Codable {
    var id = UUID()
    var course = String()
    var description = String()
    var dueDate = Date()
}

