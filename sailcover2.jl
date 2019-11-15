using JuMP,Clp,Printf

d = [40 60 70 25] 
m = Model(with_optimizer(Clp.Optimizer))

@variable(m, 0 <= x[0:4] <= 40)
@variable(m, y[0:4] >= 0)         
@variable(m, h[0:4] >= 0)       
@variable(m, ca[1:4] >= 0) 
@variable(m, cb[1:4] >= 0) 
@constraint(m, h[0] == 10)
@constraint(m, h[4] >= 10)
@constraint(m, x[0] + y[0] == 50)
@constraint(m, flow[i in 1:4], h[i-1] + x[i]+y[i]==d[i] + h[i]) 
@constraint(m, flow2[i in 1:4], x[i]+y[i]-(x[i-1] + y[i-1])==ca[i]-cb[i]) 
@objective(m, Min, 400*sum(x) + 450*sum(y) + 20*sum(h) + 400*sum(ca) + 500*sum(cb))     

optimize!(m)

@printf("X Values: %d %d %d %d\n", value(x[1]),value(x[2]), value(x[3]), value(x[4]))
@printf("Y Values: %d %d %d %d\n",value(y[1]),value(y[2]), value(y[3]), value(y[4]))
@printf("Objective cost: %f\n", objective_value(m))
