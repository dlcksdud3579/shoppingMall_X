#include "List.h"



List::List()
{
}

string List::toString()
{
	std::ostringstream ostr;
	vector<Tuple*>::iterator iter = val.begin();
//	for (iter = val.begin(); iter != val.end(); ++iter)
//	{
		ostr << iter[0]->toString();
//	}
	ostr << endl;
	return ostr.str();
}
Tuple* List::getTuple(int _index)
{
	if(val.size() >_index)
		return val.at(_index);
	return NULL;
}
List::~List()
{
}
