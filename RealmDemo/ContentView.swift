//
//  ContentView.swift
//  RealmDemo
//
//  Created by charles raj on 04/06/24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @State private var name : String = ""
    @State private var gender : String = ""
    @State private var age : String = ""
    @State var items : [Notes] = []
    
    
    var body: some View {
        
        VStack {
     
            
            Form{
                
                Text("Add Note")
                
                TextField("Name" , text : $name)
                TextField( "Gender" , text : $gender)
                TextField( "Age" , text : $age)
                
                Button {
                    saveData(name: name, gender: gender, age: age, callback: { status in
                        if status {
                            
                            name = ""
                            gender = ""
                            age = ""
                            items = getAllNotes()
                        } else {
                            
                        }
                    })
                } label: {
                    Text("Save")
                }
            }
            
            HStack {
                Button {
                   items = getAllNotes()
                } label: {
                    Text("All")
                }
                Spacer()
                Button {
                    items = getNotesByGender(gender: "M")
                } label: {
                    Text("Male")
                }
                Spacer()
                Button {
                    items = getNotesByGender(gender: "F")
                } label: {
                    Text("Female")
                }
            }
            
            List(self.items) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Text(item.gender)
                    Spacer()
                    Text(item.age)
                    Spacer()
                    Image(systemName: "trash")
                        .foregroundColor(.black).onTapGesture {
                            deleteItem(note: item){ status in
                                items = getAllNotes()
                            }
                        }
                }
            }
            
        }
        .padding()
        .onAppear{
            self.items = getAllNotes()
        }
    }
    
    func deleteItem(note : Notes, 
                    callback : (Bool) -> Void
    ){
        let realm = try! Realm()
        
        let deletedItem = realm.objects(Notes.self).where{
            $0._id == note._id
        }
        
        try! realm.write{
            realm.delete(deletedItem)
        }
        callback(true)
    }
    
    func saveData(
        name : String,
        gender : String,
        age : String,
        callback : (Bool) -> Void
    ){
        do{
            let realm = try! Realm()
            
            let item = Notes(name: name, gender: gender, age: age)
            
            try realm.write{
                realm.add(item)
            }
            
           callback(true)
        } catch {
            callback(false)
        }
    }
    
    func getAllNotes() -> [Notes]{
        let realm = try! Realm()
        return Array(realm.objects(Notes.self))
    }
    
    func getNotesByGender(gender : String) -> [Notes]{
        let realm = try! Realm()
        return Array(realm.objects(Notes.self).where{
            $0.gender == gender
        })
    }
}




#Preview {
    ContentView()
}
