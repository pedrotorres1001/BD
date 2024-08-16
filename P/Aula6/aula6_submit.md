# BD: Guião 6

## Problema 6.1

### *a)* Todos os tuplos da tabela autores (authors);

```
SELECT * FROM authors;
```

### *b)* O primeiro nome, o último nome e o telefone dos autores;

```
SELECT au_fname, au_lname, phone FROM authors;
```

### *c)* Consulta definida em b) mas ordenada pelo primeiro nome (ascendente) e depois o último nome (ascendente); 

```
SELECT au_fname, au_lname, phone 
FROM authors
ORDER BY au_fname, au_lname ASC;
```

### *d)* Consulta definida em c) mas renomeando os atributos para (first_name, last_name, telephone); 

```
SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone
FROM authors
ORDER BY first_name, last_name ASC;
```

### *e)* Consulta definida em d) mas só os autores da Califórnia (CA) cujo último nome é diferente de ‘Ringer’; 

```
SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone
FROM authors
WHERE state = 'CA' AND last_name != 'Ringer'
ORDER BY first_name, last_name ASC;
```

### *f)* Todas as editoras (publishers) que tenham ‘Bo’ em qualquer parte do nome; 

```
SELECT pub_name FROM publishers
WHERE pub_name LIKE '%Bo%';
```

### *g)* Nome das editoras que têm pelo menos uma publicação do tipo ‘Business’; 

```
SELECT DISTINCT pub_name 
FROM publishers, titles
WHERE type='Business' AND titles.pub_id=publishers.pub_id;
```

### *h)* Número total de vendas de cada editora; 

```
SELECT pub_name, SUM(ytd_sales)
FROM (titles JOIN publishers ON publishers.pub_id=titles.pub_id)
GROUP BY pub_name;
```

### *i)* Número total de vendas de cada editora agrupado por título; 

```
SELECT pub_name, title, SUM(ytd_sales)
FROM (titles JOIN publishers ON publishers.pub_id=titles.pub_id)
GROUP BY title, pub_name;
```

### *j)* Nome dos títulos vendidos pela loja ‘Bookbeat’; 

```
SELECT title 
FROM ((titles JOIN sales ON titles.title_id = sales.title_id) JOIN stores ON sales.stor_id = stores.stor_id)
WHERE stor_name LIKE 'Bookbeat';
```

### *k)* Nome de autores que tenham publicações de tipos diferentes; 

```
SELECT authors.au_fname, authors.au_lname
FROM ((authors JOIN titleauthor ON authors.au_id = titleauthor.au_id)
JOIN titles ON titleauthor.title_id = titles.title_id)
GROUP BY authors.au_fname, authors.au_lname
HAVING COUNT(DISTINCT type) > 1;
```

### *l)* Para os títulos, obter o preço médio e o número total de vendas agrupado por tipo (type) e editora (pub_id);

```
SELECT titles.type, titles.pub_id, SUM(qty) AS quantity, AVG(price) AS price
FROM (titles JOIN sales ON titles.title_id = sales.title_id)
GROUP BY titles.type, titles.pub_id;
```

### *m)* Obter o(s) tipo(s) de título(s) para o(s) qual(is) o máximo de dinheiro “à cabeça” (advance) é uma vez e meia superior à média do grupo (tipo);

```
SELECT [type], max(advance) AS maximo, avg(advance) AS media
FROM titles
GROUP BY [type]
HAVING max(advance) > 1.5 * avg(advance);
```

### *n)* Obter, para cada título, nome dos autores e valor arrecadado por estes com a sua venda;

```
SELECT title, au_fname, au_lname, ytd_sales*price*royalty/100 AS revenue
FROM ((titles JOIN titleauthor ON titles.title_id = titleauthor.title_id) JOIN authors ON titleauthor.au_id = authors.au_id)
GROUP BY title, price, au_fname, au_lname, ytd_sales, royalty
```

### *o)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, a faturação total, o valor da faturação relativa aos autores e o valor da faturação relativa à editora;

```
SELECT title, ytd_sales, ytd_sales * price AS facturacao, 
ytd_sales * price * royalty / 100 AS auths_revenue, 
price * ytd_sales - price * ytd_sales * royalty / 100 AS publisher_revenue
FROM titles
```

