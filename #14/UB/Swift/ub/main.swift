//
//  main.swift
//  ub


import Foundation

class EventLog {
    private var lastMessage: String? = .none
    
    func log(message: String) {
        print(message)
        lastMessage = message
    }
}


let eventLog = EventLog()
let q = DispatchQueue(label: "ub", attributes: [.concurrent])

for i in 0...100
{
    q.async {
        eventLog.log(message: "log \(i)")
    }
}

