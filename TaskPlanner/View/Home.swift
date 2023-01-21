//
//  Home.swift
//  TaskPlanner
//
//  Created by Berkay Disli on 21.01.2023.
//

import SwiftUI

struct Home: View {
    @State private var currentDay: Date = .init()
    var body: some View {
        ScrollView(showsIndicators: false) {
            
        }
        .safeAreaInset(edge: .top, spacing: 0) {
            HeaderView()
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Today")
                        .montserrat(30, weight: .light)
                    
                    Text("Welcome, iosdev22")
                        .montserrat(14, weight: .light)
                }
                .hAlign(.leading)
                
                Button {
                    
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "plus")
                        Text("Add Task")
                            .montserrat(15, weight: .regular)
                    }
                    .padding(.vertical, 10).padding(.horizontal, 15)
                    .background {
                        Capsule()
                            .fill(Color("Blue"))
                    }
                    .foregroundColor(.white)
                }

            }
            
            Text(Date().toString("MMM YYYY"))
                .montserrat(16, weight: .medium)
                .hAlign(.leading)
                .padding(.top, 15)
            
            WeekRow()
        }
        .padding(15)
    }
    
    @ViewBuilder
    func WeekRow() -> some View {
        HStack(spacing: 0) {
            ForEach(Calendar.current.currentWeek) {weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6) {
                    Text(weekDay.string.prefix(3))
                        .montserrat(12, weight: .medium)
                    Text(weekDay.date.toString("dd"))
                        .montserrat(16, weight: status ? .medium: .regular)
                }
                .foregroundColor(status ? Color("Blue"):.gray)
                .hAlign(.center)
                //.contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, -15)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}

extension Date {
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension Calendar {
    var currentWeek: [WeekDay] {
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start else { return [] }
        var week: [WeekDay] = []
        for index in 1..<8 {
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay) {
                let weekdaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekdaySymbol, date: day))
            }
        }
        
        return week
    }
    
    struct WeekDay: Identifiable {
        let id = UUID()
        let string: String
        let date: Date
        var isToday: Bool = false
    }
}
