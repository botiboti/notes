import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List exposing (..)
import List.Extra as LE

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model = List String

type Msg =
     Add String
  |  Edit String String
  |  Delete String

init : Model
init =
  []

update : Msg -> Model -> Model
update msg model =
  case msg of
    Add note ->
      model ++  [note]

    Edit old new ->
      LE.updateIf (\note -> note == old) (\note -> new) model

    Delete note ->
      LE.remove note model

{--
editNote : String -> String -> Model -> Model
editNote old new model =
  LE.updateIf (\note -> note == old) (\note -> new) model
-}

view : Model -> Html Msg
view model =
  div []
     [ div []  (List.map (\txt -> text txt) (update (Edit "kutya" "cica") model))
     , tests
     ]

tests : Html Msg
tests =
  let
    ok = div [ style "color" "green" ] [ text "OK" ]
    err = div [ style "color" "red" ] [ text "Eh.." ]
    model = ["hello", "kutya", "haha"]
  in
      [ update (Add "p") model == ["hello", "kutya", "haha", "p"]
      , update (Edit "kutya" "cica") model == ["hello", "cica", "haha"]
      , update (Delete "haha") model == ["hello", "kutya"]]
        |> List.map (\bool -> if bool then ok else err)
        |> div []
