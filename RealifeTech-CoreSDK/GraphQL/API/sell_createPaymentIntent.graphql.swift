// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  final class CreatePaymentIntentMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      mutation createPaymentIntent($input: PaymentIntentInput!) {
        createPaymentIntent(input: $input) {
          __typename
          id
          orderType
          orderId
          status
          paymentSource {
            __typename
            id
            type
            default
            card {
              __typename
              brand
              numberToken
              expYear
              expMonth
              last4
              fingerprint
            }
          }
          amount
          currency
          livemode
          cancellationReason
          savePaymentSource
          nextAction {
            __typename
            type
            url
          }
        }
      }
      """

    public let operationName: String = "createPaymentIntent"

    public var input: PaymentIntentInput

    public init(input: PaymentIntentInput) {
      self.input = input
    }

    public var variables: GraphQLMap? {
      return ["input": input]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("createPaymentIntent", arguments: ["input": GraphQLVariable("input")], type: .object(CreatePaymentIntent.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(createPaymentIntent: CreatePaymentIntent? = nil) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "createPaymentIntent": createPaymentIntent.flatMap { (value: CreatePaymentIntent) -> ResultMap in value.resultMap }])
      }

      public var createPaymentIntent: CreatePaymentIntent? {
        get {
          return (resultMap["createPaymentIntent"] as? ResultMap).flatMap { CreatePaymentIntent(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "createPaymentIntent")
        }
      }

      public struct CreatePaymentIntent: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PaymentIntent"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("orderType", type: .nonNull(.scalar(OrderType.self))),
            GraphQLField("orderId", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("status", type: .nonNull(.scalar(PaymentStatus.self))),
            GraphQLField("paymentSource", type: .object(PaymentSource.selections)),
            GraphQLField("amount", type: .nonNull(.scalar(Int.self))),
            GraphQLField("currency", type: .nonNull(.scalar(String.self))),
            GraphQLField("livemode", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("cancellationReason", type: .scalar(CancellationReason.self)),
            GraphQLField("savePaymentSource", type: .scalar(Bool.self)),
            GraphQLField("nextAction", type: .object(NextAction.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, orderType: OrderType, orderId: GraphQLID, status: PaymentStatus, paymentSource: PaymentSource? = nil, amount: Int, currency: String, livemode: Bool, cancellationReason: CancellationReason? = nil, savePaymentSource: Bool? = nil, nextAction: NextAction? = nil) {
          self.init(unsafeResultMap: ["__typename": "PaymentIntent", "id": id, "orderType": orderType, "orderId": orderId, "status": status, "paymentSource": paymentSource.flatMap { (value: PaymentSource) -> ResultMap in value.resultMap }, "amount": amount, "currency": currency, "livemode": livemode, "cancellationReason": cancellationReason, "savePaymentSource": savePaymentSource, "nextAction": nextAction.flatMap { (value: NextAction) -> ResultMap in value.resultMap }])
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

        public var orderType: OrderType {
          get {
            return resultMap["orderType"]! as! OrderType
          }
          set {
            resultMap.updateValue(newValue, forKey: "orderType")
          }
        }

        public var orderId: GraphQLID {
          get {
            return resultMap["orderId"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "orderId")
          }
        }

        public var status: PaymentStatus {
          get {
            return resultMap["status"]! as! PaymentStatus
          }
          set {
            resultMap.updateValue(newValue, forKey: "status")
          }
        }

        public var paymentSource: PaymentSource? {
          get {
            return (resultMap["paymentSource"] as? ResultMap).flatMap { PaymentSource(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "paymentSource")
          }
        }

        public var amount: Int {
          get {
            return resultMap["amount"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "amount")
          }
        }

        public var currency: String {
          get {
            return resultMap["currency"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "currency")
          }
        }

        public var livemode: Bool {
          get {
            return resultMap["livemode"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "livemode")
          }
        }

        public var cancellationReason: CancellationReason? {
          get {
            return resultMap["cancellationReason"] as? CancellationReason
          }
          set {
            resultMap.updateValue(newValue, forKey: "cancellationReason")
          }
        }

        public var savePaymentSource: Bool? {
          get {
            return resultMap["savePaymentSource"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "savePaymentSource")
          }
        }

        public var nextAction: NextAction? {
          get {
            return (resultMap["nextAction"] as? ResultMap).flatMap { NextAction(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "nextAction")
          }
        }

        public struct PaymentSource: GraphQLSelectionSet {
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
                GraphQLField("brand", type: .nonNull(.scalar(String.self))),
                GraphQLField("numberToken", type: .nonNull(.scalar(String.self))),
                GraphQLField("expYear", type: .nonNull(.scalar(String.self))),
                GraphQLField("expMonth", type: .nonNull(.scalar(String.self))),
                GraphQLField("last4", type: .nonNull(.scalar(String.self))),
                GraphQLField("fingerprint", type: .scalar(String.self)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(brand: String, numberToken: String, expYear: String, expMonth: String, last4: String, fingerprint: String? = nil) {
              self.init(unsafeResultMap: ["__typename": "Card", "brand": brand, "numberToken": numberToken, "expYear": expYear, "expMonth": expMonth, "last4": last4, "fingerprint": fingerprint])
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

            public var expYear: String {
              get {
                return resultMap["expYear"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "expYear")
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

        public struct NextAction: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["PaymentAction"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("type", type: .nonNull(.scalar(PaymentActionType.self))),
              GraphQLField("url", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(type: PaymentActionType, url: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "PaymentAction", "type": type, "url": url])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var type: PaymentActionType {
            get {
              return resultMap["type"]! as! PaymentActionType
            }
            set {
              resultMap.updateValue(newValue, forKey: "type")
            }
          }

          public var url: String? {
            get {
              return resultMap["url"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "url")
            }
          }
        }
      }
    }
  }
}
