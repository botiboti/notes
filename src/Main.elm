import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List exposing (..)
import List.Extra as LE

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model =
  {
    input : String,
    notes : List String
  }

type Msg =
     Submit
  |  Update String
  |  Edit String String
  |  Delete String

init : Model
init =
  {
    input = ""
  , notes = []
  }

update : Msg -> Model -> Model
update msg model =
  case msg of
    Submit ->
      {
        input = ""
        , notes = [model.input] ++ model.notes
      }

    Update note ->
      { model | input = note }

    _ ->
      model


{--
    Edit old new ->
      editNote old new model

    Delete note ->
      delete note model
--}

addNote : String -> Model -> Model
addNote note model =
    { model | input = note }

{--
editNote : String -> String -> Model -> Model
editNote old new model =
  case LE.elemIndex old model of
    Just i ->
      LE.updateAt i (\note -> new) model


    _ -> model
--}

{--
delete : String -> Model -> Model
delete note model =
  case LE.elemIndex note model of
    Just i ->
      LE.removeAt i model

    _ -> model
--}

view : Model -> Html Msg
view model =
  div [] <|
     [ input [type_ "text", placeholder "Note", value <| model.input, onInput Update] []
     , button [onClick Submit] [text "Submit"]
     , div []  (List.map (\txt -> div [] [text txt])  model.notes)
     ]
     ++ tests

{--}
tests : List (Html Msg)
tests =
  let
    ok = div [ style "color" "green" ] [ text "OK" ]
    err = div [ style "color" "red" ] [ text "Eh.." ]
    model = { input = "egy", notes = ["ketto", "harom"] }
  in
      [ update Submit model == { input = "", notes = ["egy", "ketto", "harom"] }
      ]
        |> List.map (\bool -> if bool then ok else err)
--}
