//
//  Note.swift
//  Notes
//
//  Created by Marian Stanciulica on 17/09/2018.
//  Copyright © 2018 Marian Stanciulica. All rights reserved.
//

import Foundation

extension Note {
    
    // MARK: - Dates
    
    var updatedAtAsDate: Date {
        guard let updatedAt = updatedAt else { return Date() }
        return Date(timeIntervalSince1970: updatedAt.timeIntervalSince1970)
    }
    
    var createdAtAsDate: Date {
        guard let createdAt = createdAt else { return Date() }
        return Date(timeIntervalSince1970: createdAt.timeIntervalSince1970)
    }
    
    // MARK: - Tags
    
    var alphabetizedTags: [Tag]? {
        guard let tags = tags as? Set<Tag> else {
            return nil
        }
        
        return tags.sorted(by: {
            guard let tag0 = $0.name else { return true }
            guard let tag1 = $1.name else { return true }
            return tag0 < tag1
        })
    }
    
    var alphabetizedTagsAsString: String? {
        guard let tags = alphabetizedTags, tags.count > 0 else { return nil }
        
        let names = tags.compactMap { $0.name }
        return names.joined(separator: ", ")
    }
    
}
