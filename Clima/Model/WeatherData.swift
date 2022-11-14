
// JSON 구조를 실제로 참고해서 보아야 한다.
// response JSON Data 이름과 같아야 한다.

// Decodable : JSON Representation으로 decode 가능함
// Codable - typealias == Encodable & Decodable
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let id: Int
}
