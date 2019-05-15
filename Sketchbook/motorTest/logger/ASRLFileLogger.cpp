#include "ASRLFileLogger.h"


logger::logger(std::string filename)
{
    openFile();
}

void logger::openFile()
{
    file.open(filename, std::ios::out);
}

void logger::closeFile()
{
    file.close();
}

void logger::logMessage(std::string message)
{
    file << message;
    file << "\n";
}

int main()
{
    logger *log = new logger("Squishy.txt");

    log->logMessage("This is a message that im trying to log!!!\nThis is a sample message after a new line");

    log->closeFile();

    return 0;

}


