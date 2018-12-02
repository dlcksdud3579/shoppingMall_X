#pragma once
#include "Data.h"
class Null :
	public Data
{
public:
	virtual string toString() { return "NULL"; }
	Null();
	~Null();
};

