module App.Translations exposing (Language(..), TranslationId(..), translate, decodeLang)

type Language
  = English
  | French

type alias TranslationSet =
  { english : String
  , french : String
  }

type TranslationId
-- LANDING
  = Title
  | Cta
  | TryItFree
  | Signup
  | Login
  | SignupFree
  | WantToLearnMore
  | CheckOurFeatures

translate : Language -> TranslationId -> String
translate language translationId =
  let
    translationSet =
      case translationId of
        Title ->
          { english = "A great value proposition"
          , french = "Ma belle proposition de valeur"
          }
        Cta ->
          { english = "Join more than 14 million people who use Phoenix & Elm to grow their businesses on their terms."
          , french = "Rejoignez plus de 14 millions d'enthousiastes qui utilisent Phoenix & Elm au quotidien."
          }
        TryItFree ->
          { english = "Try it for free"
          , french = "Essayer gratuitement"
          }
        Signup ->
          { english = "Signup"
          , french = "S'inscrire"
          }
        Login ->
          { english = "Login"
          , french = "Se connecter"
          }
        SignupFree ->
          { english = "Sign Up Free"
          , french = "Inscrivez-vous"
          }
        WantToLearnMore ->
          { english = "Want to learn more ?"
          , french = "Plus d'infos ?"
          }
        CheckOurFeatures ->
          { english = "Check out our features"
          , french = "Découvrez nos fonctionnalités"
          }
  in
    case language of
      English ->
        .english translationSet
      French ->
        .french translationSet


decodeLang : Language -> String
decodeLang language =
  case language of
    English -> "en"
    French -> "fr"
