import qualified Scripting.Lua as Lua
import Data.Word
import Com.DiagClient(sendData,diagPayload,DiagConfig(MkDiagConfig))
import Script.LoggingFramework
import Util.Encoding
import Data.Char
import Control.Concurrent(threadDelay)
import Numeric
import Foreign.C
import Foreign.Ptr
import Control.Monad

dofile :: Lua.LuaState -> String -> IO Int
dofile s name = do
    res <- Lua.loadfile s name
    Lua.pcall s 0 0 0
    return res

dostring :: Lua.LuaState -> (Int,Int) -> String -> IO Int
dostring s (params,returns) str = do
    res <- Lua.loadstring s str ""
    Lua.pcall s 0 params returns
    return res

main = do
    s <- Lua.newstate
    Lua.openlibs s
 
    Lua.registerhsfunction s "send" hsSend
    Lua.registerhsfunction s "sleep" hsSleep
    Lua.registerhsfunction s "showMapping" hsLoggingShow

    dofile s "script_send_diag.lua"

    -- dostring s (1,1) "return ip_address"
    -- ipPresent <- Lua.isnil s (-1)
    -- if ipPresent
    --   then print "no ip_address defined"
    --   else do
    --       ip <- Lua.tostring s (-1)
    --       print ip
    -- Lua.pop s 1
    -- d <- Lua.gettop s
    -- print $ "top: " ++ show d
    Lua.close s

string2hex ::  String -> Word8
string2hex = fst . head . readHex

hsSend :: String -> Int -> Int -> Int -> String -> IO String
hsSend ip2 src target timeout xs = do
    putStrLn $ "ip was:" ++ ip2 ++ " hsSend from " ++ show src ++ " to " ++ show target ++ " (timeout=" ++ show timeout ++ ")"
    let msgx = map (int2Word8 . ord) xs
    let conf = MkDiagConfig ip2 6801 (fromIntegral src) (fromIntegral target) False
    maybeResp <- sendData conf msgx
    let res =  maybe ("error occured! no response arrived")
                (\resp-> convertToString (diagPayload resp))
                maybeResp
    -- putStrLn $ "response in haskell to send back to lua was:" ++ res
    return res

convertToString :: [Word8] -> String
convertToString xs = map (chr . word8ToInt) xs

hsSleep :: Int -> IO ()
hsSleep n = threadDelay(1*1000*n)

hsLoggingShow :: IO ()
hsLoggingShow = showMapping

