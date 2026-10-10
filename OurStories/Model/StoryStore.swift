//
//  StoryStore.swift
//  OurStories
//

import Foundation

/// Loads the stories bundled in `stories.json`, once, in card order.
final class StoryStore
{
    static let shared = StoryStore()

    let stories: [Story]

    private init()
    {
        do {
            stories = try StoryStore.loadStories(from: .main)
        } catch {
            // The file ships inside the app, so this is a mistake in stories.json.
            fatalError("Could not load stories.json: \(error)")
        }
    }

    static func loadStories(from bundle: Bundle) throws -> [Story]
    {
        guard let url = bundle.url(forResource: "stories", withExtension: "json") else {
            throw CocoaError(.fileNoSuchFile)
        }
        return try JSONDecoder().decode([Story].self, from: Data(contentsOf: url))
    }
}
