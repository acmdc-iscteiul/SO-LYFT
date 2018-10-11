#!/bin/bash
if [ -f utils.txt ]; then
    rm utils.txt
fi
cond=$(cat condutores.txt | wc -l)
pass=$(cat passageiros.txt | wc -l)
touch utils.txt
count=0
lei=0
ige=0
eti=0
cat condutores.txt | while read linha
    do
		count=$((count+1))
        pontos=$(echo $linha | cut -d':' -f10)
        viagens=$(echo $linha | cut -d':' -f9)
        rating=$((pontos / $viagens))
        turma=$(echo $linha | cut -d':' -f3 | cut -c1-2)
        if [ "$turma" = "EI" ]; then lei=$((lei+1))
        elif [ "$turma" = "ET" ]; then eti=$((eti+1))
        else ige=$((ige+1))
        fi
		echo $rating $(echo $linha | cut -d':' -f1) >> utils.txt
         if [ $count = $cond ]; then
            echo lei $lei eti $eti ige $ige >> utils.txt
        fi
    done
lei=$(cat utils.txt | tail -1 | cut -d' ' -f2)
eti=$(cat utils.txt | tail -1 | cut -d' ' -f4)
ige=$(cat utils.txt | tail -1 | cut -d' ' -f6)
cat utils.txt | head -n -1 > utils.tmp && mv utils.tmp utils.txt
cat utils.txt | sort -nrk 1 >> utils.txt
echo "Condutores: " $cond " Passageiros: " $pass
cat condutores.txt | awk -F "[:]" 'BEGIN {saldot=0} {saldot=saldot+$11}END{print "Saldo total: " saldot }'
echo "Condutor Numero 1: " $(cat utils.txt | tail -1 | cut -d' ' -f2)
echo "Condutor Numero 2: " $(cat utils.txt | tail -2 | head -1 | cut -d' ' -f2)
echo "Condutor Numero 3: " $(cat utils.txt | tail -3 | head -1 | cut -d' ' -f2)
echo $lei " Alunos de LEI, " $eti " Alunos de ETI e " $ige " Alunos de IGE"
 
