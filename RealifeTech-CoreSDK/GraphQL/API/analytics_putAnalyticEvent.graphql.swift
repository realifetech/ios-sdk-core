// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  final class PutAnalyticEventMutation: GraphQLMutation {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      mutation PutAnalyticEvent($input: AnalyticEvent!) {
        putAnalyticEvent(input: $input) {
          __typename
          success
          message
        }
      }
      """

    public let operationName: String = "PutAnalyticEvent"

    public var input: AnalyticEvent

    public init(input: AnalyticEvent) {
      self.input = input
    }

    public var variables: GraphQLMap? {
      return ["input": input]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Mutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("putAnalyticEvent", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(PutAnalyticEvent.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(putAnalyticEvent: PutAnalyticEvent) {
        self.init(unsafeResultMap: ["__typename": "Mutation", "putAnalyticEvent": putAnalyticEvent.resultMap])
      }

      public var putAnalyticEvent: PutAnalyticEvent {
        get {
          return PutAnalyticEvent(unsafeResultMap: resultMap["putAnalyticEvent"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "putAnalyticEvent")
        }
      }

      public struct PutAnalyticEvent: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["PutAnalyticEventResponse"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("message", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(success: Bool, message: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "PutAnalyticEventResponse", "success": success, "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var success: Bool {
          get {
            return resultMap["success"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "success")
          }
        }

        public var message: String? {
          get {
            return resultMap["message"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }
      }
    }
  }
}
