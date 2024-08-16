# BD: Guião 7


## ​7.2 
 
### *a)*

```
A relação está na 1FN já que não suporta relações dentro de relações e todos os atributos são atómicos.
```

### *b)* 

```
titulo_livro -> A
nome_autor -> B
afiliacao_autor -> C
tipo_livro -> D
preco -> E
num_paginas -> F
editor -> G
endereco_editor -> H
ano_publicacao -> I

2FN - R1 = {<u>A, B</u>, D, E, F, G, H, I} R2 ={<u>B</u>, C}
3FN - R1 = {<u>A, B</u>, D, F, G, I} R2 = {<u>B</u>, C} R3 = {<u>D</u>, F, E} R4 = {<u>G</u>, H}
```




## ​7.3

### *a)*

```
 Chave de R : (A , B)
```


### *b)* 

```
R1 = {<u>A</u>,<u>B </u>,C}
R2 = {<u>A</u>,D,E,I,J}
R3 = {<u>B</u>,F,G,H}

```


### *c)* 

```
R1 = {<u>A</u>,<u>B</u>,C}
R2 = {<u>A</u>,D,E}
R3 = {<u>B</u>,F}
R4 = {<u>D</u>,I,J}
R5 = {<u>F</u>,G,H}

```


## ​7.4
 
### *a)*

```
Chave de R: (A, B)
```


### *b)* 

```
3FN -> R1 = {<u>A, B</u>, C, D, E} R2 = {<u>D/u>, E} R3 = {<u>C/u>, A}
```


### *c)* 

```
BCNF -> R1 = {<u>B/u>, C, D} R2 = {<u>D/u>, E} R3 = {<u>C/u>, A}
```



## ​7.5
 
### *a)*

```
 Chave de R : (A , B)
```

### *b)* 

```
 R1 = {<u> A </u>,<u> B </u>,C,D,E}
 R2 = {<u> A </u>,C,D}
```


### *c)* 

```
 R1 = {<u> A </u>,<u> B </u>,C,D,E}
 R2 = {<u> A </u>,C,D}
 R3 = {<u> C </u>, D}
```

### *d)* 

```
 R1 = {<u> A </u>,<u> B </u>,E}
 R2 = {<u> A </u>,C,D}
 R3 = {<u> C </u>, D}
```
