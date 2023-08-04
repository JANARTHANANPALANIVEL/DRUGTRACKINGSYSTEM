pragma solidity ^0.8.14;
//SPDX-License-Identifier: MIT


contract DrugTrackingSystem {
    // Define a struct to represent a drug
    struct Drug {
        uint256 id;
        string name;
        address owner;
        bool isTracked;
    }
    
    // Define a mapping to store drugs by ID
    mapping (uint256 => Drug) public drugs;
    
    // Define a mapping to store a drug's transaction history by ID
    mapping (uint256 => mapping(uint256 => address)) public drugTransactionHistory;
    
    // Define a variable to keep track of the current number of drugs
    uint256 public numDrugs;
    
    // Define a function to add a new drug
    function addDrug(string memory _name) public returns 

(uint256) {
        numDrugs++;
        drugs[numDrugs] = Drug(numDrugs, _name, msg.sender, true);
        drugTransactionHistory[numDrugs][1] = msg.sender;
        return numDrugs;
    }
    
    // Define a function to transfer ownership of a drug
    function transferDrug(uint256 _drugId, address _newOwner) public {
        require(drugs[_drugId].isTracked == true, "Drug is not tracked.");
        require(drugs[_drugId].owner == msg.sender, "Only the owner can transfer the drug.");
        drugs[_drugId].owner = _newOwner;
        uint256 transactionId = getNumTransactions(_drugId) + 1;
        drugTransactionHistory[_drugId][transactionId] = _newOwner;
    }
    
    // Define a function to get the number of transactions for a drug
    function getNumTransactions(uint256 _drugId) public view returns (uint256) {
        uint256 i = 1;
        while (drugTransactionHistory[_drugId][i] != address(0)) {
            i++;
        }

        return i - 1;
    }
}
