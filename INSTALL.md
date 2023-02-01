<div align="center">
<p>

[📖 Back to Main Page](./README.md)
</p>

# Installation Guide

</div>

## Table of Contents

- [Installation Guide](#installation-guide)
  - [Table of Contents](#table-of-contents)
  - [Installation](#compatibility)
  - [Dependencies](#dependencies)
  - [Usage](#usage)
  - [Log Level List](#log-level-list)

## Installation

[**Log.c3**](https://github.com/Its-Kenta/logc3/blob/main/src/log.c3) needs to be dropped into your project and have it's module imported `import log;`

## Dependencies

No dependencies required for this library.

## Usage

This library provides you with two different ways of logging with a very simplistic API, one way is to use the pre-defined function-like macros for logging:

```c
log::trace(String fmt, ...);
log::debug(String fmt, ...);
log::info(String fmt, ...);
log::warn(String fmt, ...);
log::error(String fmt, ...);
log::fatal(String fmt, ...);
```

> **Note**
> 
> These functions internally call `io::printf()` with addition of vararg argument.

```c
log::trace("Hello %s", "world");
```

> **Note**
> 
> The following output will be:

```c
19:28:51 TRACE main.c3:4: Hello world
```

You can also use `log::log()` which allows users to provide their own Log Level and not depend on pre-defined function-like macros:

```c
log::log(LogLevel log, String fmt, ...)
```

> **Note**
> 
> This function will require a LogLevel to be passed as a parameter.
> We can create a Log Level by defining it as a variable:
> ```c
>log::LogLevel myLogLevel = log::LogLevel.WARN;
>```
> Which then can be passed to the `log::log()` function.

## Log Level List

Currently accepted Log Level's and their corresponding terminal colors:

```c
enum LogLevel : uint (String level, String color) {
	TRACE("TRACE", "\e[94m"),
	DEBUG("DEBUG", "\e[36m"),
	INFO("INFO", "\e[32m"),
	WARN("WARN", "\e[33m"),
	ERROR("ERROR", "\e[31m"),
	FATAL("FATAL", "\e[35m")
}
```
