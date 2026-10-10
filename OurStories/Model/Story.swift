//
//  Story.swift
//  OurStories
//
//  Created by Xiang Xu on 21/05/2019.
//  Copyright © 2019 Xiang Xu. All rights reserved.
//
import Foundation
import MapKit

/// When a story happened. Most are remembered to the month, a few to the day.
struct StoryDate: Equatable, Decodable
{
    let year: Int
    let month: Int
    let day: Int?

    init(year: Int, month: Int, day: Int? = nil)
    {
        self.year = year
        self.month = month
        self.day = day
    }

    /// e.g. "2012年7月" or "2021年7月7日".
    var displayText: String
    {
        guard let day = day else { return "\(year)年\(month)月" }
        return "\(year)年\(month)月\(day)日"
    }
}

/// One card in the deck. The stories themselves live in `Resources/stories.json`
/// and are loaded by `StoryStore`.
struct Story: Decodable
{
    let location: String
    /// nil for stories whose date has not been filled in yet.
    let date: StoryDate?
    let storyContent: String
    let imageName: String
    let coordinate: CLLocationCoordinate2D

    init(location: String, date: StoryDate? = nil, storyContent: String, imageName: String, coordinate: CLLocationCoordinate2D)
    {
        self.location = location
        self.date = date
        self.storyContent = storyContent
        self.imageName = imageName
        self.coordinate = coordinate
    }

    private enum CodingKeys: String, CodingKey
    {
        case location, date, latitude, longitude
        case storyContent = "text"
        case imageName = "image"
    }

    init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        location = try container.decode(String.self, forKey: .location)
        date = try container.decodeIfPresent(StoryDate.self, forKey: .date)
        storyContent = try container.decode(String.self, forKey: .storyContent)
        imageName = try container.decode(String.self, forKey: .imageName)
        coordinate = CLLocationCoordinate2D(latitude: try container.decode(Double.self, forKey: .latitude),
                                            longitude: try container.decode(Double.self, forKey: .longitude))
    }
}
