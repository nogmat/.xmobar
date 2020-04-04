Config { 

   -- appearance
     font =         "xft:Bitstream Vera Sans Mono:size=9:bold:antialias=true"
   , bgColor =      "black"
   , fgColor =      "#646464"
   , position =     Top
   , border =       BottomB
   , borderColor =  "#646464"

   -- layout
   , sepChar =  "%"   -- delineator between plugin names and straight text
   , alignSep = "}{"  -- separator between left-right alignment
   , template = " %UnsafeStdinReader% }{ %default:Master% | %battery% | %coretemp% | %multicpu% | %date% %wlp3s0wi% "

   -- general behavior
   , lowerOnStart =     True    -- send to bottom of window stack on start
   , hideOnStart =      False   -- start with window unmapped (hidden)
   , allDesktops =      True    -- show on all desktops
   , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
   , pickBroadest =     False   -- choose widest display (multi-monitor)
   , persistent =       True    -- enable/disable hiding (True = disabled)

   -- plugins
   --   Numbers can be automatically colored according to their value. xmobar
   --   decides color based on a three-tier/two-cutoff system, controlled by
   --   command options:
   --     --Low sets the low cutoff
   --     --High sets the high cutoff
   --
   --     --low sets the color below --Low cutoff
   --     --normal sets the color between --Low and --High cutoffs
   --     --High sets the color above --High cutoff
   --
   --   The --template option controls how the plugin is displayed. Text
   --   color can be set by enclosing in <fc></fc> tags. For more details
   --   see http://projects.haskell.org/xmobar/#system-monitor-plugins.
   , commands = 

   --      -- cpu activity monitor
        [ Run MultiCpu       [ "--template" , "<fc=#FF0000>Cpu:</fc> <total0>#<total1>#<total2>#<total3>#<total4>#<total5>#<total6>#<total7>"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "red"
                             ] 10

        , Run Volume "default" "Master" [ "--template", "<fc=#00FF00>Vol:</fc> <volume>% <status>"
                                        , "--Low"     , "50"
                                        , "--High"    , "100"
                                        , "--low"     , "darkgreen"
                                        , "--normal"  , "darkblue"
                                        , "--high"    , "red"
                                        ] 10
        , Run Wireless "wlp3s0" [ "--template", "<essid>" ] 10
   --      -- cpu core temperature monitor
        , Run CoreTemp       [ "--template" , "<fc=#FFA500>Temp:</fc> <core0>#<core1>-<core2>-<core3>-<core4>"
                             , "--Low"      , "70"        -- units: °C
                             , "--High"     , "80"        -- units: °C
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 50
                          
        -- memory usage monitor
        , Run Memory         [ "--template" ,"Mem: <usedratio>%"
                             , "--Low"      , "20"        -- units: %
                             , "--High"     , "90"        -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10

   --      -- battery monitor
        , Run Battery        [ "--template" , "<fc=#0000FF>Batt:</fc> <acstatus>"
                             , "--Low"      , "10"        -- units: %
                             , "--High"     , "80"        -- units: %
                             , "--low"      , "darkred"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkgreen"

                             , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc>"
                             ] 50

        -- , Run Alsa "alsamixer" "Master" []
        -- , Run Volume "default" "Master" [] 10
        -- time and date indicator 
        --   (%F = y-m-d date, %a = day of week, %T = h:m:s time)
        , Run Date           "<fc=#FFFF00>%F (%a) %T</fc>" "date" 10
        , Run UnsafeStdinReader
        ]
   }
