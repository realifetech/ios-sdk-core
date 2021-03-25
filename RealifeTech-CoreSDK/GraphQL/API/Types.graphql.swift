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

  public enum ScreenType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case discover
    case shop
    case events
    case wallet
    case booking
    case lineup
    case social
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
        case "social": self = .social
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
        case .social: return "social"
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
        case (.social, .social): return true
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
        .social,
        .generic,
      ]
    }
  }

  public enum WebPageType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case audioGuidesHelp
    case tAndC
    case privacy
    case about
    case aboutCompany
    case important
    case info
    case times
    case event
    case welcome
    case travel
    case faq
    case food
    case program
    case social
    case menu
    case legal
    case quizHelp
    case quizTerms
    case quizWinner
    case ntpTerms
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "audioGuidesHelp": self = .audioGuidesHelp
        case "tAndC": self = .tAndC
        case "privacy": self = .privacy
        case "about": self = .about
        case "aboutCompany": self = .aboutCompany
        case "important": self = .important
        case "info": self = .info
        case "times": self = .times
        case "event": self = .event
        case "welcome": self = .welcome
        case "travel": self = .travel
        case "faq": self = .faq
        case "food": self = .food
        case "program": self = .program
        case "social": self = .social
        case "menu": self = .menu
        case "legal": self = .legal
        case "quizHelp": self = .quizHelp
        case "quizTerms": self = .quizTerms
        case "quizWinner": self = .quizWinner
        case "ntpTerms": self = .ntpTerms
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .audioGuidesHelp: return "audioGuidesHelp"
        case .tAndC: return "tAndC"
        case .privacy: return "privacy"
        case .about: return "about"
        case .aboutCompany: return "aboutCompany"
        case .important: return "important"
        case .info: return "info"
        case .times: return "times"
        case .event: return "event"
        case .welcome: return "welcome"
        case .travel: return "travel"
        case .faq: return "faq"
        case .food: return "food"
        case .program: return "program"
        case .social: return "social"
        case .menu: return "menu"
        case .legal: return "legal"
        case .quizHelp: return "quizHelp"
        case .quizTerms: return "quizTerms"
        case .quizWinner: return "quizWinner"
        case .ntpTerms: return "ntpTerms"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: WebPageType, rhs: WebPageType) -> Bool {
      switch (lhs, rhs) {
        case (.audioGuidesHelp, .audioGuidesHelp): return true
        case (.tAndC, .tAndC): return true
        case (.privacy, .privacy): return true
        case (.about, .about): return true
        case (.aboutCompany, .aboutCompany): return true
        case (.important, .important): return true
        case (.info, .info): return true
        case (.times, .times): return true
        case (.event, .event): return true
        case (.welcome, .welcome): return true
        case (.travel, .travel): return true
        case (.faq, .faq): return true
        case (.food, .food): return true
        case (.program, .program): return true
        case (.social, .social): return true
        case (.menu, .menu): return true
        case (.legal, .legal): return true
        case (.quizHelp, .quizHelp): return true
        case (.quizTerms, .quizTerms): return true
        case (.quizWinner, .quizWinner): return true
        case (.ntpTerms, .ntpTerms): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [WebPageType] {
      return [
        .audioGuidesHelp,
        .tAndC,
        .privacy,
        .about,
        .aboutCompany,
        .important,
        .info,
        .times,
        .event,
        .welcome,
        .travel,
        .faq,
        .food,
        .program,
        .social,
        .menu,
        .legal,
        .quizHelp,
        .quizTerms,
        .quizWinner,
        .ntpTerms,
      ]
    }
  }

  public struct PaymentSourceInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - id
    ///   - billingDetails
    ///   - card
    public init(id: Swift.Optional<GraphQLID?> = nil, billingDetails: Swift.Optional<PaymentSourceBillingDetailsInput?> = nil, card: Swift.Optional<CardInput?> = nil) {
      graphQLMap = ["id": id, "billingDetails": billingDetails, "card": card]
    }

    public var id: Swift.Optional<GraphQLID?> {
      get {
        return graphQLMap["id"] as? Swift.Optional<GraphQLID?> ?? Swift.Optional<GraphQLID?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "id")
      }
    }

    public var billingDetails: Swift.Optional<PaymentSourceBillingDetailsInput?> {
      get {
        return graphQLMap["billingDetails"] as? Swift.Optional<PaymentSourceBillingDetailsInput?> ?? Swift.Optional<PaymentSourceBillingDetailsInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "billingDetails")
      }
    }

    public var card: Swift.Optional<CardInput?> {
      get {
        return graphQLMap["card"] as? Swift.Optional<CardInput?> ?? Swift.Optional<CardInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "card")
      }
    }
  }

  public struct PaymentSourceBillingDetailsInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - address
    ///   - email
    ///   - name
    ///   - phone
    public init(address: Swift.Optional<PaymentSourceAddressInput?> = nil, email: Swift.Optional<String?> = nil, name: Swift.Optional<String?> = nil, phone: Swift.Optional<String?> = nil) {
      graphQLMap = ["address": address, "email": email, "name": name, "phone": phone]
    }

    public var address: Swift.Optional<PaymentSourceAddressInput?> {
      get {
        return graphQLMap["address"] as? Swift.Optional<PaymentSourceAddressInput?> ?? Swift.Optional<PaymentSourceAddressInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "address")
      }
    }

    public var email: Swift.Optional<String?> {
      get {
        return graphQLMap["email"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "email")
      }
    }

    public var name: Swift.Optional<String?> {
      get {
        return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "name")
      }
    }

    public var phone: Swift.Optional<String?> {
      get {
        return graphQLMap["phone"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "phone")
      }
    }
  }

  public struct PaymentSourceAddressInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - city
    ///   - country
    ///   - line1
    ///   - line2
    ///   - postalCode
    ///   - state
    public init(city: Swift.Optional<String?> = nil, country: Swift.Optional<String?> = nil, line1: Swift.Optional<String?> = nil, line2: Swift.Optional<String?> = nil, postalCode: Swift.Optional<String?> = nil, state: Swift.Optional<String?> = nil) {
      graphQLMap = ["city": city, "country": country, "line1": line1, "line2": line2, "postalCode": postalCode, "state": state]
    }

    public var city: Swift.Optional<String?> {
      get {
        return graphQLMap["city"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "city")
      }
    }

    public var country: Swift.Optional<String?> {
      get {
        return graphQLMap["country"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "country")
      }
    }

    public var line1: Swift.Optional<String?> {
      get {
        return graphQLMap["line1"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "line1")
      }
    }

    public var line2: Swift.Optional<String?> {
      get {
        return graphQLMap["line2"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "line2")
      }
    }

    public var postalCode: Swift.Optional<String?> {
      get {
        return graphQLMap["postalCode"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "postalCode")
      }
    }

    public var state: Swift.Optional<String?> {
      get {
        return graphQLMap["state"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "state")
      }
    }
  }

  public struct CardInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - brand
    ///   - numberToken
    ///   - expMonth
    ///   - expYear
    ///   - securityCodeToken
    ///   - last4
    public init(brand: String, numberToken: String, expMonth: String, expYear: String, securityCodeToken: String, last4: String) {
      graphQLMap = ["brand": brand, "numberToken": numberToken, "expMonth": expMonth, "expYear": expYear, "securityCodeToken": securityCodeToken, "last4": last4]
    }

    public var brand: String {
      get {
        return graphQLMap["brand"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "brand")
      }
    }

    public var numberToken: String {
      get {
        return graphQLMap["numberToken"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "numberToken")
      }
    }

    public var expMonth: String {
      get {
        return graphQLMap["expMonth"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "expMonth")
      }
    }

    public var expYear: String {
      get {
        return graphQLMap["expYear"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "expYear")
      }
    }

    public var securityCodeToken: String {
      get {
        return graphQLMap["securityCodeToken"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "securityCodeToken")
      }
    }

    public var last4: String {
      get {
        return graphQLMap["last4"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "last4")
      }
    }
  }

  public struct PaymentIntentInput: GraphQLMapConvertible {
    public var graphQLMap: GraphQLMap

    /// - Parameters:
    ///   - orderType
    ///   - orderId
    ///   - paymentSource
    ///   - amount
    ///   - currency
    ///   - savePaymentSource
    ///   - livemode
    ///   - cancellationReason
    ///   - receiptEmail
    public init(orderType: OrderType, orderId: GraphQLID, paymentSource: Swift.Optional<PaymentSourceInput?> = nil, amount: Int, currency: String, savePaymentSource: Bool, livemode: Bool, cancellationReason: Swift.Optional<CancellationReason?> = nil, receiptEmail: Swift.Optional<String?> = nil) {
      graphQLMap = ["orderType": orderType, "orderId": orderId, "paymentSource": paymentSource, "amount": amount, "currency": currency, "savePaymentSource": savePaymentSource, "livemode": livemode, "cancellationReason": cancellationReason, "receiptEmail": receiptEmail]
    }

    public var orderType: OrderType {
      get {
        return graphQLMap["orderType"] as! OrderType
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "orderType")
      }
    }

    public var orderId: GraphQLID {
      get {
        return graphQLMap["orderId"] as! GraphQLID
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "orderId")
      }
    }

    public var paymentSource: Swift.Optional<PaymentSourceInput?> {
      get {
        return graphQLMap["paymentSource"] as? Swift.Optional<PaymentSourceInput?> ?? Swift.Optional<PaymentSourceInput?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "paymentSource")
      }
    }

    public var amount: Int {
      get {
        return graphQLMap["amount"] as! Int
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "amount")
      }
    }

    public var currency: String {
      get {
        return graphQLMap["currency"] as! String
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "currency")
      }
    }

    public var savePaymentSource: Bool {
      get {
        return graphQLMap["savePaymentSource"] as! Bool
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "savePaymentSource")
      }
    }

    public var livemode: Bool {
      get {
        return graphQLMap["livemode"] as! Bool
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "livemode")
      }
    }

    public var cancellationReason: Swift.Optional<CancellationReason?> {
      get {
        return graphQLMap["cancellationReason"] as? Swift.Optional<CancellationReason?> ?? Swift.Optional<CancellationReason?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "cancellationReason")
      }
    }

    public var receiptEmail: Swift.Optional<String?> {
      get {
        return graphQLMap["receiptEmail"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
      }
      set {
        graphQLMap.updateValue(newValue, forKey: "receiptEmail")
      }
    }
  }

  public enum OrderType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case foodAndBeverage
    case ticket
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "food_and_beverage": self = .foodAndBeverage
        case "ticket": self = .ticket
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .foodAndBeverage: return "food_and_beverage"
        case .ticket: return "ticket"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: OrderType, rhs: OrderType) -> Bool {
      switch (lhs, rhs) {
        case (.foodAndBeverage, .foodAndBeverage): return true
        case (.ticket, .ticket): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [OrderType] {
      return [
        .foodAndBeverage,
        .ticket,
      ]
    }
  }

  public enum CancellationReason: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case duplicate
    case fraudulent
    case requestedByCustomer
    case abandoned
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "duplicate": self = .duplicate
        case "fraudulent": self = .fraudulent
        case "requested_by_customer": self = .requestedByCustomer
        case "abandoned": self = .abandoned
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .duplicate: return "duplicate"
        case .fraudulent: return "fraudulent"
        case .requestedByCustomer: return "requested_by_customer"
        case .abandoned: return "abandoned"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: CancellationReason, rhs: CancellationReason) -> Bool {
      switch (lhs, rhs) {
        case (.duplicate, .duplicate): return true
        case (.fraudulent, .fraudulent): return true
        case (.requestedByCustomer, .requestedByCustomer): return true
        case (.abandoned, .abandoned): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [CancellationReason] {
      return [
        .duplicate,
        .fraudulent,
        .requestedByCustomer,
        .abandoned,
      ]
    }
  }

  public enum PaymentStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case requiresPaymentMethod
    case requiresAction
    case processing
    case succeeded
    case canceled
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "requires_payment_method": self = .requiresPaymentMethod
        case "requires_action": self = .requiresAction
        case "processing": self = .processing
        case "succeeded": self = .succeeded
        case "canceled": self = .canceled
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .requiresPaymentMethod: return "requires_payment_method"
        case .requiresAction: return "requires_action"
        case .processing: return "processing"
        case .succeeded: return "succeeded"
        case .canceled: return "canceled"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: PaymentStatus, rhs: PaymentStatus) -> Bool {
      switch (lhs, rhs) {
        case (.requiresPaymentMethod, .requiresPaymentMethod): return true
        case (.requiresAction, .requiresAction): return true
        case (.processing, .processing): return true
        case (.succeeded, .succeeded): return true
        case (.canceled, .canceled): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [PaymentStatus] {
      return [
        .requiresPaymentMethod,
        .requiresAction,
        .processing,
        .succeeded,
        .canceled,
      ]
    }
  }

  public enum PaymentActionType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case redirectToUrl
    case collectCvc
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "redirect_to_url": self = .redirectToUrl
        case "collect_cvc": self = .collectCvc
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .redirectToUrl: return "redirect_to_url"
        case .collectCvc: return "collect_cvc"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: PaymentActionType, rhs: PaymentActionType) -> Bool {
      switch (lhs, rhs) {
        case (.redirectToUrl, .redirectToUrl): return true
        case (.collectCvc, .collectCvc): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [PaymentActionType] {
      return [
        .redirectToUrl,
        .collectCvc,
      ]
    }
  }

  public enum Language: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case en
    case fr
    case nr
    case de
    case sv
    case nb
    case lt
    case pt
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "en": self = .en
        case "fr": self = .fr
        case "nr": self = .nr
        case "de": self = .de
        case "sv": self = .sv
        case "nb": self = .nb
        case "lt": self = .lt
        case "pt": self = .pt
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
        case .nb: return "nb"
        case .lt: return "lt"
        case .pt: return "pt"
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
        case (.nb, .nb): return true
        case (.lt, .lt): return true
        case (.pt, .pt): return true
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
        .nb,
        .lt,
        .pt,
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
    case selectedEvent
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
        case "SelectedEvent": self = .selectedEvent
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
        case .selectedEvent: return "SelectedEvent"
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
        case (.selectedEvent, .selectedEvent): return true
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
        .selectedEvent,
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

  public enum PaymentSourceType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
    public typealias RawValue = String
    case card
    /// Auto generated constant for unknown enum values
    case __unknown(RawValue)

    public init?(rawValue: RawValue) {
      switch rawValue {
        case "card": self = .card
        default: self = .__unknown(rawValue)
      }
    }

    public var rawValue: RawValue {
      switch self {
        case .card: return "card"
        case .__unknown(let value): return value
      }
    }

    public static func == (lhs: PaymentSourceType, rhs: PaymentSourceType) -> Bool {
      switch (lhs, rhs) {
        case (.card, .card): return true
        case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
        default: return false
      }
    }

    public static var allCases: [PaymentSourceType] {
      return [
        .card,
      ]
    }
  }
}
