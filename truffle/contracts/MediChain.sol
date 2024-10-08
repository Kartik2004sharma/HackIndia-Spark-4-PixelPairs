// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

contract MediChain {
    // State Variables
    string public name;
    address[] public patientList;
    address[] public doctorList;
    address[] public insurerList;
    Policy[] public policyList;
    uint public claimsCount;
    uint public transactionCount;
    
    mapping (uint => Claims) public claims;
    mapping (uint => Transactions) public transactions;
    mapping (address => Patient) public patientInfo;
    mapping (address => Doctor) public doctorInfo;
    mapping (address => Insurer) public insurerInfo;
    mapping (string => address) public emailToAddress;
    mapping (string => uint) public emailToDesignation;

    struct Patient {
        string name;
        string email;
        uint age;
        string record;
        bool exists;
        bool policyActive;
        Policy policy;
        uint[] transactions;
        address[] doctorAccessList;
    }

    struct Doctor {
        string name;
        string email;
        bool exists;
        uint[] transactions;
        address[] patientAccessList;
    }

    struct Insurer {
        string name;
        string email;
        bool exists;
        Policy[] policies;
        address[] patients;
        uint[] claims;
        uint[] transactions;
    }

    struct Policy {
        uint id;
        address insurer;
        string name;
        uint coverValue;
        uint timePeriod;
        uint premium;
    }

    struct Claims {
        address doctor;
        address patient;
        address insurer;
        string policyName;
        string record;
        uint valueClaimed;
        bool approved;
        bool rejected;
        uint transactionId;
    }

    struct Transactions {
        address sender;
        address receiver;
        uint value;
        bool settled;
    }

    constructor() {
        name = "mediChain";
        claimsCount = 0;
        transactionCount = 0;
    }

    // Register a patient, doctor, or insurer
    function register(
        string memory _name,
        uint _age,
        uint _designation, // 1 - Patient, 2 - Doctor, 3 - Insurer
        string memory _email,
        string memory _hash
    ) public {
        require(msg.sender != address(0), "Invalid address");
        require(bytes(_name).length > 0, "Name is required");
        require(bytes(_email).length > 0, "Email is required");
        require(emailToAddress[_email] == address(0), "Email already in use");
        require(emailToDesignation[_email] == 0, "Email already has a designation");

        address _addr = msg.sender;
        require(!patientInfo[_addr].exists && !doctorInfo[_addr].exists && !insurerInfo[_addr].exists, "Address already registered");

        if (_designation == 1) {
            require(_age > 0, "Age is required for patients");
            require(bytes(_hash).length > 0, "Medical record hash is required");
            
            Patient storage pinfo = patientInfo[_addr];
            pinfo.name = _name;
            pinfo.email = _email;
            pinfo.age = _age;
            pinfo.record = _hash;
            pinfo.exists = true;
            patientList.push(_addr);

            emailToAddress[_email] = _addr;
            emailToDesignation[_email] = _designation;

        } else if (_designation == 2) {
            Doctor storage dinfo = doctorInfo[_addr];
            dinfo.name = _name;
            dinfo.email = _email;
            dinfo.exists = true;
            doctorList.push(_addr);

            emailToAddress[_email] = _addr;
            emailToDesignation[_email] = _designation;

        } else if (_designation == 3) {
            Insurer storage iinfo = insurerInfo[_addr];
            iinfo.name = _name;
            iinfo.email = _email;
            iinfo.exists = true;
            insurerList.push(_addr);

            emailToAddress[_email] = _addr;
            emailToDesignation[_email] = _designation;

        } else {
            revert("Invalid designation");
        }
    }

    // Login to get designation
    function login(address _addr) public view returns (uint) {
        require(_addr != address(0), "Invalid address");

        if (patientInfo[_addr].exists) {
            return 1; // Patient
        } else if (doctorInfo[_addr].exists) {
            return 2; // Doctor
        } else if (insurerInfo[_addr].exists) {
            return 3; // Insurer
        } else {
            return 0; // Not registered
        }
    }

    // Patient gives access to a doctor
    function permitAccess(string memory _email) public {
        require(bytes(_email).length > 0, "Invalid email");
        require(msg.sender != address(0), "Invalid sender");

        address _addr = emailToAddress[_email];
        require(_addr != address(0), "Doctor not found");
        require(doctorInfo[_addr].exists, "Address is not a doctor");
        require(patientInfo[msg.sender].exists, "Sender is not a patient");

        Doctor storage dinfo = doctorInfo[_addr];
        Patient storage pinfo = patientInfo[msg.sender];

        dinfo.patientAccessList.push(msg.sender);
        pinfo.doctorAccessList.push(_addr);
    }

    // Other functions (buyPolicy, claim request, etc.) would stay as they are.
    // We assume that checks for policy payments and claim approvals/rejections are handled as required.
    // Removed unnecessary variables and improved error messaging for clarity.
    
    // Called internally to remove from list
    function removeFromList(address[] storage Array, address addr) internal returns (uint) {
        require(addr != address(0), "Invalid address");

        uint index;
        bool found = false;

        for (uint i = 0; i < Array.length; i++) {
            if (Array[i] == addr) {
                index = i;
                found = true;
                break;
            }
        }

        require(found, "Address not found in list");

        // Remove by swapping with the last element and popping the last one
        if (Array.length > 1) {
            Array[index] = Array[Array.length - 1];
        }
        Array.pop();
        
        return index;
    }
}