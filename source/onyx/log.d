/**
 * onyx-log: the generic, fast, multithreading logging library.
 *
 * User interface to work with logging.
 *
 * Copyright: © 2015- Oleg Nykytenko
 * License: MIT license. License terms written in "LICENSE.txt" file
 * Authors: Oleg Nykytenko, oleg.nykytenko@gmail.com
 */

module onyx.log;


import onyx.bundle;
import onyx.core.logger;


@safe:


/**
 * Create loggers from config bundle
 *
 * Throws: BundleException, LogCreateException
 */
void createLoggers(immutable Bundle bundle)
{
    create(bundle);
}

/**
 * Get created logger interface to work with it
 *
 * Throws: LogException
 */
Log getLogger(immutable string loggerName)
{
    return get(loggerName);
}

/**
 * Delete logger
 *
 * Throws: Exception
 */
void deleteLogger(immutable string loggerName)
{
    delete_([loggerName]);
}

/**
 * Delete loggers
 *
 * Throws: Exception
 */
void deleteLoggers(immutable string[] loggerNames)
{
    delete_(loggerNames);
}

/**
 * Set path to file for save loggers exception information
 *
 * Throws: Exception
 */
void setErrFile(immutable string file)
{
    setErrorFile(file);
}


/**
 * User interface for work with logger.
 */
interface Log
{
    /**
     * Logger's name
     */
    immutable (string) name();

    /**
     * Configurations data
     */
    immutable (Bundle) config();

    /**
     * Logger's level
     */
    immutable (string) level();

    /**
     * Write message to logger
     */
    void debug_(lazy const string msg) nothrow;
    void info(lazy const string msg) nothrow;
    void warning(lazy const string msg) nothrow;
    void error(lazy const string msg) nothrow;
    void critical(lazy const string msg) nothrow;
    void fatal(lazy const string msg) nothrow;
}


/**
 * Logger exception
 */
class LogException:Exception
{
    @safe pure nothrow this(string exString)
    {
        super(exString);
    }
}

/**
 * Log creation exception
 */
class LogCreateException:LogException
{
    @safe pure nothrow this(string exString)
    {
        super(exString);
    }
}



@trusted:
unittest
{
    auto bundle = new immutable Bundle("./test/test.conf");
    createLoggers(bundle);
    setErrorFile("./log/error.log");

    version(vTestFile)
    {
        auto log2 = getLogger("DebugLogger");
        log2.debug_("debug msg");
        log2.info("info msg");
        log2.error("error!!!!!! msg");
	}
    else
    {
        auto log = getLogger("ErrorLogger");
    	log.info("info test msg");
    	log.error("error test msg");
    }
}
