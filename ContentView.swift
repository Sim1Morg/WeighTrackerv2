import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingAddEntry = false
    @State private var selectedDate: Date? = nil
    @State private var showEditEntry = false
    @State private var selectedEntry: Entry? = nil

    var body: some View {
        NavigationView {
            VStack {
                CalendarView(selectedDate: $selectedDate)
                if let selectedDate = selectedDate {
                    if let entry = dataManager.getEntry(for: selectedDate) {
                        Text("Weight: \(entry.weight)")
                        Text("Body Fat: \(entry.bodyFat)")
                        Text("Muscle Mass: \(entry.muscleMass)")
                        Text("Visceral Fat: \(entry.visceralFat)")
                        if let image = entry.image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                        }
                        
                        Button("Edit Entry") {
                            selectedEntry = entry
                            showEditEntry = true
                        }
                    } else {
                       Text("No Entry for this date")
                    }
                }
            }
            .navigationTitle("Weight Tracker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddEntry = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
            }
            .sheet(isPresented: $showingAddEntry) {
                DataEntryView()
            }
            .sheet(isPresented: $showEditEntry) {
                if let selectedEntry = selectedEntry {
                  DataEntryView(entry: selectedEntry, editingMode: true)
               }
             }
        }
    }
}

