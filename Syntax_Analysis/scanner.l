%{
#include "y.tab.h"
#include<string.h>
#include<stdio.h>
int lineno=1;
int comment_nesting = 0; 
int eleCount=50;

struct t
	{
	char key[20]; 
	int lno; 
	}type;
	
     
      struct node {

        
        char name[20];
	char type[20];
	int key;

        struct node *next;

    };

     

    struct hash {

        struct node *head;

        int count;

    };

	//struct hash *hashTable = (struct hash *) calloc(50, sizeof(struct hash)); 
     	
	struct hash hashTable[50]; 
	struct hash chashTable[50];
 
    struct node * createNode(int key, char *name, char *type) {

        struct node *newnode;

        newnode = (struct node *) malloc(sizeof(struct node));

	newnode->key=key;
        strcpy(newnode->name, name);
	strcpy(newnode->type, type);

        newnode->next = NULL;

        return newnode;

    }

     

    void insertToHash(int key, char *name, char *type) {
	
        int hashIndex = key % eleCount;

        struct node *newnode = createNode(key, name, type);

       
      


  if (!hashTable[hashIndex].head) {

            hashTable[hashIndex].head = newnode;

            hashTable[hashIndex].count = 1;

            return;

        }




        
        newnode->next = (hashTable[hashIndex].head);

    

        hashTable[hashIndex].head = newnode;

        hashTable[hashIndex].count++;

        return;


    }

     

    
    int searchInHash(int key, char *name) {

        int hashIndex = key % eleCount, flag = 0;
	

        struct node *myNode;

        myNode = hashTable[hashIndex].head;

        if (!myNode) {


        	return flag;    
	
        }

        while (myNode != NULL) {

            if (strcmp(myNode->name,name)==0) {


                flag = 1;

                break;

            }

            myNode = myNode->next;

        }

     
        return flag;

    }

     

    void display() {

        struct node *myNode;

        int i;
	    printf("\n\n                                  SYMBOL TABLE");

	    printf("\n\n\n");
            printf("\t|------------------------------------------------------------------------|\n");

	    printf("\t|                                       |                                |\n");
            
            printf("\t|         Name                          |  	Type                     |\n");

            printf("\t|------------------------------------------------------------------------|\n");
	   
            printf("\t|                                       |                                |\n");


        for (i = 0; i < eleCount; i++) {

            if (hashTable[i].count == 0)

                continue;

            myNode = hashTable[i].head;

            if (!myNode)

                continue;

         
          
            while (myNode != NULL) {

                printf("\t|\t%-30s", myNode->name);

                printf("\t|\t%-15s\n", myNode->type);
            printf("\t|------------------------------------------------------------------------|\n");

          

                myNode = myNode->next;

            }

        }

        return;

    }


	int hash_func(char val[20])
	{
	int sum=0;
	for(int i=0; i<strlen(val);i++)
	{
		sum+=val[i]; 
	}
	sum%=50;
	
	return sum; 
	}

 void insertTocHash(int key, char *name, char *type) {
	
        int hashIndex = key % eleCount;

        struct node *newnode = createNode(key, name, type);

       
      


  if (!chashTable[hashIndex].head) {

            chashTable[hashIndex].head = newnode;

            chashTable[hashIndex].count = 1;

            return;

        }




        
        newnode->next = (chashTable[hashIndex].head);

    

        chashTable[hashIndex].head = newnode;

        chashTable[hashIndex].count++;

        return;


    }

     

    
    int searchIncHash(int key, char *name) {

        int hashIndex = key % eleCount, flag = 0;
	

        struct node *myNode;

        myNode = chashTable[hashIndex].head;

        if (!myNode) {


        	return flag;    
	
        }

        while (myNode != NULL) {

            if (strcmp(myNode->name,name)==0) {


                flag = 1;

                break;

            }

            myNode = myNode->next;

        }

     
        return flag;

    }

     

    void cdisplay() {

        struct node *myNode;

        int i;
	
	    printf("\n\n                                 CONSTANT TABLE");

	    printf("\n\n\n");
            printf("\t|------------------------------------------------------------------------|\n");

	    printf("\t|                                       |                                |\n");
            
            printf("\t|         Constant                      |  	Type                     |\n");

            printf("\t|------------------------------------------------------------------------|\n");
	   
            printf("\t|                                       |                                |\n");


        for (i = 0; i < eleCount; i++) {

            if (chashTable[i].count == 0)

                continue;

            myNode = chashTable[i].head;

            if (!myNode)

                continue;

         
          
            while (myNode != NULL) {

                printf("\t|\t%-30s", myNode->name);

                printf("\t|\t%-15s\n", myNode->type);
            printf("\t|------------------------------------------------------------------------|\n");

          

                myNode = myNode->next;

            }

        }

        return;

    }


	int chash_func(char val[20])
	{
	int sum=0;
	for(int i=0; i<strlen(val);i++)
	{
		sum+=val[i]; 
	}
	sum%=50;
	
	return sum; 
	}



%}
alpha [a-zA-Z_]
digit [0-9]
ID {alpha}({alpha}|{digit})*
WHITESPACE " "|"	"|"\n"


