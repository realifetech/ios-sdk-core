// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  struct ScreenTranslation: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment screenTranslation on ScreenTranslation {
        __typename
        language
        title
      }
      """

    public static let possibleTypes: [String] = ["ScreenTranslation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("language", type: .nonNull(.scalar(Language.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
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

    public var language: Language {
      get {
        return resultMap["language"]! as! Language
      }
      set {
        resultMap.updateValue(newValue, forKey: "language")
      }
    }

    public var title: String {
      get {
        return resultMap["title"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "title")
      }
    }
  }
}
