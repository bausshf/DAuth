﻿/++
InstaUser-Basic - Salted Hashed Password Library for D

Writen in the D programming language.

Homepage:
$(LINK https://github.com/abscissa/InstaUser)

This_API_Reference:
$(LINK http://semitwist.com/dauth)

DMD flags to enable InstaUser-Basic unittests:
-------------------
-unittest -version=InstaUser_AllowWeakSecurity -version=InstaUserBasic_Unittest
-------------------

DMD flags to enable InstaUser-Basic unittests, but silence all non-error output:
-------------------
-unittest -version=InstaUser_AllowWeakSecurity -version=InstaUserBasic_Unittest -version=InstaUserBasic_Unittest_Quiet
-------------------

Import all:
------------
import instauser.basic;
------------

Copyright: © 2014-2015 Nick Sabalausky
License: zlib/libpng license, provided in
	$(LINK2 LICENSE.txt, https://github.com/Abscissa/InstaUser/blob/master/LICENSE.txt).
Authors: Nick Sabalausky
+/

module instauser.basic;

public import instauser.basic.core;
public import instauser.basic.hashdrbg;
public import instauser.basic.random;

version(InstaUserBasic_Unittest)
unittest
{
	import std.process;

	unitlog("Testing different results on different executions");
	assert(
		spawnShell(`rdmd --build-only --force -Isrc -ofbin/genBytes genBytes.d`).wait()
		== 0, "Failed to compile genBytes.d"
	);
	enum cmd = "bin/genBytes";
	auto result1 = execute(cmd);
	auto result2 = execute(cmd);
	auto result3 = execute(cmd);
	assert(result1.status == 0, "Command failed: "~cmd);
	assert(result2.status == 0, "Command failed: "~cmd);
	assert(result3.status == 0, "Command failed: "~cmd);

	assert(result1.output != result2.output);
	assert(result2.output != result3.output);
	assert(result3.output != result1.output);
}

version(InstaUserBasic_Unittest)
	void main() {}
