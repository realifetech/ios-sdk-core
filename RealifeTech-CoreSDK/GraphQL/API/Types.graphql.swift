// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public enum ApolloType {
  public struct AnalyticEvent: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - type
    ///   - action
    ///   - new
    ///   - old
    ///   - version
    ///   - timestamp
    public init(type: String, action: String, new: Swift.Optional<String?> = nil, old: Swift.Optional<String?> = nil, version: String, timestamp: String) {
      graphQLMap = ["type": type, "action": action, "new": new, "old": old, "version": version, "timestamp": timestamp]
    }

    public var type: String {
      get {
        return graphQLMap["type"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "type")
      }
    }

    public var action: String {
      get {
        return graphQLMap["action"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "action")
      }
    }

    public var new: Swift.Optional<String?> {
      get {
        return graphQLMap["new"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "new")
      }
    }

    public var old: Swift.Optional<String?> {
      get {
        return graphQLMap["old"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "old")
      }
    }

    public var version: String {
      get {
        return graphQLMap["version"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "version")
      }
    }

    public var timestamp: String {
      get {
        return graphQLMap["timestamp"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "timestamp")
      }
    }
  }

  public enum Language: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case en
    case fr
    case nr
    case de
    case sv
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "en": self = .en
        case "fr": self = .fr
        case "nr": self = .nr
        case "de": self = .de
        case "sv": self = .sv
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .en: return "en"
        case .fr: return "fr"
        case .nr: return "nr"
        case .de: return "de"
        case .sv: return "sv"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: Language, rhs: Language) -> Bool {
      switch (lhs, rhs) {
        case (.en, .en): return true
        case (.fr, .fr): return true
        case (.nr, .nr): return true
        case (.de, .de): return true
        case (.sv, .sv): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [Language] {
      return [
        .en,
        .fr,
        .nr,
        .de,
        .sv,
      ]
    }
  }

  public enum ScreenType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case discover
    case shop
    case events
    case wallet
    case booking
    case lineup
    case generic
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "discover": self = .discover
        case "shop": self = .shop
        case "events": self = .events
        case "wallet": self = .wallet
        case "booking": self = .booking
        case "lineup": self = .lineup
        case "generic": self = .generic
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .discover: return "discover"
        case .shop: return "shop"
        case .events: return "events"
        case .wallet: return "wallet"
        case .booking: return "booking"
        case .lineup: return "lineup"
        case .generic: return "generic"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: ScreenType, rhs: ScreenType) -> Bool {
      switch (lhs, rhs) {
        case (.discover, .discover): return true
        case (.shop, .shop): return true
        case (.events, .events): return true
        case (.wallet, .wallet): return true
        case (.booking, .booking): return true
        case (.lineup, .lineup): return true
        case (.generic, .generic): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [ScreenType] {
      return [
        .discover,
        .shop,
        .events,
        .wallet,
        .booking,
        .lineup,
        .generic,
      ]
    }
  }

  public enum StyleType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case pager
    case carousel
    case list
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "PAGER": self = .pager
        case "CAROUSEL": self = .carousel
        case "LIST": self = .list
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .pager: return "PAGER"
        case .carousel: return "CAROUSEL"
        case .list: return "LIST"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: StyleType, rhs: StyleType) -> Bool {
      switch (lhs, rhs) {
        case (.pager, .pager): return true
        case (.carousel, .carousel): return true
        case (.list, .list): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [StyleType] {
      return [
        .pager,
        .carousel,
        .list,
      ]
    }
  }

  public enum StyleSize: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case small
    case medium
    case large
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "SMALL": self = .small
        case "MEDIUM": self = .medium
        case "LARGE": self = .large
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .small: return "SMALL"
        case .medium: return "MEDIUM"
        case .large: return "LARGE"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: StyleSize, rhs: StyleSize) -> Bool {
      switch (lhs, rhs) {
        case (.small, .small): return true
        case (.medium, .medium): return true
        case (.large, .large): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [StyleSize] {
      return [
        .small,
        .medium,
        .large,
      ]
    }
  }

  public enum WidgetType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case product
    case button
    case banner
    case event
    case fixture
    case countdownClock
    case galleryCoverImage
    case news
    case ticket
    case ticketProduct
    case fulfilmentPoint
    case socialPost
    case fulfilmentPointCategorySelector
    case eventSelector
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "Product": self = .product
        case "Button": self = .button
        case "Banner": self = .banner
        case "Event": self = .event
        case "Fixture": self = .fixture
        case "CountdownClock": self = .countdownClock
        case "GalleryCoverImage": self = .galleryCoverImage
        case "News": self = .news
        case "Ticket": self = .ticket
        case "TicketProduct": self = .ticketProduct
        case "FulfilmentPoint": self = .fulfilmentPoint
        case "SocialPost": self = .socialPost
        case "FulfilmentPointCategorySelector": self = .fulfilmentPointCategorySelector
        case "EventSelector": self = .eventSelector
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .product: return "Product"
        case .button: return "Button"
        case .banner: return "Banner"
        case .event: return "Event"
        case .fixture: return "Fixture"
        case .countdownClock: return "CountdownClock"
        case .galleryCoverImage: return "GalleryCoverImage"
        case .news: return "News"
        case .ticket: return "Ticket"
        case .ticketProduct: return "TicketProduct"
        case .fulfilmentPoint: return "FulfilmentPoint"
        case .socialPost: return "SocialPost"
        case .fulfilmentPointCategorySelector: return "FulfilmentPointCategorySelector"
        case .eventSelector: return "EventSelector"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: WidgetType, rhs: WidgetType) -> Bool {
      switch (lhs, rhs) {
        case (.product, .product): return true
        case (.button, .button): return true
        case (.banner, .banner): return true
        case (.event, .event): return true
        case (.fixture, .fixture): return true
        case (.countdownClock, .countdownClock): return true
        case (.galleryCoverImage, .galleryCoverImage): return true
        case (.news, .news): return true
        case (.ticket, .ticket): return true
        case (.ticketProduct, .ticketProduct): return true
        case (.fulfilmentPoint, .fulfilmentPoint): return true
        case (.socialPost, .socialPost): return true
        case (.fulfilmentPointCategorySelector, .fulfilmentPointCategorySelector): return true
        case (.eventSelector, .eventSelector): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [WidgetType] {
      return [
        .product,
        .button,
        .banner,
        .event,
        .fixture,
        .countdownClock,
        .galleryCoverImage,
        .news,
        .ticket,
        .ticketProduct,
        .fulfilmentPoint,
        .socialPost,
        .fulfilmentPointCategorySelector,
        .eventSelector,
      ]
    }
  }

  public enum WidgetFetchType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case featured
    case feed
    case `static`
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "featured": self = .featured
        case "feed": self = .feed
        case "static": self = .static
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .featured: return "featured"
        case .feed: return "feed"
        case .static: return "static"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: WidgetFetchType, rhs: WidgetFetchType) -> Bool {
      switch (lhs, rhs) {
        case (.featured, .featured): return true
        case (.feed, .feed): return true
        case (.static, .static): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [WidgetFetchType] {
      return [
        .featured,
        .feed,
        .static,
      ]
    }
  }
}
