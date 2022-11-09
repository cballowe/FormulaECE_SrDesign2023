#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <string.h>
//#include <async.h>

int wait_loop0 = 10000;
int wait_loop1 = 6000;



/*
long int last_heartbeat;
long int heartbeat_difference;
struct timespec gettime_now;
int io_state = 0;
BYTE hb_10ms_timer = 0;
BYTE hb_100ms_timer = 0;
*/
// for microprocessor without timer, if it has a timer refer to vendor documentation and use it instead.
void wait( int seconds )
{   // this function needs to be finetuned for the specific microprocessor
    int i, j, k;
    for(i = 0; i < seconds; i++)
    {
        for(j = 0; j < wait_loop0; j++)
        {
            for(k = 0; k < wait_loop1; k++)
            {   // waste function, volatile makes sure it is not being optimized out by compiler
                int volatile t = 120 * j * i + k;
                t = t + 5;
            }
        }
    }
}

static uint64_t
counter( void )
{
  struct timespec now;
  clock_gettime(CLOCK_MONOTONIC, &now);
  return (uint64_t)now.tv_sec * UINT64_C(1000000000) + (uint64_t)now.tv_nsec;
}


int main( int argc, char **argv)
{/*
    int running = 300;
    for(int i = 0; i < 100; i++)
    {
        while( running )
        {   // do something
            --running;
            //uint64_t clockTime = clock_gettime(CLOCK_REALTIME, &now);
            //printf("Bye");
            //wait( 2 );
            //printf("hi");
        }
    }
    */
    clock_t start = clock();
    clock_t end = clock();
    double elapsed = 0;
    long microseconds = 0;
    struct timeval begin, end2;
    gettimeofday(&begin, 0);
    uint64_t startTimePls = clock_gettime(CLOCK_REALTIME, &now);
    while(1)
    
    {/*
        time_t rawtime;
        struct tm * timeinfo;

        time ( &rawtime );
        timeinfo = localtime ( &rawtime );
        printf ( "Current local time and date: %s", asctime (timeinfo) );
        
        time_t mytime = time(NULL);
        char * time_str = ctime(&mytime);
        time_str[strlen(time_str)-1] = '\0';
        printf("Current Time : %s\n", time_str);
        
        double sum = 0;
        double add = 1;

        // Start measuring time
        struct timeval begin, end;
        
        
        int iterations = 1000*1000*1000;
        for (int i=0; i<iterations; i++) {
            sum += add;
            add /= 2.0;
        }
        
        // Stop measuring time and calculate the elapsed time
        gettimeofday(&end, 0);
        long seconds = end.tv_sec - begin.tv_sec;
        long microseconds = end.tv_usec - begin.tv_usec;
        double elapsed = seconds + microseconds*1e-6;
        
        printf("Result: %.20f\n", sum);
        
        printf("Time measured: %.3f seconds.\n", elapsed);
        */    
        double sum = 0;
        double add = 1;

        // Start measuring time
        
        
        int iterations = 1000*1000*1000/200;
        for (int i=0; i<iterations; i++) {
            sum += add;
            add /= 2.0;
        }
        

        // Stop measuring time and calculate the elapsed time
        end = clock();
        //printf("%f\t", end);
        elapsed = (end - start)/CLOCKS_PER_SEC;
        gettimeofday(&end2, 0);
        microseconds = end2.tv_usec - begin.tv_usec;
        //printf("%f\t", microseconds);
        
        if(microseconds > 0.05)
        {
            //printf("Result: %.20f\n", sum);
            
            printf("Time measured: %.3f seconds.\n", microseconds);
            start = clock();
        }
    }

    return 0;


    return 0; // OK
}