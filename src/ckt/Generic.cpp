#include "Generic.h"
#include <stdexcept>

Node::Node(const string& str): 
	name(str), 
	index(-1) 
{
}

void Node::setId(int id) {
	if(index == -1) index = id;
	else throw std::runtime_error(string("Wrong set Id for node ") + getName());
}

int Node::getId() const {
	if(index != -1) return index;
	else throw std::runtime_error(string("Wrong get Id  for node ") + getName());
}

Branch::Branch(const string& str): 
	name(str), 
	index(-1) 
{
}

int Branch::getId() const {
	if(index != -1) return index;
	else throw std::runtime_error(string("Wrong get Id for node ") + getName());
}

void Branch::setId(int id) {
	if(index == -1) index = id;
	else throw std::runtime_error(string("Wrong set Id  for node ") + getName());
}
