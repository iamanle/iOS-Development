//
//  main.c
//  Question 6
//
//  Created by An Le on 8/30/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#include <stdio.h>
#include <math.h>

/*------------------------------------------Question 6-------------------------------------------------------*/
float compute(int n){
    float y = 1.1;
    for (int k = 0; k < n; k++)
        for (int j = 0; j < n; j++)
            y = sin(k*j+y);
    return y;
}

int main(int argc, const char * argv[])
{
    printf("Question 6: %f \n", compute(10000));
    return 0;
}
