// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// ApolloType namespace
public extension ApolloType {
  final class GetWidgetsByScreenTypeQuery: GraphQLQuery {
    /// The raw GraphQL definition of this operation.
    public let operationDefinition: String =
      """
      query getWidgetsByScreenType($type: ScreenType!, $pageSize: Int!, $page: Int = 1) {
        getWidgetsByScreenType(type: $type, pageSize: $pageSize, page: $page) {
          __typename
          edges {
            __typename
            ...widget
          }
          nextPage
        }
      }
      """

    public let operationName: String = "getWidgetsByScreenType"

    public var queryDocument: String {
      var document: String = operationDefinition
      document.append("\n" + Widget.fragmentDefinition)
      document.append("\n" + WidgetTranslation.fragmentDefinition)
      return document
    }

    public var type: ScreenType
    public var pageSize: Int
    public var page: Int?

    public init(type: ScreenType, pageSize: Int, page: Int? = nil) {
      self.type = type
      self.pageSize = pageSize
      self.page = page
    }

    public var variables: GraphQLMap? {
      return ["type": type, "pageSize": pageSize, "page": page]
    }

    public struct Data: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Query"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("getWidgetsByScreenType", arguments: ["type": GraphQLVariable("type"), "pageSize": GraphQLVariable("pageSize"), "page": GraphQLVariable("page")], type: .object(GetWidgetsByScreenType.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(getWidgetsByScreenType: GetWidgetsByScreenType? = nil) {
        self.init(unsafeResultMap: ["__typename": "Query", "getWidgetsByScreenType": getWidgetsByScreenType.flatMap { (value: GetWidgetsByScreenType) -> ResultMap in value.resultMap }])
      }

      public var getWidgetsByScreenType: GetWidgetsByScreenType? {
        get {
          return (resultMap["getWidgetsByScreenType"] as? ResultMap).flatMap { GetWidgetsByScreenType(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "getWidgetsByScreenType")
        }
      }

      public struct GetWidgetsByScreenType: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["WidgetEdge"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("edges", type: .list(.object(Edge.selections))),
            GraphQLField("nextPage", type: .scalar(Int.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(edges: [Edge?]? = nil, nextPage: Int? = nil) {
          self.init(unsafeResultMap: ["__typename": "WidgetEdge", "edges": edges.flatMap { (value: [Edge?]) -> [ResultMap?] in value.map { (value: Edge?) -> ResultMap? in value.flatMap { (value: Edge) -> ResultMap in value.resultMap } } }, "nextPage": nextPage])
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

        public var nextPage: Int? {
          get {
            return resultMap["nextPage"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "nextPage")
          }
        }

        public struct Edge: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Widget"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(Widget.self),
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

            public var widget: Widget {
              get {
                return Widget(unsafeResultMap: resultMap)
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
