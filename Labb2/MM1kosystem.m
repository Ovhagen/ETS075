clear all; %empty memory
rand('seed',0)%set random seed
lambda1=7.5; %arrival rate
lambda2=10; %arrival rate
mu1=10; 	%service rate
mu2=14; 	%service rate
mu3=22; 	%service rate
mu4=9; 	        %service rate
mu5=11; 	%service rate
alfa=0.4;       %probability to go to system 4
endtime=1000; %simulation length
t=0; %current time
tstep=1; %time between consecutive sample events
currcustomers1=0; %current nbr of customers in system 1
currcustomers2=0; %current nbr of customers in system 2
currcustomers3=0; %current nbr of customers in system 3
currcustomers4=0; %current nbr of customers in system 4
currcustomers5=0; %current nbr of customers in system 5
servtime1=0; %time in server in system 1
servtime2=0; %time in server in system 2
servtime3=0; %time in server in system 3
servtime4=0; %time in server in system 4
servtime5=0; %time in server in system 5
%event is a vector with time for next arrival system 1 (pos 1),
%next service completion system 1 (pos 2), time for next arrival
%system 2 (pos 3), next service completion system 2
%(pos 4), next service completion system 3 (pos 5),
%next service completion system 4 (pos 6), next
%service completion system 5 (pos 7) and next sample
%event (pos 8)
event(1)=exprnd(1/lambda1); %next arrival system 1
event(2)=inf; %no customer in system 1
event(3)=exprnd(1/lambda2); %next arrival system 2
event(4)=inf; %no customer in system 2
event(5)=inf; %no customer in system 3
event(6)=inf; %no customer in system 4
event(7)=inf; %no customer in system 5
event(8)=exprnd(tstep); %next sample event
k=1;
nbrmeasurements1=0; %number of (nbr of customer) measurements made
nbrdeparted1=0; %nbr of departed customers from system 1
nbrmeasurements2=0; %number of (nbr of customer) measurements made
nbrdeparted2=0; %nbr of departed customers from system 2
nbrmeasurements3=0; %number of (nbr of customer) measurements made
nbrdeparted3=0; %nbr of departed customers from system 3
nbrmeasurements4=0; %number of (nbr of customer) measurements made
nbrdeparted4=0; %nbr of departed customers from system 4
nbrmeasurements5=0; %number of (nbr of customer) measurements made
nbrdeparted5=0; %nbr of departed customers from system 5
nbrarrived1=0; %nbr of cust that have arrived throughout the
%simulations to system 1
nbrarrived2=0; %nbr of cust that have arrived throughout the
%simulations	to system 2
nbrarrived3=0; %nbr of cust that have arrived throughout the
%simulations to system 3
nbrarrived4=0; %nbr of cust that have arrived throughout the
%simulations	to system 4
nbrarrived5=0; %nbr of cust that have arrived throughout the
%simulations	to system

i = 1;
t1 = 1;
t2 = 1;
t3 = 1;
t4 = 1;
t5 = 1;


