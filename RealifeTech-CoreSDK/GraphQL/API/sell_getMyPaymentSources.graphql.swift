// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  final class GetMyPaymentSourcesQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getMyPaymentSources($pageSize: Int!, $page: Int! = 1) {
        getMyPaymentSources(page: $page, pageSize: $pageSize) {
          __typename
          edges {
            __typename
            ...paymentSourceDetails
          }
        }
      }
      """

    public let operationName: String = "getMyPaymentSources"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + PaymentSourceDetails.fragmentDefinition)
      document.append("\n" + CardDetails.fragmentDefinition)
      return document
    }

    public var pageSize: Int
    public var page: Int

    public init(pageSize: Int, page: Int) {
      self.pageSize = pageSize
      self.page = page
    }

    public var variables: GraphQLMap? {
      return ["pageSize": pageSize, "page": page]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("getMyPaymentSources", arguments: ["page": GraphQLVariable("page"), "pageSize": GraphQLVariable("pageSize")], type: .object(GetMyPaymentSource.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(getMyPaymentSources: GetMyPaymentSource? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "getMyPaymentSources": getMyPaymentSources.flatMap { (value: GetMyPaymentSource) -> ResultMap in value.resultMap }])
      }

      public var getMyPaymentSources: GetMyPaymentSource? {
        get {
          return (resultMap["getMyPaymentSources"] as? ResultMap).flatMap { GetMyPaymentSource(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "getMyPaymentSources")
        }
      }

      public struct GetMyPaymentSource: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PaymentSourceEdge"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "PaymentSourceEdge", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var edges: [Edge?]? {
          get {
            return (resultMap["edges"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Edge?] in value.map { (value: ResultMap?) -> Edge? in value.flatMap { (value: ResultMap) -> Edge in Edge(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, forKey: "edges")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PaymentSource"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(PaymentSourceDetails.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var paymentSourceDetails: PaymentSourceDetails {
              get {
                return PaymentSourceDetails(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }

  struct PaymentSourceDetails: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment paymentSourceDetails on PaymentSource {
        __typename
        id
        type
        default
        card {
          __typename
          ...cardDetails
        }
      }
      """

    public static let possibleTypes: [String] = ["PaymentSource"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("type", type: .nonNull(.scalar(PaymentSourceType.self))),
        GraphQLField("default", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("card", type: .object(Card.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, type: PaymentSourceType, `default`: Bool, card: Card? = nil) {
      self.init(unsafeResultMap: ["__typename": "PaymentSource", "id": id, "type": type, "default": `default`, "card": card.flatMap { (value: Card) -> ResultMap in value.resultMap }])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var id: GraphQLID {
      get {
        return resultMap["id"]! as! GraphQLID
      }
      set {
        resultMap.updateValue(newValue, forKey: "id")
      }
    }

    public var type: PaymentSourceType {
      get {
        return resultMap["type"]! as! PaymentSourceType
      }
      set {
        resultMap.updateValue(newValue, forKey: "type")
      }
    }

    public var `default`: Bool {
      get {
        return resultMap["default"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "default")
      }
    }

    public var card: Card? {
      get {
        return (resultMap["card"] as? ResultMap).flatMap { Card(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "card")
      }
    }

    public struct Card: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Card"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(CardDetails.self),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(brand: String, numberToken: String, expMonth: String, expYear: String, last4: String, fingerprint: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Card", "brand": brand, "numberToken": numberToken, "expMonth": expMonth, "expYear": expYear, "last4": last4, "fingerprint": fingerprint])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var cardDetails: CardDetails {
          get {
            return CardDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }

  struct CardDetails: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment cardDetails on Card {
        __typename
        brand
        numberToken
        expMonth
        expYear
        last4
        fingerprint
      }
      """

    public static let possibleTypes: [String] = ["Card"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("brand", type: .nonNull(.scalar(String.self))),
        GraphQLField("numberToken", type: .nonNull(.scalar(String.self))),
        GraphQLField("expMonth", type: .nonNull(.scalar(String.self))),
        GraphQLField("expYear", type: .nonNull(.scalar(String.self))),
        GraphQLField("last4", type: .nonNull(.scalar(String.self))),
        GraphQLField("fingerprint", type: .scalar(String.self)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(brand: String, numberToken: String, expMonth: String, expYear: String, last4: String, fingerprint: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Card", "brand": brand, "numberToken": numberToken, "expMonth": expMonth, "expYear": expYear, "last4": last4, "fingerprint": fingerprint])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    public var brand: String {
      get {
        return resultMap["brand"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "brand")
      }
    }

    public var numberToken: String {
      get {
        return resultMap["numberToken"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "numberToken")
      }
    }

    public var expMonth: String {
      get {
        return resultMap["expMonth"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "expMonth")
      }
    }

    public var expYear: String {
      get {
        return resultMap["expYear"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "expYear")
      }
    }

    public var last4: String {
      get {
        return resultMap["last4"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "last4")
      }
    }

    public var fingerprint: String? {
      get {
        return resultMap["fingerprint"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "fingerprint")
      }
    }
  }
}
