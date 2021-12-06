class PuzzleTracking {
    [int]$forward
    [int]$p1d
    [int]$p2d
}

$FilePath = 'C:\Scripts\AoC\2021\Day2\day2.txt'
$Coords = [PuzzleTracking]::new()
$Coords.forward = 0
$Coords.p1d = 0
$Coords.p2d = 0

function puzzle-solve($FilePath,[PuzzleTracking]$Coords){
    $puzzleinput = gc $FilePath
    ForEach($entry in $puzzleinput){
        $info = $entry.split(' ')
        if($info[0] -eq 'forward'){
            $Coords.forward = $Coords.forward + [int]$info[1]
            $coords.p2d = $Coords.p2d+($Coords.p1d*[int]$info[1])
        }elseif($info[0] -eq 'down'){
            $Coords.p1d = $Coords.p1d + [int]$info[1]
        }else{
            $Coords.p1d = $Coords.p1d - [int]$info[1]
        }
    }

    Write-Host "Part One:" $($Coords.forward*$Coords.p1d)
    Write-Host "Part Two:" $($Coords.forward*$Coords.p2d)
}

puzzle-solve -FilePath $FilePath -Coords $Coords