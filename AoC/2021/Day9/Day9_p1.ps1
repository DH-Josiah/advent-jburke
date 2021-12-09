$FilePath = 'C:\Scripts\AoC\2021\Day9\day9_2.txt'
$puzzleinput = gc $FilePath
$HeightMap = New-Object 'object[,,]' $($puzzleinput.count+2),$($Puzzleinput[0].Length+2),2
$LineNum = 1

ForEach($Line in $puzzleinput){
    $position = 1
    ForEach($Num in $Line -split ''){
        if(!([string]::IsNullOrWhiteSpace($Num))){
            $HeightMap[$LineNum,$Position,0] = $Num
            $HeightMap[$LineNum,$Position,1] = $false
            $position++
        }
    }
    $LineNum++
}

$pointscount = 0

For($i = 1; $i -lt $puzzleinput.Count+1; $i++){
    For($x = 1; $x -lt $puzzleinput[0].Length+1;$x++){
        if($HeightMap[$i,$x,0] -lt $HeightMap[$($i-1),$x,0] -or $HeightMap[$($i-1),$x,0] -eq $null){
            $pointscount++
        }
        if($HeightMap[$i,$x,0] -lt $HeightMap[$($i+1),$x,0] -or $HeightMap[$($i+1),$x,0] -eq $null){
            $pointscount++
        }
        if($HeightMap[$i,$x,0] -lt $HeightMap[$i,$($x-1),0] -or $HeightMap[$i,$($x-1),0] -eq $null){
            $pointscount++
        }
        if($HeightMap[$i,$x,0] -lt $HeightMap[$i,$($x+1),0] -or $HeightMap[$i,$($x+1),0] -eq $null){
            $pointscount++
        }
        if($pointscount -eq '4'){
            $HeightMap[$i,$x,1] = $True
        }
        $pointscount = 0
    }
}
$sum = 0
ForEach($Height in $HeightMap){
    if($Height -eq $True){
        $sum = $sum+$([int]$previous+1)
    }
    $previous = $Height
}

Write-Host 'Part 1 Answer: '$sum