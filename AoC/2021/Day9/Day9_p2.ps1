$FilePath = 'C:\Scripts\AoC\2021\Day9\day9_2.txt'
$puzzleinput = gc $FilePath
$HeightMap = New-Object 'object[,,]' $($puzzleinput.count+2),$($Puzzleinput[0].Length+2),2
$LineNum = 1

For($i = 0; $i -lt ($puzzleinput[0] -split '').count; $i++){
    $HeightMap[0,$i,0] = 9
    $HeightMap[0,$i,1] = "H"
    $HeightMap[$($puzzleinput.count+1),$i,0] = 9
    $HeightMap[$($puzzleinput.count+1),$i,1] = "H"
}

ForEach($Line in $puzzleinput){
    $position = 1
    $HeightMap[$LineNum,$($Position-1),0] = 9
    $HeightMap[$LineNum,$($Position-1),1] = "H"
    ForEach($Num in $Line -split ''){
        if(!([string]::IsNullOrWhiteSpace($Num))){
            if($Num -eq 9){
                $HeightMap[$LineNum,$Position,0] = $Num
                $HeightMap[$LineNum,$Position,1] = "H"
                $position++
            }else{
                $HeightMap[$LineNum,$Position,0] = $Num
                $HeightMap[$LineNum,$Position,1] = "L"
                $position++
            }
        }
    }
    $HeightMap[$LineNum,$Position,0] = 9
    $HeightMap[$LineNum,$Position,1] = "H"
    $LineNum++
}

$pointscount = 0
$coords = @()
$basinvalues = @()

function calculate-validcoords($x,$y,$HeightMap){
    $Coords = @()
    if($HeightMap[$([int]$([int]$y-1)),$x,1] -ne "H" -and $HeightMap[$([int]$([int]$y-1)),$x,1] -ne $null){
        $Coords += "$([int]$([int]$y-1)),$x"
    }
    if($HeightMap[$([int]$([int]$y+1)),$x,1] -ne "H" -and $HeightMap[$([int]$([int]$y+1)),$x,1] -ne $null){
        $Coords += "$([int]$([int]$y+1)),$x"
    }
    if($HeightMap[$y,$([int]$([int]$x-1)),1] -ne "H" -and $HeightMap[$y,$([int]$([int]$x-1)),1] -ne $null){
        $Coords += "$y,$([int]$([int]$x-1))"
    }
    if($HeightMap[$y,$([int]$([int]$x+1)),1] -ne "H" -and $HeightMap[$y,$([int]$([int]$x+1)),1] -ne $null){
        $Coords += "$y,$([int]$([int]$x+1))"
    }
    return $Coords
}

For($i = 1; $i -lt $puzzleinput.Count+1; $i++){
    For($x = 1; $x -lt $puzzleinput[0].Length+1;$x++){
        if($HeightMap[$i,$x,1] -ne 'H'){
            $HeightMap[$i,$x,1] = "H"
            $pointscount++
            $Coords += calculate-validcoords -x $x -y $i -HeightMap $HeightMap
            while($Coords){
            $NewCoords = @()
                ForEach($Coord in $Coords){
                    $splitCoords = $Coord -split ','
                    if($HeightMap[$splitCoords[0],$splitCoords[1],1] -ne 'H'){
                        $HeightMap[$splitCoords[0],$splitCoords[1],1] = "H"
                        $pointscount++
                    }
                }
                ForEach($Coord in $Coords){
                    $splitCoords = $Coord -split ','
                    $NewCoords += calculate-validcoords -x $splitCoords[1] -y $splitCoords[0] -HeightMap $HeightMap
                }
                $Coords = $NewCoords
            }
            $basinvalues += $pointscount
            $pointscount = 0
        }
    }
}

Write-Host 'Part 2 Answer: '$(($basinvalues | sort -Descending)[0]*($basinvalues | sort -Descending)[1]*($basinvalues | sort -Descending)[2])