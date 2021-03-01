// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  final class GetWebPageByTypeQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getWebPageByType($type: WebPageType) {
        getWebPageByType(type: $type) {
          __typename
          url
        }
      }
      """

    public let operationName: String = "getWebPageByType"

    public var type: WebPageType?

    public init(type: WebPageType? = nil) {
      self.type = type
    }

    public var variables: GraphQLMap? {
      return ["type": type]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("getWebPageByType", arguments: ["type": GraphQLVariable("type")], type: .object(GetWebPageByType.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(getWebPageByType: GetWebPageByType? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "getWebPageByType": getWebPageByType.flatMap { (value: GetWebPageByType) -> ResultMap in value.resultMap }])
      }

      public var getWebPageByType: GetWebPageByType? {
        get {
          return (resultMap["getWebPageByType"] as? ResultMap).flatMap { GetWebPageByType(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "getWebPageByType")
        }
      }

      public struct GetWebPageByType: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["WebPage"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String) {
          self.init(unsafeResultMap: ["__typename": "WebPage", "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var url: String {
          get {
            return resultMap["url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }
      }
    }
  }
}
