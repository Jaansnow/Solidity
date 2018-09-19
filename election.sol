pragma solidity ^0.4.0;

contract Election {

    struct Candidate {
        string name; //name
        uint voteCount; //number of votes

    }

    struct Voter {
        bool voted; //hasvoted
        uint vote;
        uint weight;

    }

    address public owner; //owner of contract
    mapping (address => Voter) voters;
    Candidate [] public candidates; //dynamitcally

    event ElectionResult(string name, uint voteCount);

    function Election (string name, string name1, string name2) {
        //function cannot return two dimensional array
        owner = msg.sender;
        name = name;

        candidates.push(Candidate({name: name1, voteCount: 0}));
        candidates.push(Candidate({name: name2, voteCount: 0}));


    }

    function authorize(address voter) {
        require(msg.sender == owner);
        require(!voters[voter].voted);

        voters[voter].weight = 1;

    }

    function vote (uint voteIndex ) {
        require(!voters[msg.sender].voted); //have not voted before

        voters[msg.sender].vote = voteIndex; //record vote
        voters[msg.sender].voted = true; // they can no longer call vote

        candidates[voteIndex].voteCount += voters[msg.sender].weight; //increase vote count

    }

    function end () {
        require(msg.sender == owner);

        for( uint i=0; i< candidates.length; i++){
            ElectionResult(candidates[i].name, candidates[i].voteCount);
        }

        selfdestruct(owner);
    }

}
