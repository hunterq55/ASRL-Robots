#include <chrono>
#include "ASRLFileLogger.h"


logger::logger(std::string fname)
{
    filename = fname;
    openFile();
}

void logger::openFile()
{
    file.open(filename);

}

void logger::closeFile()
{
    file.close();
}

void logger::logMessage(std::string message)
{
    time_t rawtime;
    struct tm * timeinfo;
    char buffer[80];

    time (&rawtime);
    timeinfo = localtime(&rawtime);

    strftime(buffer,sizeof(buffer),"%d-%m-%Y %H:%M:%S",timeinfo);
    std::string str(buffer);

    file << str;
    file << " -> ";
    file << message;
    file << "\n";
}



