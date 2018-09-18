pragma solidity 0.4.24;

contract SimpleCounter { //file name does not have to be the same
    int counter; //state variable
    address owner;//address of owner
    
    constructor() public {
        counter = 0;
        owner = msg.sender;

    }

    function getCounter() view public returns(int){
        return counter;
    }
    function increment() public {
        // require(msg.value > 0.1 ether);
        counter += 1;

    }
    function decrement() public {
        counter -= 1;
    }
    function reset() public {
        require(msg.sender == owner);
        counter = 0;
    }
}
