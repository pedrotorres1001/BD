# BD: Guião 5


## ​Problema 5.1
 
### *a)*

```
Employee_list = project ⨝ Dno=Dnum employee
π Pname, Ssn, Fname, Lname (Employee_list) 
```


### *b)* 

```
Carlos_Ssn = π Mgr_ssn<-Ssn (σ Fname='Carlos' ∧ Minit='D' ∧ Lname='Gomes' (employee))
Employee_list = employee ⨝ Super_ssn=Mgr_ssn Carlos_Ssn 
π Fname, Lname (Employee_list)
```


### *c)* 

```
Worked_table = γ Pno;sum(Hours) -> total_worked works_on
π Pname, total_worked (project ⨝ Pnumber=Pno Worked_table)
```

### *d)* 

```
π Fname, Minit, Lname (σ Dno = 3 (employee ⨝ (Ssn = Essn) 
(σ Hours > 20 ∧ Pname = 'Aveiro Digital' 
(project ⨝ (Pnumber = Pno) (works_on)))))
```


### *e)* 

```
π Fname, Minit, Lname (σ Pno=null (employee ⨝ Ssn=Essn works_on))
```


### *f)* 

```
Fem_Dep = department ⨝ Dnumber=Dno σ Sex = 'F' (employee)
γ Dname;avg(Salary) -> Avg_Salary (Fem_Dep)
```


### *g)* 

```
Twoormore_dep = σ count_dep > 1 (γ Essn; count(Essn) -> count_dep dependent)
π Fname, Minit, Lname (Twoormore_dep ⨝ Essn=Ssn employee)
```


### *h)* 

```
Nodep = σ Essn=null (dependent ⨝ Essn=Ssn employee)
π Fname, Minit, Lname (department ⨝ Mgr_ssn=Ssn Nodep)
```


### *i)* 

```
π Fname, Lname, Address (employee ⨝ Ssn = Essn (works_on ⨝ Pno = Pnumber σ Plocation = 'Aveiro' (project))) 
-
π Fname, Lname, Address (employee ⨝ Dno = department.Dnumber (department ⨝ department.Dnumber = dept_location.Dnumber σ Dlocation = 'Aveiro' (dept_location)))
```


## ​Problema 5.2

### *a)*

```
π nome (σ numero = null (encomenda ⨝ fornecedor = nif fornecedor))
```

### *b)* 

```
π nome, media (γ codProd;avg(unidades)-> media (item) ⨝ codProd=codigo (produto))
```


### *c)* 

```
γ ;avg(unidades) -> media (γ numEnc; count(codProd) -> unidades (item))
```


### *d)* 

```
π fornecedor.nome, produto.nome, quantidades
γ fornecedor.nif, fornecedor.nome, produto.codigo, produto.nome; sum(item.unidades) -> quantidades
(
	fornecedor 
	⨝ encomenda.fornecedor = fornecedor.nif 
	encomenda 
	⨝ encomenda.numero = item.numEnc 
	item
	⨝ item.codProd = produto.codigo
	produto
)
```


## ​Problema 5.3

### *a)*

```
π nome (σ (numPresc=null) (paciente⟗prescricao))
```

### *b)* 

```
γ especialidade; count(numPresc) -> prescricoes (medico⨝ prescricao)
```


### *c)* 

```
γ farmacia; count(numPresc) -> prescricoes (farmacia⨝ prescricao)
```


### *d)* 

```
π nome (σ numPresc = null AND numRegFarm = 906 (presc_farmaco⨝ farmaco) )
```

### *e)* 

```
Far_vend = σ farmacia != null (presc_farmaco ⨝ presc_farmaco.numPresc = prescricao.numPresc (prescricao))
Aux = γ farmacia, numRegFarm; count(numRegFarm) -> qtd_farmacos (Far_vend)
π farmacia, qtd_farmacos (Aux ⨝ numRegFarm = numReg (farmaceutica))
```

### *f)* 

```
prescricoes = γ numUtente; count(numMedico) -> medicos (π numUtente,numMedico prescricao)
π nome (paciente ⨝(σ medicos > 1 prescricoes))
```
