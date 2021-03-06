#include "Tuple.h"



Tuple::Tuple(string tableName)
{
	this->tableName = tableName;
}
string Tuple::toString()
{ 
	std::ostringstream ostr;
	ostr << "INSERT INTO ";
	ostr << tableName<<" VALUES ( ";

	vector<Data*>::iterator iter = val.begin();
	for(iter = val.begin(); iter != val.end(); ++iter)
	{
		ostr << iter[0]->toString();
		if(iter+1 != val.end())
			ostr << ", ";
	}
	ostr << " );" << endl;
	return ostr.str();
}
Data* Tuple::getDate(int _index)
{
	if(val.size() > _index)
		return  this->val.at(_index);
	return NULL;
}

Tuple::~Tuple()
{
}
