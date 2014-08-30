#include "Generic.h"
#include <stdexcept>

Node::Node(const string& str): 
	name(str), 
	index(-1)
{
}

void Node::setId(unsigned int id) {
	if(index == -1) index = id;
	else throw std::runtime_error(string("Wrong set Id for node ") + getName());
}

unsigned int Node::getId() const {
	if(index != -1) return index;
	else throw std::runtime_error(string("Wrong get Id  for node ") + getName());
}

Branch::Branch(const string& str): 
	name(str), 
	index(-1) 
{
}

unsigned int Branch::getId() const {
	if(index != -1) return index;
	else throw std::runtime_error(string("Wrong get Id for node ") + getName());
}

void Branch::setId(unsigned int id) {
	if(index == -1) index = id;
	else throw std::runtime_error(string("Wrong set Id  for node ") + getName());
}
