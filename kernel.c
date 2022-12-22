/* void kmain() {
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'P';
} */


/* #include "include/idt.h"
#include "include/util.h"
#include "include/kb.h"
#include "include/isr.h"
#include "include/shell.h"
#include "include/screen.h"
 */



kmain()
{

	isr_install();
	clearScreen();
	print("\n");
	print("Starting the Kernel(myOS)...\n");
	print("\n"); 
	print_colored("------------------------------------------------------\n",2,0);
	print_colored("# MyOS Simple Kernel\n", 14,0); 
	print_colored("# based on github.com/iknowbrain/NIDOS \n",9,0);
	print_colored("# Licensed under the GNU General Public License v3.0\n",3,0);
	print_colored("------------------------------------------------------\n",2,0);
	print("\n");

	print("Welcome to the Kernel(myOS)!");
	print("\nThis is an open-source project, if you want to check or contribute");
	print_colored("\nPlease go to github.com/studio.suman/Bootloader :D",14,0);
	print("\nHave fun!");
	print("\n\n");

	launch_shell(0);   
		 
}
