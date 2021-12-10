function line-checkcorruption($Line){
    $badchars = $null
    $continue = $true
    $OriginalLine = $Line
    While($continue -eq $true){
        if($Line -match '\[]|{}|\(\)|<>'){
            $Line = $Line -replace '\[]|{}|\(\)|<>',''
            $Matches.Clear()
        }elseif($Line -match '[[{(<][>})\]]'){
            ForEach($m in $Matches){
                $badchars += ([string]$m.Values).Substring(1,1)
            }
            $Line = $Line -replace '[[{(<][>})\]]',''
            $Matches.Clear()
        }else{
            $continue = $false
        }
    }
    if($badchars -eq $null){
        return 'No bad chars found'
    }else{
        return $badchars
    }
}

function line-formulatecompletionscore($line){
    $score = 0
    $continue = $true
    While($continue -eq $true){
        if($Line -match '\[]|{}|\(\)|<>'){
            $Line = $Line -replace '\[]|{}|\(\)|<>',''
        }else{
            For($i = $Line.Length-1;$i -ge 0; $i--){
                if($Line.Substring($i,1) -eq '('){
                    $score = $score*5
                    $score += 1
                }elseif($Line.Substring($i,1) -eq '['){
                    $score = $score*5
                    $score += 2
                }elseif($Line.Substring($i,1) -eq '{'){
                    $score = $score*5
                    $score += 3
                }elseif($Line.Substring($i,1) -eq '<'){
                    $score = $score*5
                    $score += 4
                }
            }
            $continue = $false
        }
    }
    return $score
}

function line-formulatebadsyntaxscore($badchars){
    $score = 0
    ForEach($char in $badchars -split ''){
        if($char -eq ')'){
            $score += 3
        }elseif($char -eq ']'){
            $score += 57
        }elseif($char -eq '}'){
            $score += 1197
        }elseif($char -eq '>'){
            $score += 25137
        }
    }
    return $score
}

$FilePath = 'C:\Scripts\AoC\2021\Day10\day10_2.txt'
$puzzleinput = gc $FilePath
[string]$badchars = $null
$validlines = @()
$validlinescores = @()
$puzzleinput | % {if(($corruption = line-checkcorruption -Line $_) -match '[(){}[\]<>]'){$badchars += $corruption}else{$validlines += $_}}
Write-Host "Part One:" $(line-formulatebadsyntaxscore -badchars $badchars)
$validlines | % {$validlinescores += line-formulatecompletionscore -line $_}
Write-Host "Part Two:" $($validlinescores | sort | select -Index $([math]::Floor($validlinescores.Count/2)))