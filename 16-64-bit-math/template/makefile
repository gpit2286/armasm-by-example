# Define the object files you need for the final executable 
OBJS = main.o  

# The next line uses % which is a wildcard character to refer to all .s and .o files 
%.o : %.s 
    # $< = source file, $@ = output file 
	as $< -g -o $@ 

# build the main executable 
main: $(OBJS)
	ld -o main $(OBJS)


