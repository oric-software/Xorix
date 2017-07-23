#include <stdio.h>
#include <string.h>

extern void xorix_start();

extern void hires();

unsigned char version_opt=0;
unsigned char help_opt=0;

void version()
{
  printf("xorix 0.0.1\n");
}

void usage()
{
  printf("usage:\n");
  printf("xorix [-v] [--version] [-h] [--help]\n");
  printf("Start Graphic interface\n");
  printf("\n\nCode : Jede (jede@oric.org)\n");
  return;
}


unsigned char getopts(char *arg)
{
  // 2: arg is not an option
  if (arg[0]!='-') return 2;
  if (strcmp(arg,"--version")==0 || strcmp(arg,"-v")==0) 
  {
    version_opt=1;
    return 0;
  }
  
  if (strcmp(arg,"--help")==0 || strcmp(arg,"-h")==0) 
  {
    help_opt=1;
    return 0;
  }  

  return 1;
  
}


int main(int argc,char *argv[])
{


  unsigned char i,ret,found_a_folder_in_arg_found=0;

  if (argc>0)
  {
    for (i=1;i<argc;i++)
    {
      ret=getopts(argv[i]);
      if (ret==1) 
      {
        //this is a parameter but not recognized
        usage();
        return 1;
      }
      if (ret==2) 
      {
        //theses are to stop if we have 2 folders on commands line, in the future it will bepossible
        if (found_a_folder_in_arg_found==0) 
            found_a_folder_in_arg_found=1;
        else
        {
          // here we found 2 folders on the command line
          usage();
          return 1;
        }
      }
    }
  }
  else
  {
      usage();
      return 1;
  }

  if (version_opt==1)
  {
    version();
    return 0;
  }
  
  if (help_opt==1)
  {
    usage();
    return 0;
  }  

hires();
xorix_start();


  
	
}
