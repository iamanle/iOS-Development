//
//  main.c
//  Assignment 1
//
//  Created by An Le on 8/30/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#include <stdio.h>

/*------------------------------------------Question 1-------------------------------------------------------*/
void cubeTable(int n){
    int i = 0;
    for (i = 1; i < n; i++){
        printf("k: %i       k^3: %i  \n", i, i*i*i);
        
    }
}

/*------------------------------------------Question 3-------------------------------------------------------*/
int runningSum(int n){
    static int k = 0;
    return k = k + n;
}

/*------------------------------------------Question 5-------------------------------------------------------*/
int fibonacci(int n){
    if (n == 1 || n == 2) return 1;
        else
            return fibonacci(n-1) + fibonacci(n-2);
    
}

/*-----------------------------------------------main--------------------------------------------------------*/
int main(int argc, const char * argv[])
{

    //Question 1
    printf("Question 1: test with n = 5 \n");
    cubeTable(5);
    
    //Question 3
    printf("Question 3: test with input: 2,2,3,5 \n");
    printf("x1 = %i \n", runningSum(2));
    printf("x2 = %i \n", runningSum(2));
    printf("x3 = %i \n", runningSum(3));
    printf("x4 = %i \n", runningSum(5));
    
    //Question 5
    printf("Question 5: test with n = 5,10,15,20 \n");
    printf("n = 5 result = %i \n", fibonacci(5));
    printf("n = 10 result = %i \n", fibonacci(10));
    printf("n = 15 result = %i \n", fibonacci(15));
    printf("n = 20 result = %i \n", fibonacci(20));
    

    
    return 0;
}

