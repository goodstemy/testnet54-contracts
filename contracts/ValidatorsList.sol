pragma solidity ^0.4.0;

contract ValidatorsList {
    address owner;
    address masterOfCeremony = 0xe091c3a55485bc1b09472d30a8a40ffb2c86d090;
    uint votesToBecameValidator = 1;
    
    address[] validators;
    address[] candidates;
    
    mapping(address => Candidate) _candidates;
    
    struct Candidate {
        address accountAddress;
        string fullName;
        string city;
        string minerCreation;
        string licenseExpiration;
        uint licenseId;
        uint votes;
        bool isValidator;
        bool isValue;
        mapping(address => bool) voters;
    }
    
    modifier isVoted(address validator, address candidate) {
        require(_candidates[candidate].voters[validator] == false);
        _;
    }
    
    modifier isValidator(address validator, address candidate) {
        bool isValidator = false;
        
        for (uint i = 0; i < validators.length; i++) {
            if (validators[i] == validator) isValidator = true;
        }
        
        require(isValidator == true);
        _;
    }
    
    modifier isCandidate(address candidate) {
        require(_candidates[candidate].isValue == true);
        _;
    }
    
    function ValidatorsList() public {
        validators.push(masterOfCeremony);
        
        _candidates[masterOfCeremony] = Candidate(
            0xe091c3a55485bc1b09472d30a8a40ffb2c86d090,
            "Ivan Efremov",
            "Kaliningrad",
            "27-03-2018",
            "1-01-2025",
            1,
            100,
            true,
            true
        );
    }
    
    function setCandidate(address accountAddress,
                          string fullName,
                          string city,
                          string minerCreation,
                          string licenseExpiration,
                          uint licenseId) public
    {
        assert(accountAddress != 0 || accountAddress != 0x0);
        assert(bytes(fullName).length != 0);
        assert(bytes(city).length != 0);
        assert(bytes(minerCreation).length != 0);
        assert(bytes(licenseExpiration).length != 0);
        assert(licenseId > 0);
        
        Candidate memory c = Candidate(
            accountAddress,
            fullName,
            city,
            minerCreation,
            licenseExpiration,
            licenseId,
            0,
            false,
            true
        );
        
        _candidates[accountAddress] = c;
        candidates.push(accountAddress);
    }
    
    function getValidators() public view returns (address[]) {
        address[] memory addrs = new address[](validators.length);
        
        for (uint i = 0; i < validators.length; i++) {
            addrs[i] = validators[i];
        }
        
        return (addrs);
    }
    
    function getCandidates() public view returns (address[]) {
        address[] memory addrs = new address[](candidates.length);
        
        for (uint i = 0; i < candidates.length; i++) {
            addrs[i] = candidates[i];
        }
        
        return (addrs);
    }
    
    function getCandidateByAddress(address accountAddress) public view returns (
        string fullName,
        string city,
        string minerCreation,
        string licenseExpiration,
        uint licenseId,
        uint votes,
        bool isValidator
    ) {
        assert(accountAddress != 0);
        assert(_candidates[accountAddress].isValue != false);
        
        return (
            _candidates[accountAddress].fullName,
            _candidates[accountAddress].city,
            _candidates[accountAddress].minerCreation,
            _candidates[accountAddress].licenseExpiration,
            _candidates[accountAddress].licenseId,
            _candidates[accountAddress].votes,
            _candidates[accountAddress].isValidator);
    }
    
    function vote(address validator, address candidate) 
        public
        isVoted(validator, candidate)
        isValidator(validator, candidate)
        isCandidate(candidate)
    {
        assert(_candidates[candidate].isValidator != true);
        
        _candidates[candidate].voters[candidate] = true;
        _candidates[candidate].votes++;
        
        if (_candidates[candidate].votes >= votesToBecameValidator) {
            _candidates[candidate].isValidator = true;
            validators.push(candidate);
            
            if (votesToBecameValidator <= 10) {
                votesToBecameValidator = validators.length;
            }
        }
        
        removeValidatorsFromCandidates(candidate);
    }
    
    function removeValidatorsFromCandidates(address candidate) private {
        if (_candidates[candidate].isValidator) {
            address[] c;
            
            for (uint i = 0; i < candidates.length; i++) {
                if (candidates[i] != candidate) {
                    c.push(candidates[i]);
                }
            }
            
            candidates = c;
        } else {
            return;
        }
    }
}