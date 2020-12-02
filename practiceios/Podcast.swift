import Foundation

struct PodcastCollection: Codable {
    let resultCount: Int
    let results: [Podcast]
}

struct Podcast: Codable {
    let trackName: String
    let artworkUrl100: String?
    let artworkUrl600: String?
}