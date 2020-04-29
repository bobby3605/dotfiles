Config {
       font = "xft:Fira Code:size=11:antialias=true"
       , additionalFonts = [ "xft:FontAwesome:size=11" ]
       , allDesktops = True
       , bgColor = "#282c34"
       , fgColor = "#bbc2cf"
       , position = TopW L 100
       , commands = [ Run Cpu [ "--template", "<icon=/home/bobby/Downloads/cpu.xpm/> <total>%"
                              , "--Low","3"
                              , "--High","50"
                              , "--low","#bbc2cf"
                              , "--normal","#bbc2cf"
                              , "--high","#fb4934"] 50

                    , Run Memory ["-t","<icon=/home/bobby/Downloads/ram.xpm/> <usedratio>%"
                                 ,"-H","80"
                                 ,"-L","10"
                                 ,"-l","#bbc2cf"
                                 ,"-n","#bbc2cf"
                                 ,"-h","#fb4934"] 50

                    , Run Date "<fc=#ECBE7B><fn=1></fn></fc> %a %b %_d %l:%M%p" "date" 300
                    , Run DynNetwork ["-t","<fc=#4db5bd><fn=1></fn></fc> <rx>, <fc=#c678dd><fn=1></fn></fc> <tx>"
                                     ,"-H","200"
                                     ,"-L","10"
                                     ,"-h","#bbc2cf"
                                     ,"-l","#bbc2cf"
                                     ,"-n","#bbc2cf"] 50

                    , Run Com "/home/bobby/scripts/temp" [] "temp" 50
                    , Run StdinReader
                    --, Run PipeReader "/home/bobby/.vol" "vol"
                    , Run Alsa "default" "Master" []
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{%alsa:default:Master% | %cpu% | <icon=/home/bobby/Downloads/weather.xpm/> %temp% | %memory% | %dynnetwork% | %date% "   -- #69DFFA
       }
