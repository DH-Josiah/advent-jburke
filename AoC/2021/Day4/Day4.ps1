#class BingoCard {
#    [int]$RowNumcount
#    [int]$ColNumcount
#    hidden [hashtable]$RowNums
#    hidden [hashtable]$ColNums
#
#    BingoCard([int]$rc,[int]$cc){
#        $this.rowcount = $rc
#        $this.columncount = $cc
#    }
#
#    [void] AddRows([int]$rc,[hashtable]$r){
#        
#        For($i=0; $i -le $rc; $i++){
#            
#
#        }
#        $this.rows = $r
#    }
#}


$FilePath = 'C:\Scripts\AoC\2021\Day4\day4_2.txt'
function do-wincalc($winningNums,$BingoCard){
    $sum = 0
    $callcount = 0
    $output = New-Object psobject
    ForEach($num in $winningNums){
        $callcount++
        for($i = 0;$i -lt 5; $i++){
            for($x = 0;$x -lt 5; $x++){
                if($BingoCard[$x,$i] -eq $num){
                    $BingoCard[$x,$i] = "x"
                }
                for($y = 0;$y -lt 5; $y++){
                    [array]$Line = $null
                    for($z = 0;$z -lt 5; $z++){
                        $Line += $BingoCard[$z,$y]
                    }
                    if($Line -join '' -eq 'xxxxx'){
                        $BingoCard | where {$_ -ne 'x'} | % {[int]$Sum+=[int]$_}
                        $output | Add-Member NoteProperty -Name Score -Value $($sum*$num)
                        $output | Add-Member NoteProperty -Name CallCount -Value $callcount
                        return $output
                    }
                }
                for($y = 0;$y -lt 5; $y++){
                    [array]$Line = $null
                    for($z = 0;$z -lt 5; $z++){
                        $Line += $BingoCard[$y,$z]
                    }
                    if($Line -join '' -eq 'xxxxx'){
                        $BingoCard | where {$_ -ne 'x'} | % {[int]$Sum+=[int]$_}
                        $output | Add-Member NoteProperty -Name Score -Value $($sum*$num)
                        $output | Add-Member NoteProperty -Name CallCount -Value $callcount
                        return $output
                    }
                }
            }
        }
    }
}
function puzzle-solve($FilePath,$Part=1){
    $puzzleinput = gc $FilePath
    $DrawnNums = $puzzleinput[0] -split ','
    $Bingocardsraw = $puzzleinput[2..$puzzleinput.count]
    $BingoCard = New-Object 'object[,]' 5,5
    $RowNum = 0
    $obj = New-Object psobject
    $obj | Add-Member NoteProperty -Name Score -Value 0
    $obj | Add-Member NoteProperty -Name CallCount -Value 0
    ForEach($Line in $Bingocardsraw){
        if([string]::IsNullOrWhiteSpace($Line)){
            $newobj = do-wincalc -winningNums $DrawnNums -BingoCard $BingoCard
            if($part -eq 2){
                if($newobj.CallCount -gt $obj.CallCount -or $obj.CallCount -eq '0'){
                    $obj.Score = $newobj.Score
                    $obj.CallCount = $newobj.CallCount
                }
            }else{
                if($newobj.CallCount -lt $obj.CallCount -or $obj.CallCount -eq '0'){
                    $obj.Score = $newobj.Score
                    $obj.CallCount = $newobj.CallCount
                }
            }
            $BingoCard = New-Object 'object[,]' 5,5
            $RowNum = 0
        }else{
            $ColNum = 0
            ForEach($BingoNum in $Line -split ' '){
                if(!([string]::IsNullOrWhiteSpace($BingoNum))){
                    $BingoCard[$RowNum,$ColNum] = $BingoNum
                    $ColNum++
                }
            }
            if(!([string]::IsNullOrWhiteSpace($Line))){
                $RowNum++
            }
        }
    }

    return $obj
}

$test = puzzle-solve -FilePath $FilePath -Part 1
Write-Host 'Part One: '$test.Score
$test = puzzle-solve -FilePath $FilePath -Part 2
Write-Host 'Part Two: '$test.Score