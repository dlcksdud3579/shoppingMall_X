#include "Date.h"




string Date::toString()
{
	std::ostringstream ostr;
	ostr << "\""<< year << "-" << mont << "-" << day<<"\"";
	return ostr.str();
}
Date::Date(int year, int mont, int day)
{
	this->year = year;
	this->mont = mont;
	this->day = day;
}

Date::~Date()
{
}
