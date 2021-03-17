// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  final class GetScreenByScreenTypeQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getScreenByScreenType($type: ScreenType!) {
        getScreenByScreenType(type: $type) {
          __typename
          translations {
            __typename
            ...screenTranslation
          }
        }
      }
      """

    public let operationName: String = "getScreenByScreenType"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + ScreenTranslation.fragmentDefinition)
      return document
    }

    public var type: ScreenType

    public init(type: ScreenType) {
      self.type = type
    }

    public var variables: GraphQLMap? {
      return ["type": type]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("getScreenByScreenType", arguments: ["type": GraphQLVariable("type")], type: .object(GetScreenByScreenType.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(getScreenByScreenType: GetScreenByScreenType? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "getScreenByScreenType": getScreenByScreenType.flatMap { (value: GetScreenByScreenType) -> ResultMap in value.resultMap }])
      }

      public var getScreenByScreenType: GetScreenByScreenType? {
        get {
          return (resultMap["getScreenByScreenType"] as? ResultMap).flatMap { GetScreenByScreenType(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "getScreenByScreenType")
        }
      }

      public struct GetScreenByScreenType: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Screen"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("translations", type: .nonNull(.list(.nonNull(.object(Translation.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(translations: [Translation]) {
          self.init(unsafeResultMap: ["__typename": "Screen", "translations": translations.map { (value: Translation) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var translations: [Translation] {
          get {
            return (resultMap["translations"] as! [ResultMap]).map { (value: ResultMap) -> Translation in Translation(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: Translation) -> ResultMap in value.resultMap }, forKey: "translations")
          }
        }

        public struct Translation: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["ScreenTranslation"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(ScreenTranslation.self),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(language: Language, title: String) {
            self.init(unsafeResultMap: ["__typename": "ScreenTranslation", "language": language, "title": title])
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

            public var screenTranslation: ScreenTranslation {
              get {
                return ScreenTranslation(unsafeResultMap: resultMap)
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
}
