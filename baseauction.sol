pragma solidity ^0.4.0;

import "./auction.sol";

contract baseAuction is Auction {

    address public owner;

    modifier ownerOnly(){
        require(msg.sender == owner);
        _;

    }

    event AuctionComplete(address winner, uint bid);
    function BaseAuction(){
        owner = msg.sender;
    }

}
