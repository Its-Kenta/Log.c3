module log;
import std::io;
import libc;

// Internal File that represents our filename.
File loggerFile @private;

// Time and Tm struct variables to obtain current time for logger.
Time currentTime @private;
Tm* timeptr @private;

/**
 * Colors hold String values for Color codes.
 **/
enum Colors: uint (String value) {
	GRAY("\e[90m"),
	WHITE("\e[0m")
}

/**
 * Each Log level holds their respective level name and color to then pass to the logger.
 **/
enum LogLevel : uint (String level, String color) {
	TRACE("TRACE", "\e[94m"),
	DEBUG("DEBUG", "\e[36m"),
	INFO("INFO", "\e[32m"),
	WARN("WARN", "\e[33m"),
	ERROR("ERROR", "\e[31m"),
	FATAL("FATAL", "\e[35m")
}

/**
 * Template logger that is passed to different level functions user can pass their own respective level that can be changed on demand.
 **/
macro void log(LogLevel log, String fmt, ...) {
	Time currentTime = libc::time(null);
	Tm* timeptr = libc::localtime(&currentTime);
	io::printf("%s%s:%s:%s%s%s %s%s %s%s:%s: %s%s\n", Colors.GRAY.value, timeptr.tm_hour, timeptr.tm_min, timeptr.tm_sec, Colors.WHITE.value, log.color, log.level, Colors.WHITE.value, Colors.GRAY.value, $$FILE, $$LINE, Colors.WHITE.value);

	@logToFile() {
		loggerFile.printf("%02d:%02d:%s %s %s:%s: ", timeptr.tm_hour, timeptr.tm_min, timeptr.tm_sec, log, $$FILE, $$LINE);
		loggerFile.printfn(fmt, $vasplat());
	};

	io::printfn(fmt, $vasplat());
}

/**
 * Predefined TRACE [logger()] that calls [LogLevel.TRACE] to the [logger()] function.
 **/
macro void trace(String fmt, ...) {
	log(LogLevel.TRACE, fmt, $vasplat());
}

/**
 * Predefined DEBUG [logger()] that calls [LogLevel.DEBUG] to the [logger()] function.
 **/
macro void debug(String fmt, ...) {
	log(LogLevel.DEBUG, fmt, $vasplat());
}

/**
 * Predefined INFO [logger()] that calls [LogLevel.INFO] to the [logger()] function.
 **/
macro void info(String fmt, ...) {
	log(LogLevel.INFO, fmt, $vasplat());
}

/**
 * Predefined WARN [logger()] that calls [LogLevel.WARN] to the [logger()] function.
 **/
macro void warn(String fmt, ...) {
	log(LogLevel.WARN, fmt, $vasplat());
}

/**
 * Predefined ERROR [logger()] that calls [LogLevel.ERROR] to the [logger()] function.
 **/
macro void error(String fmt, ...) {
	log(LogLevel.ERROR, fmt, $vasplat());
}

/**
 * Predefined FATAL [logger()] that calls [LogLevel.FATAL] to the [logger()] function.
 **/
macro void fatal(String fmt, ...) {
	log(LogLevel.FATAL, fmt, $vasplat());
}

// Macro with trailing lambda that gets our current date to name the file based on DAY-MONTH-YEAR and creates the file if it currently doesn't exist.
macro void @logToFile(;@body) @private {
	Time currentTime = libc::time(null);
	Tm* timeptr = libc::localtime(&currentTime);

	char[80] fileName;
	libc::strftime(&fileName, 80, "LOG-%d-%m-%Y.txt", timeptr);


	loggerFile.open(((ZString)&fileName).as_str(), "a")!!;
	defer loggerFile.close()!!;
	@body();
}
