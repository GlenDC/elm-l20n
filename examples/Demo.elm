module Demo where

import Html
import Html.Attributes as Attributes
import Maybe exposing (..)

import L20n

main =
  let (default, all) =
        L20n.view "locales/manifest.json" (Just "pl")
        |> withDefault ("?", ["?"])

      languageList =
        List.map
          (\language ->
            Html.li [] [ Html.text language ]
            )
          all
        |> Html.ul []
  in
    Html.div []
      [ Html.h1 [ L20n.id "title" ] []

      , Html.h2 [] [ Html.text "Demo Languages" ]
      , Html.h4 [] [ Html.text "Default" ]
      , Html.p [] [ Html.text default ]
      , Html.h4 [] [ Html.text "All" ]
      , languageList

      , Html.h2 [ L20n.id "hello" ] [ Html.text "Hallo, wereld!" ]
      , Html.p [ L20n.id "intro" ] []

      , Html.hr [] []
      , Html.p [ L20n.id "langNego" ] []

      , Html.small [ L20n.id "kthxbye" ] []
      ]