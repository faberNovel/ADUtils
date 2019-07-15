//
//  Array+Filter.swift
//  ADDynamicLogLevel
//
//  Created by Pierre Felgines on 31/05/2018.
//

import Foundation

public extension Array {

    /**
     Filter an array of Element with a string query for keypaths KeyPath<Element, String>
     - parameter query: String composed of multiple terms. Eg: "cat dog bird"
     - parameter keyPaths: Array of keypaths of Element
     - Note:
     Consider the struct
     ```
     struct User {
        let name: String
        let address: String
     }
     ```
     The call to
     ```
     users.ad_filter(query: "Bob street", for: [\User.name, \User.address])
     ```
     will filter each user with the following predicate
     ```
     (user.name.contains("bob") || user.address.contains("bob"))
     && (user.name.contains("street") || user.address.contains("street"))
     ```
     */
    func ad_filter(query: String, for keyPaths: [KeyPath<Element, String>]) -> [Element] {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return self }
        let searchTerms = Set(trimmedQuery.components(separatedBy: " "))
        return filter { element($0, contains: searchTerms, in: keyPaths) }
    }

    // MARK: - Private

    /**
     Test if the element contains all the search terms in one of its keyPaths
     - parameter element: Element of the array
     - parameter searchTerms: search terms representing the query
     - parameter keyPaths: Array of keypaths of Element
     */
    private func element(_ element: Element,
                         contains searchTerms: Set<String>,
                         in keyPaths: [KeyPath<Element, String>]) -> Bool {
        // ???: (Denis Poifol) 30/05/2018
        // !lazy.map.contains(false) does the same thing as a reduce function: make sure each
        // terms appears at least once. But contrary to reduce not all elements are looped through.
        // As soon as we find a term that does not appear in any property of the object we return.
        let searchTermsAreContained = searchTerms
            .lazy
            .map { term in
                return keyPaths.contains { keyPath in
                    // ???: (Pierre Felgines) 31/05/2018 The cast to NSString improves performance
                    return (element[keyPath: keyPath] as NSString).localizedStandardContains(term)
                }
            }
        return !searchTermsAreContained.contains(false)
    }
}
