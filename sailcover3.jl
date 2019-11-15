using JuMP,Clp,Printf

d = [40 60 70 25] 
m = Model(with_optimizer(Clp.Optimizer))

@variable(m, 0 <= x[0:4] <= 40)      
@variable(m, y[0:4] >= 0)        
@variable(m, ha[0:4] >= 10) 
@variable(m, ca[1:4] >= 0) 
@variable(m, cb[1:4] >= 0) 
@variable(m, hb[0:4] <= 0)  
@constraint(m, ha[0] - hb[0] == 10)
@constraint(m, flow[i in 1:4], ha[i-1] + hb[i-1] + x[i]+y[i]==d[i]+ha[i]-hb[i]) 
@constraint(m, flow2[i in 1:4], x[i]+y[i]-(x[i-1] + y[i-1])==ca[i]-cb[i]) 
@objective(m, Min, 400*sum(x) + 450*sum(y) + 20*sum(ha) + 400*sum(ca) + 500*sum(cb) + 100*sum(hb))  

optimize!(m)

@printf("X Values: %d %d %d %d\n", value(x[1]),value(x[2]), value(x[3]), value(x[4]))
@printf("Y Values: %d %d %d %d\n", value(y[1]),value(y[2]), value(y[3]), value(y[4]))
@printf("Objective cost: %f\n", objective_value(m))


