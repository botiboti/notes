import Browser exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model = List String

type Msg =
  Add String

init : Model
init =
  []

update : Msg -> Model -> Model
update msg model =
  case msg of
    Add text ->
      model ++  [text]

view : Model -> Html Msg
view model =
  div []
     [
     div []  (List.map (\txt -> text txt) model)
     ]
