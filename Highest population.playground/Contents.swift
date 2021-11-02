/*
Given list of people with their birth and death years. How to fine the year with highest population
 */

struct Person {
    let brithDate: Int
    let deathDate : Int
}

var yearPopulations = [Int: Int]()

//func getyearWithHighestPopulation(for people: [Person]) -> Int? {
//    yearPopulations = [:]
//
//    people.forEach { person in
//        calculateBirthDate(for: person)
//        calculateDeathDate(for: person)
//    }
//
//    return yearPopulations.max(by: { $0.value > $1.value })?.key
//}
//
//private func calculateBirthDate(for person: Person) {
//    if yearPopulations[person.brithDate] == nil {
//        let population = calculatePopulation(until: person.brithDate)
//        yearPopulations[person.brithDate] = population + 1
//    }
//    yearPopulations[person.brithDate] = ((yearPopulations[person.brithDate] ?? 0) + 1)
//}
//
//private func calculateDeathDate(for person: Person) {
//    if yearPopulations[person.brithDate] == nil {
//        let population = calculatePopulation(until: person.deathDate)
//        yearPopulations[person.deathDate] = population + 1
//    }
//    yearPopulations[person.deathDate] = ((yearPopulations[person.deathDate] ?? 0) - 1)
//}
//
//private func calculatePopulation(until year: Int) -> Int {
//    var totalSum = 0
//    for (key, value) in yearPopulations where key < year {
//        totalSum += value
//    }
//    return totalSum
//}

func getyearWithHighestPopulation(for people: [Person]) -> Int? {
    yearPopulations = [:]

    for person1 in people where yearPopulations[person1.brithDate] == nil {
        for person2 in people {
            if person2.brithDate <= person1.brithDate && person2.deathDate >= person1.brithDate {
                yearPopulations[person1.brithDate] = ((yearPopulations[person1.brithDate] ?? 0) + 1)
            }
        }
    }

    return yearPopulations.max(by: { $0.value > $1.value })?.key
}

let p1 = Person(brithDate: 2000, deathDate: 2010)
let p2 = Person(brithDate: 1975, deathDate: 2005)
let p3 = Person(brithDate: 1975, deathDate: 2003)
let p4 = Person(brithDate: 1803, deathDate: 1809)
let p5 = Person(brithDate: 1750, deathDate: 1869)
let p6 = Person(brithDate: 1840, deathDate: 1935)
let p7 = Person(brithDate: 1803, deathDate: 1921)
let p8 = Person(brithDate: 2005, deathDate: 2010)
let p9 = Person(brithDate: 2005, deathDate: 2006)
let p10 = Person(brithDate: 1890, deathDate: 2003)

getyearWithHighestPopulation(for: [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10])



