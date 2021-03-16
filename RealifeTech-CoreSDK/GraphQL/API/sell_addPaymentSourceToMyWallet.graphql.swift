// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  final class AddPaymentSourceToMyWalletMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      mutation addPaymentSourceToMyWallet($input: PaymentSourceInput!) {
        addPaymentSourceToMyWallet(input: $input) {
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
      }
      """

    public let operationName: String = "addPaymentSourceToMyWallet"

    public var input: PaymentSourceInput

    public init(input: PaymentSourceInput) {
      self.input = input
    }

    public var variables: GraphQLMap? {
      return ["input": input]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("addPaymentSourceToMyWallet", arguments: ["input": GraphQLVariable("input")], type: .object(AddPaymentSourceToMyWallet.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(addPaymentSourceToMyWallet: AddPaymentSourceToMyWallet? = nil) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "addPaymentSourceToMyWallet": addPaymentSourceToMyWallet.flatMap { (value: AddPaymentSourceToMyWallet) -> ResultMap in value.resultMap }])
      }

      public var addPaymentSourceToMyWallet: AddPaymentSourceToMyWallet? {
        get {
          return (resultMap["addPaymentSourceToMyWallet"] as? ResultMap).flatMap { AddPaymentSourceToMyWallet(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "addPaymentSourceToMyWallet")
        }
      }

      public struct AddPaymentSourceToMyWallet: GraphQLSelectionSet {
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
    }
  }
}
