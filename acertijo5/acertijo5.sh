#!/bin/bash


misterio=$(grep -iow 'Misterio' $1);


echo "$misterio" | wc -w > lector_clave_secreta.txt

fibonacci(){
    if (( $1 == 0 )); then
        echo 0;
    elif (( $1 == 1 )); then
        echo 1;
    else

        fib_1=$(fibonacci $(( $1 - 1 )));   
        fib_2=$(fibonacci $(( $1 - 2 )));
        echo $(("$fib_1" + "$fib_2"));  
    fi
}

factorial(){
        echo $(( $1 * $(factorial $(( $1 - 1 )) ) ));
}

if [ $(( $2 % 2 == 0)) && $2 != 0 ]; then
    resultado_factorial=$(factorial $2);
    echo "$resultado_factorial" >> lector_clave_secreta.txt
else
    resultado_fibonacci=$(fibonacci $2);
    echo "$resultado_fibonacci" >> lector_clave_secreta.txt
fi

