field definition
fieldsDesc 
^ #(
	unsignedByte     	n_d;            
	unsignedByte     	flag;       
	unsignedShort    	op;         
	int     				n_child;    
	int     				tmp;        
	int     				ptr_size;   
	int      				*d;
	int     				ext_label;     
	uint    				ext_flag;      
	float      			*x;             
	float      			*g;             
	void       			*ptr;           
	void       			*gtmp;       
	KAD_node_t 			**child; 
	KAD_node_t  			*pre;   
)