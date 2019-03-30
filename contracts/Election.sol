pragma solidity ^0.5.0;

contract Election {


	//model a candidate 

	struct Candidate{  //structure type
		uint id; //unsigned int
		string name;
		uint voteCount; 
	}

	//store candidate

	mapping(uint => Candidate) public candidates; //hashmap (key value pair) //when candidate is added, we are changing the state of our contract and we are writing to the blockchain
	mapping(address => bool) public voters; //whether a voter has voted or not //default value of the bool is false
	//store candidate count
	uint public candidatesCount; //to keep track of number of candidates because you cannot say candidates.size

	
	// constructor
	constructor() public{
		//this will be executed when the contract is migrated and deployed
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
	}

	function addCandidate(string memory _name) private { //local variable prepended with an underscore
		candidatesCount++; 
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);  //instantiate a structure //vote count 0 initially
	}

	function vote(uint _candidateId) public{
	    
		//require that they have not voted before
		require(!voters[msg.sender]); //require function - if we get true then the following code is executed else the execution stops
		
		//simiar to
		//if(condition)
		//  return

		//require a valid candidate
		require(_candidateId > 0  && _candidateId <= candidatesCount);  //if the candidate votes for an invalid candidate then the gas will not be returned or if there is any bug in the code that converts valid to an invalid candidate, the user will suffer gas loss. So ensure that the contract is bug free.

		//if require is found false, then the gas used uptill this part will not be returned back. Ofcourse, no gas will be used for the code below because that code wont be executed.

		//record that voter has voted 
		//we can get metadata which will have the data (address) of the person calling this function
		voters[msg.sender] = true; //sender is the account  

		//update vote count
		candidates[_candidateId].voteCount ++;
	}
}