### *p)* Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome, o nome de cada autor, o valor da faturação de cada autor e o valor da faturação relativa à editora;

```
SELECT title, au_fname, au_lname, ytd_sales, ytd_sales * price AS facturacao, 
ytd_sales * price * royalty / 100 AS auths_revenue, 
price * ytd_sales - price * ytd_sales * royalty / 100 AS publisher_revenue
FROM ((titles JOIN titleauthor ON titles.title_id = titleauthor.title_id) JOIN authors ON titleauthor.au_id = authors.au_id);
```

### *q)* Lista de lojas que venderam pelo menos um exemplar de todos os livros;

```
SELECT stor_name
FROM stores JOIN sales ON stores.stor_id = sales.stor_id
JOIN titles ON sales.title_id = titles.title_id
GROUP BY stor_name
HAVING COUNT(DISTINCT titles.title_id) = (SELECT COUNT(*) FROM titles);
```

### *r)* Lista de lojas que venderam mais livros do que a média de todas as lojas;

```
SELECT stor_name FROM storesINNER JOIN sales ON stores.stor_id=sales.stor_idINNER JOIN titles ON sales.title_id=titles.title_id
GROUP BY stores.stor_name
HAVING SUM(sales.qty)>(SELECT SUM(sales.qty)/COUNT(stor_id) FROM sales);
```

### *s)* Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;

```
SELECT title
FROM titles
EXCEPT
(
	SELECT title
	FROM titles JOIN sales ON titles.title_id = sales.title_id
	JOIN stores ON sales.stor_id = stores.stor_id
	WHERE stor_name = 'Bookbeat'
)
```

### *t)* Para cada editora, a lista de todas as lojas que nunca venderam títulos dessa editora; 

```
SELECT pub_name, stor_name
FROM publishers
JOIN titles ON publishers.pub_id = titles.pub_id
JOIN sales ON titles.title_id = sales.title_id
JOIN stores ON sales.stor_id = stores.stor_id
GROUP BY pub_name, stor_name
HAVING COUNT(DISTINCT titles.title_id) = 0
```

## Problema 6.2

### ​5.1

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_1_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_1_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT P.PNAME, E.SSN, E.FNAME, E.LNAME FROM COMPANY2_PROJECT AS P JOIN COMPANY2_EMPLOYEE AS E ON P.DNUM = E.DNO; 
```

##### *b)* 

```
SELECT E.FNAME,E.LNAME FROM COMPANY2_EMPLOYEE AS E JOIN  COMPANY2_EMPLOYEE AS S ON E.SUPERSSN = S.SSN WHERE S.FNAME = 'Carlos'AND S.LNAME='Gomes';
```

##### *c)* 

```
SELECT PNAME, SUM(HOURS) AS total_worked FROM COMPANY2_PROJECT JOIN COMPANY2_WORKS_ON  ON PNUMBER = PNO GROUP BY PNAME;
```

##### *d)* 

```
SELECT FNAME,MINIT,LNAME FROM COMPANY2_EMPLOYEE JOIN COMPANY2_PROJECT ON DNO = DNUM JOIN COMPANY2_WORKS_ON ON PNUMBER = PNO WHERE DNO = 3 AND PNAME='Aveiro Digital' AND HOURS > 20;
```

##### *e)* 

```
SELECT FNAME,MINIT,LNAME FROM COMPANY2_EMPLOYEE FULL JOIN COMPANY2_WORKS_ON ON SSN = ESSN  WHERE ESSN IS NULL 
```

##### *f)* 

```
SELECT DNAME,AVG(SALARY) AS avg_salary FROM COMPANY2_EMPLOYEE JOIN COMPANY2_DEPARTMENT ON DNO= DNUMBER WHERE SEX= 'F' GROUP BY DNAME;

