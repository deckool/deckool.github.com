{-# LANGUAGE OverloadedStrings #-}

import           Prelude hiding (head, div)
import           Text.Blaze.Html5
import           Text.Blaze.Html5.Attributes hiding (title,style)
import           Text.Blaze.Html.Renderer.Utf8
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.ByteString.Char8 as D
import           Text.Discount
import           System.Directory


draw p = docTypeHtml $ do
    head $ do
        title "Decebal Popa resume"
        meta ! httpEquiv "Content-Type" ! content "text/html;charset=UTF-8"
        meta ! name "viewport" ! content "width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;"
        link ! rel "stylesheet" ! href "http://fonts.googleapis.com/css?family=Ubuntu:300,400,500,700,300italic,400italic,500italic,700italic" ! type_ "text/css" 
        link ! rel "stylesheet" ! href "load.css"
    body $ do
        (preEscapedToHtml p)

main = do
  md <- readFile "cv.md"
  let parsed = parseMarkdown compatOptions $ D.pack md
  C.writeFile "index.html" (renderHtml $ draw $ D.unpack parsed)
