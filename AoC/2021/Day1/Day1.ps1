$FilePath = 'C:\Scripts\AoC\2021\Day1\day1.txt'
$depth = 0

function part-one($FilePath){
    $depth = 0
    $input = gc $FilePath
    for($i = 1; $i -lt $input.Length; $i++){
        if([int]$input[$i] -gt [int]$input[$i-1]){
            $depth++
        }
    }
    return $depth
}

function part-two($FilePath){
    $depth = 0
    $input = gc $FilePath
    for($i = 3; $i -lt $input.Length; $i++){
        if([int]$input[$i-2]+[int]$input[$i-1]+[int]$input[$i] -gt [int]$input[$i-3]+[int]$input[$i-2]+[int]$input[$i-1]){
            $depth++
        }
    }
    return $depth
}

part-one -FilePath $FilePath