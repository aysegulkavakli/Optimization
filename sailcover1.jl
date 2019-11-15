using JuMP,Clp,Printf
d = [40 60 75 25 36] 
m = Model(with_optimizer(Clp.Optimizer))
@variable(m, 0 <= x[2:5] <= 40)       
@variable(m, y[2:5] >= 0)
@variable(m, h[1:6] >= 0)           
@constraint(m, h[1] == 15)
@constraint(m, h[5] >= 10)
@constraint(m, flow[i in 1:4], h[i]+x[i]+y[i]==d[i]+h[i+1])    
@objective(m, Min, 400*sum(x) + 450*sum(y) + 20*sum(h))         
optimize!(m)

@printf("X Values: %d %d %d %d\n", value(x[2]), value(x[3]), value(x[4]), value(x[5]))
@printf("Y Values: %d %d %d %d\n", value(y[2]), value(y[3]), value(y[4]), value(y[5]))
@printf("H Values: %d %d %d %d %d\n ", value(h[1]), value(h[2]), value(h[3]), value(h[4]), value(h[5]))
@printf("Objective cost: %f\n", objective_value(m))
