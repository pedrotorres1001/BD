# BD: Guião 3


## ​Problema 3.1
 
### *a)*

```
    Cliente: NIF,nome,endereco,num_carta

    Aluguer: numero,duracao,data

    Balcao: nome,numero,endereco

    Veiculo: matricula,ano,marca

    Tipo Veiculo: designacao,arcondicionado,codigo

    Similiraridade: Tipo_Veiculo_codigo1,Tipo_Veiculo_codigo2

    Ligeiro: designacao,arcondicionado,codigo,numlugares,portas,combustivel

    Pesado: designacao,arcondicionado,codigo,peso,passageiros
```


### *b)* 

```
Chaves Candidatas:
CLIENTE: num_carta,NIF

ALUGUER: numero

BALCAO: numero

VEICULO: matricula

TIPO_VEICULO: codigo

LIGEIRO: codigo

PESADO: codigo

-----------------------------------------------------------------------------------

Chaves Primárias:
CLIENTE: NIF

ALUGUER: numero

BALCAO: numero

VEICULO: matricula

TIPO_VEICULO: codigo

LIGEIRO: codigo

PESADO: codigo


-----------------------------------------------------------------------------------

Chaves Estrangeiras:
ALUGUER: - NIF (CLIENTE)
         - numero (BALCAO)
         - matricula (VEICULO)

VEICULO: codigo (TIPO_VEICULO)

Similaridade: codigo (TIPO_VEICULO)

```


### *c)* 

![ex_3_1c!](ex_3_1c.png "AnImage")


## ​Problema 3.2

### *a)*

```
    

    AIRPORT:Airport_code,City,State,Name 
    
    
    CAN_LAND: -Airport_code (AIRPORT)
              -Type_name (AIRPLANE_TYPE)

    AIRPLANE_TYPE: Company,Type_name,Max_seats

    AIRPLANE:Airplane_id,Total_no_of_seats,AIRPLANE_TYPE

    LEG_INSTANCE: No_of_avail_seats,Date,AIRPLANE

    SEAT: Seat_no,Customer_name,Cphone

    FLIGHT:Airline,Weekdays,Number 

    FLIGHT_LEG = Leg_no,Scheduled_dep_time,Scheduled_arr_time,AIRPORT,LEG_INSTANCE,FLIGHT

    FARE: Restrictions,Amount,Code,FLIGHT

    
```


### *b)* 

```
Chaves Candidatas:
AIRPORT: Name,Airport_code

CAN_LAND: -Airport_code (AIRPORT)
          -Type_name (AIRPLANE_TYPE)

AIRPLANE_TYPE: Type_name

AIRPLANE: Airplane_id
         
LEG_INSTANCE: Date

SEAT: Seat_no, Customer_name

FLIGHT: Number

FLIGHT_LEG: Leg_no

FARE: Code
-----------------------------------------------------------------------------------

Chaves Primárias:
AIRPORT: Airport_code

AIRPLANE: Type_name

LEG_INSTANCE: Date

SEAT: Seat_no

FLIGHT_LEG: Leg_no

FLIGHT: Number

FARE: Code

-----------------------------------------------------------------------------------

Chaves Estrangeiras:
AIRPLANE: Type_name (AIRPLANE_TYPE)

LEG_INSTANCE: Airplane_id,Type_name (AIRPLANE)

FLIGHT_LEG: - Airport_code(AIRPORT)
            - Date,Airplane_id,Type_name(LEG_INSTANCE)
            - Number(FLIGHT)

FARE: Number (FLIGHT)

```


### *c)* 

![ex_3_2c!](ex_3_2c.png "AnImage")


## ​Problema 3.3


### *a)* 2.1

![ex_3_3_a!](ex_3_3a.png "AnImage")

### *b)* 2.2

![ex_3_3_b!](ex_3_3b.png "AnImage")

### *c)* 2.3

![ex_3_3_c!](ex_3_3c.png "AnImage")

### *d)* 2.4

![ex_3_3_d!](ex_3_3d.png "AnImage")