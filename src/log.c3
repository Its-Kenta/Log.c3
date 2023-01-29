module log;
import std::io;

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
 * Template logger that is passed to different level functions or the [log()] function that user can pass their own respective level that can be changed on demand.
 * Rather than relaying on multiple functions to write different logs.
 **/
private macro void logger(LogLevel log, String file, int line) {
	io::printf("%s%s%s%s %s%s %s%s:%s: %s%s\n", Colors.GRAY.value, $$TIME, Colors.WHITE.value, log.color, log.level, Colors.WHITE.value, Colors.GRAY.value, file, line, Colors.WHITE.value);
}

/**
 * A variant of [logger()] that user can provide their own LogLevel.
 **/
macro void log(LogLevel log, String fmt, ...) {
	logger(log, $$FILE, $$LINE);
	io::printfn(fmt, $vasplat());
}

/**
 * Predefined TRACE [logger()] that calls [LogLevel.TRACE] to the [logger()] function.
 **/
macro void trace(String fmt, ...) {
	logger(LogLevel.TRACE, $$FILE, $$LINE);
	io::printfn(fmt, $vasplat());
}

/**
 * Predefined DEBUG [logger()] that calls [LogLevel.DEBUG] to the [logger()] function.
 **/
macro void debug(String fmt, ...) {
	logger(LogLevel.DEBUG, $$FILE, $$LINE);
	io::printfn(fmt, $vasplat());
}

/**
 * Predefined INFO [logger()] that calls [LogLevel.INFO] to the [logger()] function.
 **/
macro void info(String fmt, ...) {
	logger(LogLevel.INFO, $$FILE, $$LINE);
	io::printfn(fmt, $vasplat());
}

/**
 * Predefined WARN [logger()] that calls [LogLevel.WARN] to the [logger()] function.
 **/
macro void warn(String fmt, ...) {
	logger(LogLevel.WARN, $$FILE, $$LINE);
	io::printfn(fmt, $vasplat());
}

/**
 * Predefined ERROR [logger()] that calls [LogLevel.ERROR] to the [logger()] function.
 **/
macro void error(String fmt, ...) {
	logger(LogLevel.ERROR, $$FILE, $$LINE);
	io::printfn(fmt, $vasplat());
}

/**
 * Predefined FATAL [logger()] that calls [LogLevel.FATAL] to the [logger()] function.
 **/
macro void fatal(String fmt, ...) {
	logger(LogLevel.FATAL, $$FILE, $$LINE);
	io::printfn(fmt, $vasplat());
}