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
      editNote old new model

    Delete note ->
      delete note model

{--}
editNote : String -> String -> Model -> Model
editNote old new model =
  case LE.elemIndex old model of
    Just i ->
      LE.updateAt i (\note -> new) model

    _ -> model
--}

delete : String -> Model -> Model
delete note model =
  case LE.elemIndex note model of
    Just i ->
      LE.removeAt i model

    _ -> model

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
