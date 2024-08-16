# **AR VS SQL**

# Lista de Operações Básicas
1. Seleção
1. Projeção
1. União
1. Interseção
1. Diferença
1. Produto Cartesiano
1. Renomeação
1. Theta Join
1. Natural Join
1. EquiJoin
1. Divisão


# Selação
 ## AR
 ### Notação (AR)
  ```
  σ <Condição Seleção> R

  Utilizada para selecionar o Subconjunto de tuplos da relação(AR)/Tabela(SQL) que satisfazem os critérios de seleção.
  ```
 ### Predicado
  #### Operadores de Comparação

    . Operandos : Nomes deos atributos e constantes
    . Operadores : =,=/,<=,>=,<,>

     σA1=2 (R) 
  #### Condições Boleanas
    . AND,OR,NOT
    σA1=2 (R) AND σA2>3 (R) 

  ## SQL
  ### WHERE
   ```sql
    SELECT A1,A2 FROM T -- Operação Projeção próximo tópico
    WHERE A1 = 2 OR A2= 1;

    -- WHERE permite selecionar um subconjuntos de tuplos de uma ou mais tabelas de acordo uma expressão condicional
   ```

# Projeção
  ## AR
   ```
   π <Lista de atributos> R

   O resultado obtido é uma nova relação só com os atributos selecionados e são removidas as linhas duplicadas do resultado (tipo um set)
   ```
  ## SQL
  ### SELECT FROM
  ```sql
    SELECT * FROM T; -- Todas as colunas de T
    SELECT C1,C2 FROM T; -- 2 colunas de T

    -- Permite selecionar um conjunto de atributos(colunas) de uma ou mais tabelas
  ```

  ### SELECT ALL vs DISTINCT
  ```sql
    SELECT ALL A1 FROM T; -- Seleciona todos os tuplos de um atributo

    SELECT DISTINCT A2 FROM T; -- Elimina tuplos repetidos de um atributo

  ```

  # União
  ## AR
    ```
    Nota: As tabelas têm de ser compatíveis
        . Mesmo número de atributos
        . Atributos com domínios compatíveis

    R1 U R2 = {t: t ∈ R V t ∈ S}

    O resultado é uma relação que inclui todos os tuplos de R1 e R2, os tuplos duplicados são elminados(como num set)
    ```
  ## SQL
   ```sql
   (SELECT A1,A2 FROM R1 WHERE A1 = 2)
   UNION
   (SELECT A1,A3 FROM R2 WHERE A1 = 2)

   -- Como na AR as tabelas têm de ser compatíveis e o resultado será um set de todos os tuplos de R1 e R2
   
   UNION ALL -- Mantêm os tuplos duplicados
   ```


 ## Interseção
 ## AR
  ```
   Nota: As tabelas têm de ser compatíveis
        . Mesmo número de atributos
        . Atributos com domínios compatíveis

    R1 ∩ R2 = {t: t ∈ R ∧ t ∈ S}

    O resultado é uma relação que inclui todos os tuplos comuns em  R1 e em R2, os tuplos duplicados são elminados(como num set)

  ```

 ## SQL
   ```sql

    (SELECT A1,A2 FROM R1 WHERE A1 = 2)
    INTERSECT
    (SELECT A1,A2 FROM R2 WHERE A1 = 2)

    -- Como na AR as tabelas têm de ser compatíveis e o resultado será um set de todos os tuplos comuns em R1 e em  R2
    
    INTERSECT ALL -- Mantêm os tuplos duplicados
   ```

 ## Diferença
 ## AR
  ```
    Nota: As tabelas têm de ser compatíveis
        . Mesmo número de atributos
        . Atributos com domínios compatíveis

    R1 - R2 = {t: t ∈ R ∧ t ∉ S}

    O resultado é uma relação que inclui todos os tuplos que não existem em R2, os tuplos duplicados são elminados(como num set)
  ```

 ## SQL
  ```sql
   (SELECT A1,A2 FROM R1 WHERE A1 = 2)
   EXCEPT
   (SELECT A1,A2 FROM R2 WHERE A2 = 3)

   -- Como na AR as tabelas têm de ser compatíveis e o resultado será um set de todos os tuplos que não existem em  R2
   
   EXCEPT ALL -- Mantêm os tuplos duplicados
  ```
 
 ## Produto Cartesiano
 ## AR
  ```
    R1 X R2

    Permite combinar tuplos de relações diferentes. O resultado é uma nova relação R3 que combina cada tuplo de uma relação R com um tuplo da outra relação S.
    O número de tuplos de Q é n * m.  (n nº de tuplos de R1 e m nº de tuplos de R2 )
  ```

  ## SQL
  ```sql
    SELECT * FROM T1,T2;

    --Podemos utilizar mais do que uma relação na instrução SELECT FROM, o resultado é o produto cartesiano dos 2 conjuntos

    -- Esta operação tem pouco intresse prático, no etanto a associação com o operador WHERE permite a junção de relações

    SELECT A1,A2 FROM  T WHERE A1=2 AND A2=1;

    SELECT A1,A2 FROM T1,T2 WHERE T1.A3 =T2.A3; -- Caso haja ambiguidade nos nome dos atributos usa-se o full qualified name(fqn)
  ```
  # Renomeação
  ## AR
  ```
    ρR2(B1,B2,...,Bn)(R1) ou ρR2(R1) ou ρ(B1,B2,...,Bn)(R1)

    No 1º caso o resultado é uma nova relação R2 com os atributos renomeados (B1,B2,...,Bn)

    No 2º caso só renomeamos a relação

    No 3º caso só renomeamos os atributos
  ```

  ## SQL
  ```sql
    SELECT tab.A FROM T AS tab; -- Renomear a tabela T

    SELECT A AS atr FROM T; -- Renomear o atributo A

    SELECT A * 2 AS op FROM T; --Renomear o resultado de uma operação aritmética 

  ``` 
  # Theta Join
  ## AR
  ``` 
    R ⋈C R1
    .Pode ser visto como os resultado das seguintes operações:
     . R3 <-  R1 X R2 (produto cartesiano)
     .σC (R3) (seleção com condição c)

    . C é <join condition> que pode ser da seguiente forma:
    <condition> AND <condition> ...

    .Em cada condition podemos aplicar operadores de comparação

  ```
  ## SQL
  ```sql
    SELECT * FROM T1 JOIN T2 ON T1.A1 > T2.A1;
  ```