while t<endtime %while not simulation finished
    [t,nextevent]=min(event); %find next event
    if nextevent==1 %if next event is a call arrival to system 1
        event(1)=exprnd(1/lambda1)+t; %insert time for next call
        %arrival event
        if currcustomers1==0 %if no customer in server
            servtime1=exprnd(1/mu1); %set service time
            T1s(t1) = servtime1;
            t1 = t1 + 1;
            event(2)=servtime1+t; %time for call departure from
            %system 1 in event-vector
        end
        
        currcustomers1=currcustomers1+1;
        nbrarrived1=nbrarrived1+1; %one more customer has arrived to
        %system 1 through the simulations
        arrivedtime1(nbrarrived1)=t; %the new customer arrived at time t
    elseif nextevent==2 %call departure from system 1
        currcustomers1=currcustomers1-1; %one customer leave
        %system 1
        timeinsystem1=t-arrivedtime1(nbrarrived1-currcustomers1); %total
        %response time for
        %the departed customer
        nbrdeparted1=nbrdeparted1+1; %one more customer has departed from
        %system 1 through the simulations
        T1(nbrdeparted1)=timeinsystem1; %put the total response time in
        %vector T1
        
        if currcustomers1>0 %if any more customers in system 1
            servtime1=exprnd(1/mu1); %set time for service
            event(2)=servtime1+t; %service finished
        else
            event(2)=inf; %if no customers in system no departure
        end
        if currcustomers3==0 %the departed customer arrives to
            %system 3, check if no customer in server
            servtime3=exprnd(1/mu3); %time for deperture of
            T3s(t3) = servtime3;
            t3 = t3 + 1;
            %system 3
            event(5)=servtime3+t;
        end
        currcustomers3=currcustomers3+1; %one mor customer in system 3
        nbrarrived3=nbrarrived3+1; %one more customer has arrived to
        %system 3 through the simulations
        arrivedtime3(nbrarrived3)=t; %the new customer arrived at time t
    elseif nextevent==3 %if next event is a call arrival to system 2
        event(3)=exprnd(1/lambda2)+t;%insert time for next call
        %arrival event
        if currcustomers2==0 %if no customer in server
            servtime2=exprnd(1/mu2); %set service time
            T2s(t2) = servtime2;
            t2 = t2 + 1;
            event(4)=servtime2+t; %time for call departure from
            %system 2 in event-vector
        end
        currcustomers2=currcustomers2+1;
        nbrarrived2=nbrarrived2+1; %one more customer has arrived to
        %system 2 through the simulations
        arrivedtime2(nbrarrived2)=t; %the new customer arrived at time t
    elseif nextevent==4 %call departure from system 2
        currcustomers2=currcustomers2-1; %call departure from system 2
        timeinsystem2=t-arrivedtime2(nbrarrived2-currcustomers2);%one customer
        %leave system 2
        nbrdeparted2=nbrdeparted2+1; %one more customer has departed from
        %system 2 through the simulations
        T2(nbrdeparted2)=timeinsystem2;%put the total response time in
        %vector T2
        
        if currcustomers2>0 %if any more customers in system 1
            servtime2=exprnd(1/mu2); %set time for service
            event(4)=servtime2+t;
        else
            event(4)=inf; %if no customers in system no departure
        end
        if currcustomers3==0
            servtime3=exprnd(1/mu3); %set time for service
            event(5)=servtime3+t; %time for deperture of
            %system 3
        end
        currcustomers3=currcustomers3+1;
        nbrarrived3=nbrarrived3+1; %one more customer has arrived to
        %system 3 through the
        %simulations
        arrivedtime3(nbrarrived3)=t; %the new customer arrived at time t
    elseif nextevent==5 %call departure from system 3
        currcustomers3=currcustomers3-1; %call departure from system 3
        timeinsystem3=t-arrivedtime3(nbrarrived3-currcustomers3);
        nbrdeparted3=nbrdeparted3+1; %one more customer has departed from
        %system 3 through the simulations
        T3(nbrdeparted3)=timeinsystem3; %put the total response time in
        %vector T3
        
        if currcustomers3>0 %the departed customer arrives to
            %system 3, check if no customer in server
            servtime3=exprnd(1/mu3); %set time for service
            event(5)=servtime3+t;
        else
            event(5)=inf;
        end
        
        if rand(1)<alfa %if random number less than alfa go to
            %system 4
            if currcustomers4==0 %if no customers
                servtime4=exprnd(1/mu4); %set time for service
                T4s(t4) = servtime4;
                t4 = t4 + 1;
                event(6)=servtime4+t;
            end
            currcustomers4=currcustomers4+1;
            nbrarrived4=nbrarrived4+1; %one more customer has arrived to
            %system 4 through the simulations
            arrivedtime4(nbrarrived4)=t; %the new customer arrived
            %at time t
        else %go to system 5
            if currcustomers5==0 %if no customers
                servtime5=exprnd(1/mu5); %set time for service
                T5s(t5) = servtime5;
                t5 = t5 + 1;
                event(7)=servtime5+t;
            end
            currcustomers5=currcustomers5+1;
            nbrarrived5=nbrarrived5+1; %one more customer has arrived to
            %system 5 through the simulations
            arrivedtime5(nbrarrived5)=t; %the new customer arrived
            %at time t
        end
        
    elseif nextevent==6 %call departure from system 4
        currcustomers4=currcustomers4-1; %departure from system 4
        timeinsystem4=t-arrivedtime4(nbrarrived4-currcustomers4);
        nbrdeparted4=nbrdeparted4+1; %one more customer has departed from
        %system 4 through the simulations
        T4(nbrdeparted4)=timeinsystem4; %put the total response time in
        %vector T4
        
        if currcustomers4>0 %if any more customers in system 4
            servtime4=exprnd(1/mu4); %set time for service
            event(6)=servtime4+t;
        else
            event(6)=inf;
        end
        
    elseif nextevent==7 %call departure from system 5
        currcustomers5=currcustomers5-1; %departure from system 5
        timeinsystem5=t-arrivedtime5(nbrarrived5-currcustomers5);
        nbrdeparted5=nbrdeparted5+1; %one more customer has departed from
        %system 5 through the simulations
        T5(nbrdeparted5)=timeinsystem5; %put the total response time in
        %vector T5
        
        if currcustomers5>0 %if any more customers in system 5
            servtime5=exprnd(1/mu5); %set time for service
            event(7)=servtime5+t;
        else
            event(7)=inf;
        end
      
    else
        nbrmeasurements1=nbrmeasurements1+1; %one more (nbr of customer) measurement made
        N1(nbrmeasurements1)=currcustomers1;
          
        if(currcustomers1 > 0)
            Nq1(i) = currcustomers1 - 1;
        else
            Nq1(i) = 0;
        end
        
        nbrmeasurements2=nbrmeasurements2+1; %one more (nbr of customer) measurement made
        N2(nbrmeasurements2)=currcustomers2;
        
         if(currcustomers2 > 0)
            Nq2(i) = currcustomers2 - 1;
         else
            Nq2(i) = 0;
         end
        
        nbrmeasurements3=nbrmeasurements3+1; %one more (nbr of customer) measurement made
        N3(nbrmeasurements3)=currcustomers3;
        
         if(currcustomers3 > 0)
            Nq3(i) = currcustomers3 - 1;
         else
            Nq3(i) = 0;
         end
        
        nbrmeasurements4=nbrmeasurements4+1; %one more (nbr of customer) measurement made
        N4(nbrmeasurements4)=currcustomers4;
        
         if(currcustomers3 > 0)
            Nq4(i) = currcustomers4 - 1;
         else
            Nq4(i) = 0;
         end
        
        nbrmeasurements5=nbrmeasurements5+1; %one more (nbr of customer) measurement made
        N5(nbrmeasurements5)=currcustomers5;
        
         if(currcustomers5 > 0)
            Nq5(i) = currcustomers5 - 1;
         else
            Nq5(i) = 0;
         end
        
        N(k)=currcustomers1+currcustomers2+currcustomers3+ ...
            currcustomers4+currcustomers5; %Total number of
        %customers in the whole
        %system at this time
        k=k+1;
        i = i + 1;
        event(8)=event(8)+exprnd(tstep);
        end
end
NMean=[mean(N1) mean(N2) mean(N3) mean(N4) mean(N5)]
NqMean=[mean(Nq1) mean(Nq2) mean(Nq3) mean(Nq4) mean(Nq5)]
TMean=[mean(T1s) mean(T2s) mean(T3s) mean(T4s) mean(T5s)]
lambdaMean=NMean./TMean