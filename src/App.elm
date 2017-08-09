module App exposing (..)

import Html exposing (Html, div, text, program)
import Html.Events exposing(onClick)

-- MODEL

type alias Card =
    String
type alias Deck =
    List Card
type alias CurrentCard =
    Maybe Card
type alias Game =
    {deck : Deck
    ,currentCard : CurrentCard
    }

game =
    Game ["1", "2", "3", "5", "8", "13", "21"] Nothing
init : ( Game , Cmd Msg )
init =
    ( game, Cmd.none )

-- MESSAGES


type Msg
    = NoOp
    | DrawCard Card
    | Discard

-- VIEW

card : Card -> Html Msg
card c =
    div [ onClick (DrawCard c) ]
        [ text c ]


deck : Deck -> Html Msg
deck d =
    div []
        (List.map card d)

selectedCard : Card -> Html Msg
selectedCard c =
    div [ onClick Discard ]
        [
         text "Selected",
         text c
        ]
view : Game -> Html Msg
view game =
    case game.currentCard of
        Nothing -> deck game.deck
        Just c -> selectedCard c

-- UPDATE


update : Msg -> Game -> ( Game, Cmd Msg )
update msg game =
    case msg of
        NoOp ->
            ( game, Cmd.none )
        DrawCard c ->
            ( Game game.deck (Just c), Cmd.none )
        Discard ->
            ( Game game.deck Nothing, Cmd.none )



-- SUBSCRIPTIONS
subscriptions : Game -> Sub Msg
subscriptions game =
    Sub.none

-- MAIN


main : Program Never Game Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
