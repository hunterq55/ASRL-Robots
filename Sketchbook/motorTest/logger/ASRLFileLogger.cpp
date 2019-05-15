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
    std::time_t result = std::time(nullptr);;
    file << result;
    file << "\n";
    file << message;
    file << "\n";
}



