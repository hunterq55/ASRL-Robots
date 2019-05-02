expression = input('Enter the name of a matrix: ','s');
     if (exist(expression,'var'))
        plot(eval(expression))
     end