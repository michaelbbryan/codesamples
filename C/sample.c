#include <stdio.h>

/* declare constants */
#define PI 3.1415
#define E  2.2178

main()
{

printf("hello world\n");

float fahr, cels;
int   lower, upper, step;

lower = 0;
upper = 300;
step=50;

fahr = lower;
printf("FAHR\tCELS\n");
while (fahr<=upper) {
  cels=(5.0/9.0)*(fahr-32.0);
  printf("%4.0f\t%6.1f\n",fahr,cels);
  fahr=fahr+step;
  }

double fah;
printf("FAHR\tCELS\n");
for (fah=0.0; fah<=300.0; fah=fah+50.0) {
  printf("%4.0f\t%6.1f\n",fah,(5.0/9.0)*(fah-32.0));
  }

/* input output */
int c;
printf("\nType a char and I'll echo it ... \n");
c = getchar();
putchar(c);
putchar('\n');

long cc; /* character count */
long lc; /* line count */
long wc; /* word count */
printf("\nType a paragraph and I'll count the chars, words, lines ... \n");
cc = lc = wc = 0;

while ( (c=getchar()) != 'Z' ) {
  ++cc;
  if (c == '\n')
    ++lc;
  else if (c == ' ' || c == '\t')
    ++wc;
  }
printf ("%8d characters\n%8d words\n%8d lines\n\n",cc,wc,lc);

/* sample function */

int power(int base; int pwr)
  {
  int i, p;
  p = 1;
  for (i=1; i <=  pwr ; ++i )
    p =  p*base;
  return p;
  }

printf("\n2 to the 4 power is %6d",power(2,4));


}
