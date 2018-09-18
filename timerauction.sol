pragma solidity ^0.4.0;

import "./baseauction.sol";
contract TimerAuction is BaseAuction {

    string public item;
    uint public auctionEnd;
    address public maxBidder;
    uint public maxBid;

    event BidAccepted(address bidder, uint bid);

    function TimerAuction(uint _durationMinutes, string _item){
        item = _item;
        auctionEnd = now + (_durationMinutes * 1 minutes);
    }

    function () payable{
        //do somethings
    }

    function bid() payable{
        require(now < auctionEnd);
        require(msg.value > maxBid);

        if(maxBidder != 0){
            maxBidder.transfer(maxBid);
        }

        maxBidder = msg.sender;
        maxBid = msg.value;
        BidAccepted(maxBidder, maxBid);

    }
    function end() ownerOnly {
        //1)check conditions
        require(!ended);
        require(now >= auctionEnd);

        //20 Update state
        ended = true;
        AuctionComplete(maxBidder, maxBid);

        owner.transfer(maxBid);
    }
}
