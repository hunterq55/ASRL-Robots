#include <stdio.h>
#include <iostream>
#include <fstream>


#ifndef LOGGER_ASRLFILELOGGER_H
#define LOGGER_ASRLFILELOGGER_H

#endif //LOGGER_ASRLFILELOGGER_H


class logger
{
public:

    logger(std::string filename);

    void logMessage(std::string message);

    void openFile();

    void closeFile();

    std::string filename;

    std::ofstream file;

private:




};