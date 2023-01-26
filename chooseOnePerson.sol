// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract chooseOnePerson {

    // structure to receive the array position if it exists
    struct OptionPosition {
        uint position;
        bool exists;
    }

    uint[] public votes;
    string[] public options;
    mapping(address => bool) hasVoted;
    mapping(string => OptionPosition) positionOfOption;


    constructor(string[] memory _options) public {
        options = _options;
        votes.length = options.length;

        for(uint i = 0; i < options.length; i++) {
            OptionPosition memory option = OptionPosition(i, true);
            positionOfOption[options[i]] = option;
        }
    }

    // It's possible to use the code to vote
    function voteByCode(uint option) public {

        // checking if the option exists
        require(option >= 0 && option < options.length, "Invalid Operation! Select a valid option.");

        // checking if user already voted
        require(!hasVoted[msg.sender], "This address has already voted");

        // putting on votes one more vote
        votes[option] += 1;

        // saving the user address
        hasVoted[msg.sender] = true;
    }

    // It's possible to use the name to vote
    function voteByName(string memory option) public {
        // checking if user already voted
        require(!hasVoted[msg.sender], "This address has already voted.");

        // Doing a copy from OptionPosition to optionPosition
        OptionPosition memory optionPosition = positionOfOption[option];

        // cheking if exists is true
        require(optionPosition.exists, "Option does not exist.");

        // putting the user hash like true
        hasVoted[msg.sender] = true;

        // inserting a new vote
        votes[optionPosition.position] += 1;
    }


    // This function get all options
    function getOption() public view returns(string[] memory) {
        return options;
    }

    // This function get all votes
    function getVotes() public view returns(uint[] memory) {
        return votes;
    }

}