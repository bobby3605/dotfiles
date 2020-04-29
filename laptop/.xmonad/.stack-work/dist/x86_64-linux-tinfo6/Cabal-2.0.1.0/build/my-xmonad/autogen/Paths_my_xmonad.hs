{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_my_xmonad (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/bobby/.xmonad/.stack-work/install/x86_64-linux-tinfo6/4be24f7a31c8c51bab26637c3c142dff7bbf0f1015c02eedfa18962331ba8c8e/8.2.2/bin"
libdir     = "/home/bobby/.xmonad/.stack-work/install/x86_64-linux-tinfo6/4be24f7a31c8c51bab26637c3c142dff7bbf0f1015c02eedfa18962331ba8c8e/8.2.2/lib/x86_64-linux-ghc-8.2.2/my-xmonad-0.1.0.0-HSt1JTiesIj8JKQ1GIE8Dd-my-xmonad"
dynlibdir  = "/home/bobby/.xmonad/.stack-work/install/x86_64-linux-tinfo6/4be24f7a31c8c51bab26637c3c142dff7bbf0f1015c02eedfa18962331ba8c8e/8.2.2/lib/x86_64-linux-ghc-8.2.2"
datadir    = "/home/bobby/.xmonad/.stack-work/install/x86_64-linux-tinfo6/4be24f7a31c8c51bab26637c3c142dff7bbf0f1015c02eedfa18962331ba8c8e/8.2.2/share/x86_64-linux-ghc-8.2.2/my-xmonad-0.1.0.0"
libexecdir = "/home/bobby/.xmonad/.stack-work/install/x86_64-linux-tinfo6/4be24f7a31c8c51bab26637c3c142dff7bbf0f1015c02eedfa18962331ba8c8e/8.2.2/libexec/x86_64-linux-ghc-8.2.2/my-xmonad-0.1.0.0"
sysconfdir = "/home/bobby/.xmonad/.stack-work/install/x86_64-linux-tinfo6/4be24f7a31c8c51bab26637c3c142dff7bbf0f1015c02eedfa18962331ba8c8e/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "my_xmonad_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "my_xmonad_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "my_xmonad_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "my_xmonad_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "my_xmonad_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "my_xmonad_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