```

##### *g)* 

```
SELECT E.FNAME,E.MINIT,E.LNAME AS count_ssn FROM COMPANY2_EMPLOYEE AS E JOIN COMPANY2_EMPLOYEE AS S ON E.SSN = S.SUPERSSN GROUP BY E.FNAME,E.MINIT,E.LNAME HAVING  COUNT(*)  >2;
```

##### *h)* 

```
SELECT DISTINCT E.FNAME,E.MINIT,E.LNAME FROM COMPANY2_EMPLOYEE AS E JOIN COMPANY2_EMPLOYEE AS S  ON E.SSN != S.SUPERSSN WHERE E.SUPERSSN IS NULL;
```

##### *i)* 

```
SELECT DISTINCT FNAME,MINIT,LNAME,ADDRESS FROM COMPANY2_EMPLOYEE JOIN COMPANY2_WORKS_ON ON SSN = ESSN  JOIN COMPANY2_PROJECT ON  PNO= PNUMBER;
```

### 5.2

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_2_ddl.sql "SQLFileQuestion")


#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_2_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT F.NOME FROM GETSTOCK_FORNECEDOR as F  FULL JOIN GETSTOCK_ENCOMENDA AS E ON F.NIF = E.FORNECEDOR WHERE E.NUMERO IS NULL;
```

##### *b)* 

```
SELECT NOME,AVG(UNIDADES) as avg_prod FROM GETSTOCK_PRODUTO GROUP BY NOME;
```


##### *c)* 

```
SELECT AVG(Aa) AS avg_prod
FROM
(SELECT CAST(COUNT(*) AS FLOAT) AS Aa FROM GETSTOCK_ITEM
GROUP BY NUMENC) AS a;

```


##### *d)* 

```
SELECT P.NOME,I.UNIDADES,F.NOME FROM GETSTOCK_PRODUTO AS P JOIN GETSTOCK_ITEM AS I ON P.codigo = CODPROD JOIN GETSTOCK_ENCOMENDA AS E ON NUMENC = NUMERO JOIN GETSTOCK_FORNECEDOR AS F ON E.FORNECEDOR = NIF 
```

### 5.3

#### a) SQL DDL Script
 
[a) SQL DDL File](ex_6_2_3_ddl.sql "SQLFileQuestion")

#### b) Data Insertion Script

[b) SQL Data Insertion File](ex_6_2_3_data.sql "SQLFileQuestion")

#### c) Queries

##### *a)*

```
SELECT P1.NOME FROM PRESCRICAO_PACIENTE as P1 FULL JOIN PRESCRICAO_PRESCRICAO AS P2 ON P1.NUMUTENTE = P2.NUMUTENTE WHERE P2.NUMPRESC IS NULL; 
```

##### *b)* 

```
SELECT ESPECIALIDADE,COUNT(NUMPRESC) AS n_presc FROM PRESCRICAO_MEDICO JOIN PRESCRICAO_PRESCRICAO ON NUMSNS = NUMMEDICO GROUP BY ESPECIALIDADE;
```


##### *c)* 

```
SELECT F.NOME,COUNT(P.NUMPRESC) AS n_presc FROM PRESCRICAO_FARMACIA as F JOIN PRESCRICAO_PRESCRICAO AS P  ON F.NOME = P.FARMACIA GROUP BY F.NOME;
```


##### *d)* 

```
SELECT F1.NOME FROM PRESCRICAO_FARMACO AS F1 JOIN PRESCRICAO_FARMACEUTICA AS F2 ON F1.NUMREGFARM= F2.NUMREG WHERE F2.NUMREG = 906;
```

##### *e)* 
```
SELECT P.FARMACIA,F.NOME,COUNT(PF.NOMEFARMACO) AS farmaco_sold FROM  PRESCRICAO_PRESC_FARMACO AS PF JOIN PRESCRICAO_PRESCRICAO AS P ON PF.NUMPRESC = P.NUMPRESC JOIN PRESCRICAO_FARMACEUTICA as F ON PF.NUMREGFARM = F.NUMREG  WHERE PF.NUMREGFARM IS NOT NULL AND P.FARMACIA IS NOT NULL GROUP BY P.FARMACIA, F.NOME;
```

##### *f)* 

```
SELECT P.NOME FROM PRESCRICAO_PACIENTE AS P JOIN PRESCRICAO_PRESCRICAO AS PR ON P.NUMUTENTE = PR.NUMUTENTE JOIN PRESCRICAO_MEDICO AS M ON M.NUMSNS = PR.NUMMEDICO GROUP BY P.NOME HAVING COUNT(M.NOME) > 1;

```