%x SC_COMMENT



%%

#include[ ]?<{alpha}*.h> {}

"/*"             { comment_nesting++; BEGIN(SC_COMMENT); }
<SC_COMMENT>{
  "/*"           { comment_nesting++; }

  "*"+"/"        { comment_nesting=0;
                    BEGIN(INITIAL);  }
  "*"+           ;
[/]            ;
\n             { lineno++;}
}

\/\/[^\n]*[\n]? { lineno++; }



"break"			{ return(BREAK); }
"char"			{strcpy(type.key,yytext); 
			type.lno=lineno; 
			 return(CHAR); }
"double"		{ strcpy(type.key,yytext); 
			type.lno=lineno; 
			return(DOUBLE); }
"else"			{ return(ELSE); }
"float"			{strcpy(type.key,yytext); 
			type.lno=lineno; 
			 return(FLOAT); }
"for"			{ return(FOR); }
"if"			{ return(IF); }
"int"			{ strcpy(type.key,yytext); 
			type.lno=lineno; 
			return(INT); }
"long"			{  strcpy(type.key,yytext); 
			type.lno=lineno; 
			return(LONG); }
"return"		{  strcpy(type.key,yytext); 
			type.lno=lineno; 
			return(RETURN); }
"short"			{  strcpy(type.key,yytext); 
			type.lno=lineno; 
			return(SHORT); }
"signed"		{  strcpy(type.key,yytext); 
			type.lno=lineno; 
			return(SIGNED); }
"unsigned"		{  strcpy(type.key,yytext); 
			type.lno=lineno; 
			return(UNSIGNED); }
"void"			{  strcpy(type.key,yytext); 
			type.lno=lineno; 
			return(VOID); }
 		

{ID} 	{	
			int key=hash_func(yytext);
	if(searchInHash(key,yytext)==0)
	{
	if (type.lno==lineno)
		//printf("%s", type.key); 
	insertToHash(key,yytext,type.key); }
			return ID;}

{digit}+		{int key=chash_func(yytext);
			if(searchIncHash(key,yytext)==0)
			insertTocHash(key,yytext,"constant");
			return CONSTANT;}

{digit}*\.{digit}+	{int key=chash_func(yytext);
			if(searchIncHash(key,yytext)==0)
			insertTocHash(key,yytext,"constant");
			return CONSTANT;}

0[xX][0-9a-fA-F]+	{int key=chash_func(yytext);
			if(searchIncHash(key,yytext)==0)
			insertTocHash(key,yytext,"constant");
			return CONSTANT;}

'0'[0-7]+		{int key=chash_func(yytext);
			if(searchIncHash(key,yytext)==0)
			insertTocHash(key,yytext,"constant");
			return CONSTANT;}

[+-]?[digit]+[.]?[digit]*([eE][+-]?[digit]+)?			{int key=chash_func(yytext);
			if(searchIncHash(key,yytext)==0)
			insertTocHash(key,yytext,"constant");
			return CONSTANT;}






\"[^\n]*\" 	{
	int key=chash_func(yytext);
	if(searchIncHash(key,yytext)==0)
	insertTocHash(key,yytext,"string");
			return(STRING);
		}

"+="|"-="|"*="|"/="|"%="	{ return(ASSIGN_OP); }
"=="|"!="			{ return(EQU_OP); }
"<="|">="|">"|"<"		{ return(REL_OP); }
"+"|"-"				{ return(ADD_OP); }
"*"|"/"|"%"			{ return(MUL_OP); }
"++"|"--"			{ return(INCDEC_OP); }
"&&"        {return(LAND);}
"||"        {return(LOR);}
"=" 		{ return('='); }
"{"			{ return('{'); }
"}"			{ return('}'); }
"("			{ return('('); }
")"			{ return(')'); }
"["			{ return('['); }
"]"			{ return(']'); }
";"			{strcpy(type.key," ");
				type.lno=0; 
				 return(';'); }
","			{ return(','); }
"."			{ return('.'); }
"?"			{ return('?'); }
":"			{ return(':'); }

{WHITESPACE}	{ if(yytext[0]=='\n') { lineno++; } };

. {printf("LEXICAL ERROR - %s : invalid character at line [%d]\n",yytext,lineno);}

%%



int yywrap()
{
	return 1;
}
