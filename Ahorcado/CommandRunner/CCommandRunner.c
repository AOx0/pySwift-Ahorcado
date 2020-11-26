//
//  CCommandRunner.c
//  Ahorcado
//
//  Created by Alejandro D on 19/11/20.
//

#include "CCommandRunner.h"
#include "stdlib.h"

// Deprecated
void shSearchForPython(const char *userPath) {
    char command[150] = "";
    char command2[150] = "";
    sprintf(command, "%s%s%s", "cd ", userPath, "; echo `which python3` > 'tempㄦ∴.txt'");
    sprintf(command2, "%s%s%s", "cd ", userPath, "; echo ∴ >> 'tempㄦ∴.txt'");
    
    system(command);
    system(command2);
    

}

void shSearchForPython2(const char *userPath) {
    char command1[150] = "";
    char command2[150] = "";
    char command3[150] = "";
    char command4[150] = "";
    sprintf(command1, "%s%s%s", "cd /; echo `find /Library/Frameworks/Python.framework/Versions | egrep '/bin/python3$|/bin/python4$' | wc -l` > '", userPath, "/tempㄦ∴.txt'");
    sprintf(command2, "%s%s%s", "cd /; echo : >> '", userPath, "/tempㄦ∴.txt'");
    sprintf(command3, "%s%s%s", "cd /; echo `find /Library/Frameworks/Python.framework/Versions | egrep '/bin/python3$|/bin/python4$'` >> '", userPath, "/tempㄦ∴.txt'");
    sprintf(command4, "%s%s%s", "cd /; echo ∴ >> '", userPath, "/tempㄦ∴.txt'");
    
    system(command1);
    system(command2);
    system(command3);
    system(command4);
}
