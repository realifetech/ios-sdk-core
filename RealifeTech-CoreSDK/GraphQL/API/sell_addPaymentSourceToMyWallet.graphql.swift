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
          ...paymentSourceDetails
        }
      }
      """

    public let operationName: String = "addPaymentSourceToMyWallet"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + PaymentSourceDetails.fragmentDefinition)
      document.append("\n" + CardDetails.fragmentDefinition)
      return document
    }

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