# Natural Join
## AR
  ```
  R1 ⋈ R2

  . Condição implícita igualdade dos atributos com o mesmo nome

  . Os atributos repetidos são removidos

  .Nota: Muitas vezes opta-se por renomear as colunas de modo a facilitar junções naturais
  ```

## SQL
```sql
 SELECT A1,A2 FROM T1 NATURAL JOIN T2 (A2) WHERE A1 = 2;

 -- As condições impostas na AR são as mesmas para SQL
```

# EQUI JOIN
## AR
```
  R1 ⋈A1=A2 R2

  . É utilizado o operador = na condição  de junção

  . Vamos ter sempre 2 colunas repetidas
```

## SQL
```sql
  SELECT * FROM T1 JOIN T2 ON T1.A1 = T2.A2;
```

# Divisão
## AR
``` R1÷R2

  R1 (A1,...,Ar,B1,...Br)
  R2 (B1,...,Br)

  . O resultado incluirá todos os tuplos de R3(A1,..AR) que tenham corrspondência com todos os tuplos de R2 em R4(B1,...,Br). R3 E R4 são projeções de R

  . Número de atributos em R1 > R2
```

## SQL
```sql
  --Não existe um operador em SQL de divisão
```

# Lista de operações estendidas
  1. Semi Join (Left & Right)
  1. Outer Join (Left, Right & Full)
  1. Agregação (Funções de Agregação)


# Semi Join
## Left Semi Join
### AR
```
R1 ⋉ R2
Projeção dos atributos de  R1 na junção natural de R1 com R2
```
### SQL
```sql
-- Não existe um operador  específico para esta operação
```

## Right Semi Join
R1 ⋊ R2
```
Projeção dos atributos de  R2 na junção natural de R1 com R2
```
### SQL
```sql
  -- Não existe um operador  específico para esta operação
```


# Outer Join 
 ```
 . Incluimos no resultado todos os tuplos de uma (ou de ambas) das relações componentes

 . Os astributos que não fazem matching são preenchidos com NUll
 ```

 ## Left Outer Join
 ### AR
  ```
 R1 ⟕ R2
 ```

 ### SQL
 ```sql
 SELECT A1 FROM(T1 LEFT OUTER JOIN T2 ON T1.A1 = T2.A1)
 ```

## Right Outer Join
 ### AR
 ```
 R1 ⟖ R2
 ```

 ### SQL
  ```sql
 SELECT A1 FROM(T1 RIGHT OUTER JOIN T2 ON T1.A1 = T2.A1)
 ```

## Full Outer Join
 ### AR
  ```
 R1 ⟗ R2
 ```

 ### SQL
  ```sql
 SELECT A1 FROM(T1 FULL OUTER JOIN T2 ON T1.A1 = T2.A1)
 ```

# Agregação
## Operação
### AR
  ```
  γ <lista de atributos de grupo>, <lista de funções de agregação>(R)

  Operação sobre vários tuplos da relação

  ```

### SQL
  ```sql
  GROUP BY <lista de atributos de grupo> --Efetuar agregação por atributos

  HAVING <condição> -- Efetuar seleção sobre dados agrupados
  ```


## Funções de Agregação

### AR
 1. avg: média dos valores
 1. min: mínimo dos valores
 1. max: máximo dos valores
 1. sum: soma dos valores
 1. count: número dos valores

 ```
 . Podem ser usadas em projeções
 . Criar atributos agregados
 . Os atributos não agregados são agrupados de forma a não haver valores repetidos
 ```

### SQL
```sql
COUNT(A)-- média de A
SUM(A)--  soma de A
MAX(A)-- máximo de A
MIN(A)-- mínimo de A
AVG(A)-- média de A
```







