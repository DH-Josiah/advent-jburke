$input = gc 'C:\Scripts\AoC\2020\Day 1\day1.txt'

for($i = 1; $i -lt $input.Length; $i++){
    for($i2 = [int]$i+1; $i2 -lt $input.Length; $i2++){
        if([int]$input[$i]+[int]$input[$i2]+[int]$input[$i3] -eq 2020){
            Write-Host $input[$i] "*" $input[$i2] "=" $([int]$input[$i]*[int]$input[$i2])
            exit
        }
    }
}
