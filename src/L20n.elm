module L20n
  ( ready
  , view
  , id
  , args
  )
  where
{-| Elm bindings to the l20n.js localisation framework.
# Signals
@docs ready
# Main Function
@docs view
# Html Attributes
@docs id, args
-}

import Native.L20n

import Html
import Html.Attributes as Attributes
import Signal exposing (Signal)
import Maybe exposing (..)
import List


{-| Triggers when L20n and document.l10n are available. -}
ready : Signal ()
ready =
  Native.L20n.ready


{-| Adds a link to your manifest.
    Returns a tuple containing the default and a list of all languages available.
    Optionally you can force a language to use.

        (default, all) = view "locale/manifest.json"
-}
view : String -> Maybe String -> Maybe (String, List String)
view manifest language =
  let (default, all) =
        Native.L20n.view
          { url = manifest
          , language = Maybe.withDefault "" language
          }
  in
    if default == ""
      then Nothing
      else Just (default, all)


{-| Create a localization identifier for an Html Node.

        id "Hello"
-}
id : String -> Html.Attribute
id identifier =
  Attributes.attribute
    "data-l10n-id"
    identifier


{-| Specify arguments for an Html node containing a localization identifier.

        args
          [ ("Username", "Mary")
          , ("Gender", "Feminine")
          ]
-}
args : List (String, String) -> Html.Attribute
args arguments =
  Attributes.attribute
    "data-l10n-args"
    ( "{" ++ (flattenArguments arguments) ++ "}" )


{-| Internal helper functions used for the exposed args function. -}

flattenArguments : List (String, String) -> String
flattenArguments pairList =
  case List.head pairList of
    Nothing ->
      ""

    Just pair ->
      let head = toString pair
      in
        case List.tail pairList of
          Nothing ->
            head

          Just tail ->
            List.foldl
              (\pair aux ->
                aux ++ "," ++ (toString pair))
              head
              tail

toString : (String, String) -> String
toString (key, value) =
  "'" ++ key ++ "':'" ++ value ++ "'"