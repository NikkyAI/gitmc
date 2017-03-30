using System;
using System.IO;

namespace GitMC.Lib
{
    public static class Constants
    {
        public static readonly string MC_MODS_DIR   = "mods";
        public static readonly string MC_CONFIG_DIR = "config";
        
        public static readonly string PACK_CONFIG_FILE = "packconfig.yaml";
        public static readonly string PACK_BUILD_FILE  = "packbuild.json";
        
        public static string CachePath { get; } = Path.Combine(
            Environment.GetEnvironmentVariable("LocalAppData")
                ?? Environment.GetEnvironmentVariable("XDG_CACHE_HOME")
                ?? Path.Combine(Environment.GetEnvironmentVariable("HOME"), ".cache")
            , "gitMC");
        
        public static string ConfigPath { get; } = Path.Combine(
            Environment.GetEnvironmentVariable("AppData")
                ?? Environment.GetEnvironmentVariable("XDG_CONFIG_HOME")
                ?? Path.Combine(Environment.GetEnvironmentVariable("HOME"), ".config")
            , "gitMC");
    }
}
