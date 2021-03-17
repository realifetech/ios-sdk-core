// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  struct WidgetTranslation: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment widgetTranslation on WidgetVariationTranslation {
        __typename
        language
        title
      }
      """

    public static let possibleTypes: [String] = ["WidgetVariationTranslation"]

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
      self.init(unsafeResultMap: ["__typename": "WidgetVariationTranslation", "language": language, "title": title])
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

  struct Widget: GraphQLFragment {
    /// The raw GraphQL definition of this fragment.
    public static let fragmentDefinition: String =
      """
      fragment widget on Widget {
        __typename
        id
        style {
          __typename
          type
          size
          padded
        }
        viewAllUrl
        widgetType
        variation {
          __typename
          fetchType
          contentIds
          params {
            __typename
            key
            value
          }
          engagementParams {
            __typename
            key
            value
          }
          translations {
            __typename
            ...widgetTranslation
          }
        }
      }
      """

    public static let possibleTypes: [String] = ["Widget"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("style", type: .object(Style.selections)),
        GraphQLField("viewAllUrl", type: .scalar(String.self)),
        GraphQLField("widgetType", type: .scalar(WidgetType.self)),
        GraphQLField("variation", type: .object(Variation.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, style: Style? = nil, viewAllUrl: String? = nil, widgetType: WidgetType? = nil, variation: Variation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Widget", "id": id, "style": style.flatMap { (value: Style) -> ResultMap in value.resultMap }, "viewAllUrl": viewAllUrl, "widgetType": widgetType, "variation": variation.flatMap { (value: Variation) -> ResultMap in value.resultMap }])
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

    public var style: Style? {
      get {
        return (resultMap["style"] as? ResultMap).flatMap { Style(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "style")
      }
    }

    public var viewAllUrl: String? {
      get {
        return resultMap["viewAllUrl"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "viewAllUrl")
      }
    }

    public var widgetType: WidgetType? {
      get {
        return resultMap["widgetType"] as? WidgetType
      }
      set {
        resultMap.updateValue(newValue, forKey: "widgetType")
      }
    }

    public var variation: Variation? {
      get {
        return (resultMap["variation"] as? ResultMap).flatMap { Variation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "variation")
      }
    }

    public struct Style: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Style"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("type", type: .scalar(StyleType.self)),
          GraphQLField("size", type: .scalar(StyleSize.self)),
          GraphQLField("padded", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(type: StyleType? = nil, size: StyleSize? = nil, padded: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "Style", "type": type, "size": size, "padded": padded])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var type: StyleType? {
        get {
          return resultMap["type"] as? StyleType
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var size: StyleSize? {
        get {
          return resultMap["size"] as? StyleSize
        }
        set {
          resultMap.updateValue(newValue, forKey: "size")
        }
      }

      public var padded: Bool? {
        get {
          return resultMap["padded"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "padded")
        }
      }
    }

    public struct Variation: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["WidgetVariation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("fetchType", type: .scalar(WidgetFetchType.self)),
          GraphQLField("contentIds", type: .list(.scalar(GraphQLID.self))),
          GraphQLField("params", type: .list(.object(Param.selections))),
          GraphQLField("engagementParams", type: .list(.object(EngagementParam.selections))),
          GraphQLField("translations", type: .list(.object(Translation.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(fetchType: WidgetFetchType? = nil, contentIds: [GraphQLID?]? = nil, params: [Param?]? = nil, engagementParams: [EngagementParam?]? = nil, translations: [Translation?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "WidgetVariation", "fetchType": fetchType, "contentIds": contentIds, "params": params.flatMap { (value: [Param?]) -> [ResultMap?] in value.map { (value: Param?) -> ResultMap? in value.flatMap { (value: Param) -> ResultMap in value.resultMap } } }, "engagementParams": engagementParams.flatMap { (value: [EngagementParam?]) -> [ResultMap?] in value.map { (value: EngagementParam?) -> ResultMap? in value.flatMap { (value: EngagementParam) -> ResultMap in value.resultMap } } }, "translations": translations.flatMap { (value: [Translation?]) -> [ResultMap?] in value.map { (value: Translation?) -> ResultMap? in value.flatMap { (value: Translation) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fetchType: WidgetFetchType? {
        get {
          return resultMap["fetchType"] as? WidgetFetchType
        }
        set {
          resultMap.updateValue(newValue, forKey: "fetchType")
        }
      }

      public var contentIds: [GraphQLID?]? {
        get {
          return resultMap["contentIds"] as? [GraphQLID?]
        }
        set {
          resultMap.updateValue(newValue, forKey: "contentIds")
        }
      }

      public var params: [Param?]? {
        get {
          return (resultMap["params"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Param?] in value.map { (value: ResultMap?) -> Param? in value.flatMap { (value: ResultMap) -> Param in Param(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Param?]) -> [ResultMap?] in value.map { (value: Param?) -> ResultMap? in value.flatMap { (value: Param) -> ResultMap in value.resultMap } } }, forKey: "params")
        }
      }

      public var engagementParams: [EngagementParam?]? {
        get {
          return (resultMap["engagementParams"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [EngagementParam?] in value.map { (value: ResultMap?) -> EngagementParam? in value.flatMap { (value: ResultMap) -> EngagementParam in EngagementParam(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [EngagementParam?]) -> [ResultMap?] in value.map { (value: EngagementParam?) -> ResultMap? in value.flatMap { (value: EngagementParam) -> ResultMap in value.resultMap } } }, forKey: "engagementParams")
        }
      }

      public var translations: [Translation?]? {
        get {
          return (resultMap["translations"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Translation?] in value.map { (value: ResultMap?) -> Translation? in value.flatMap { (value: ResultMap) -> Translation in Translation(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Translation?]) -> [ResultMap?] in value.map { (value: Translation?) -> ResultMap? in value.flatMap { (value: Translation) -> ResultMap in value.resultMap } } }, forKey: "translations")
        }
      }

      public struct Param: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["WidgetParam"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("key", type: .nonNull(.scalar(String.self))),
            GraphQLField("value", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(key: String, value: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "WidgetParam", "key": key, "value": value])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var key: String {
          get {
            return resultMap["key"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "key")
          }
        }

        public var value: String? {
          get {
            return resultMap["value"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "value")
          }
        }
      }

      public struct EngagementParam: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["WidgetParam"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("key", type: .nonNull(.scalar(String.self))),
            GraphQLField("value", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(key: String, value: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "WidgetParam", "key": key, "value": value])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var key: String {
          get {
            return resultMap["key"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "key")
          }
        }

        public var value: String? {
          get {
            return resultMap["value"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "value")
          }
        }
      }

      public struct Translation: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["WidgetVariationTranslation"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(WidgetTranslation.self),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(language: Language, title: String) {
          self.init(unsafeResultMap: ["__typename": "WidgetVariationTranslation", "language": language, "title": title])
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

          public var widgetTranslation: WidgetTranslation {
            get {
              return WidgetTranslation(unsafeResultMap: resultMap)
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
