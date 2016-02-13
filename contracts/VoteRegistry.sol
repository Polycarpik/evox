contract VoteRegistry {
    
    address public owner;

    event Provider(address provider);
    event Poll(address poll);
    
    mapping(address => uint) public provIndex;
    address[] public providers;
    string[] public provNames;
    address[] public owners;
    
    mapping(address => uint) public pollIndex;
    string[] public pollNames;
    address[] public polls;
    
    function VoteRegistry() {
        providers.length++;
        provNames.length++;
        owners.length++;
        pollNames.length++;
        polls.length++;
    }
    
    modifier onlyOwner(address _provider) {
        uint pos = provIndex[_provider];
        if (pos == 0) {
            return;
        }
        if (tx.origin == owners[pos] || tx.origin == owner) {
            _
        }
    }
    
    function addProvider(address _provider, string _name) returns (bool) {
        if (provIndex[_provider] > 0){
            return false;
        }
        uint pos = 0;
        for (uint i = 1; i < providers.length; ++i) {
            if (providers[i] == 0) {
                pos = i;
                break;
            }
        }
        if (pos == 0) {
            pos = providers.length++;
            provNames.length++;
            owners.length++;
        }
        providers[pos] = _provider;
        provNames[pos] = _name;
        owners[pos] = tx.origin;
        provIndex[_provider] = pos;
        Provider(_provider);
        return true;
    }
    
    function remProvider(address _provider) onlyOwner(_provider) returns (bool) {
        uint pos = provIndex[_provider];
        if (pos == 0) {
            return false;
        }
        providers[pos] = 0;
        provNames[pos] = "";
        owners[pos] = 0;
        delete provIndex[_provider];
        return true;
    }
    
    function addPoll(address _poll, string _name) returns (bool) {
        if (pollIndex[_poll] == 0){
            uint pos = polls.length++;
            pollNames.length++;
            polls[pos] = _poll;
            pollNames[pos] = _name;
            pollIndex[_poll] = pos;
            Poll(_poll);
            return true;
        }
        return false;
    }

}
