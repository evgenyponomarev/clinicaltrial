pragma solidity ^0.4.13;

import "./Ownable.sol";

library Library {
    struct TrialResults {
        bool is_placebo;
        uint test_result;
        uint8 flag;
    }

    function average(uint[] storage self, uint value) returns (uint) {

        // ....

        for (uint i = 0; i < self.length; i++)
            if (self[i].test_result == value) return i;
        return uint(-1);
    }
}

contract TrialExample {

    address public owner;

    uint public last_completed_migration;

    //mapping(patient_id => bool) public patients;

    // https://ethereum.stackexchange.com/questions/13021/how-can-you-figure-out-if-a-certain-key-exists-in-a-mapping-struct-defined-insi
    // https://stackoverflow.com/questions/41894337/does-ethereum-solidity-support-associative-arrays
    //mapping(uint => TrialResults[]) trialResults;

    using Library for Library.TrialResults;
    mapping(uint => Library.TrialResults) trialResults;

    // Upload map of patients and their class (patient_id => placebo/no)
    function uploadPatient(uint patient_id, uint is_placebo) onlyOwner external {

        if(trialResults[patient_id].flag != 1) {
            trialResults[patient_id] = list;
            trialResults[patient_id].flag = 1;
        }

        trialResults[patient_id].is_placebo = is_placebo;

    }

    // Upload particular patient results (patient_id => results)
    function uploadPatientResults(uint patient_id, uint test_result) external {

        if(trialResults[patient_id].flag != 1) {
            trialResults[patient_id] = list;
            trialResults[patient_id].flag = 1;
        }

        trialResults[patient_id].test_result = test_result;

    }

    // Calculate average result
    function getAggregatedResult() returns(uint) {

        return trialResults.average();

    }


}