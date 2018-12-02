#pragma once
#include "Data.h"
class Date :
	public Data
{
private:
	int year;
	int mont;
	int day;
public:
	virtual string toString();
	Date(int year, int mont, int day);
	~Date();
};

