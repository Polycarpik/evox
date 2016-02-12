
contract IdentityProvider {
    
    address public owner;

    event Request(address indexed applicant, bytes32 indexed request, uint256 hash);
    event Reject(address indexed applicant);
    event Accept(address indexed applicant);
    event Remove(address indexed applicant);

    mapping(address => uint) public index;
    bytes32[] public requests;
    address[] public applicants;
    uint256[] public hashes;

    mapping(address => bool) public members;

    function IdentityProvider(){
        owner = tx.origin;
        applicants.length++;
        requests.length++;
        hashes.length++;
    }
    
    modifier onlyOwner {
        if (msg.sender == owner || tx.origin == owner) {
            _
        }
    }
    
    function setOwner(address _newOwner) onlyOwner returns (bool) {
        owner = _newOwner;
        return true;
    }

    function isMember(address _member) constant returns (bool) {
        return members[_member];
    }

    function addMember(address _applicant) onlyOwner returns (bool) {
        uint pos = index[_applicant];
        if (0 == pos) {
            return false;
        }
        delete index[_applicant];
        applicants[pos] = 0;
        requests[pos] = 0;
        hashes[pos] = 0;
        members[_applicant] = true;
        Accept(_applicant);
        return true;
    }

    function remMember(address _member) onlyOwner returns (bool) {
        if (!members[_member]) {
            return false;
        }
        delete members[_member];
        Remove(_member);
        return true;
    }

    function request(address _applicant, bytes32 _request, uint256 _hash) returns (bool) {
        if (0 > index[_applicant]) {
            return false;
        }
        uint pos = 0;
        for (uint i = 1; i < applicants.length; ++i) {
            if (applicants[i] == 0) {
                pos = i;
                break;
            }
        }
        if (pos == 0) {
        pos = applicants.length++;
        requests.length++;
        hashes.length++;
        }
        applicants[pos] = _applicant;
        requests[pos] = _request;
        hashes[pos] = _hash;
        index[_applicant] = pos;
        Request(_applicant, _request, _hash);
        return true;
    }

    function reject(address _applicant) onlyOwner returns (bool) {
        uint pos = index[_applicant];
        if (0 == pos) {
            return false;
        }
        delete index[_applicant];
        applicants[pos] = 0;
        requests[pos] = 0;
        hashes[pos] = 0;
        Reject(_applicant);
        return true;
    }

}
