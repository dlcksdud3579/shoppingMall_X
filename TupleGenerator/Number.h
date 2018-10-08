#pragma once
#include "Data.h"
class Number :
	public Data
{
private:
	int val;
public:
	virtual string toString();
	Number(int _var);
	~Number();
};

