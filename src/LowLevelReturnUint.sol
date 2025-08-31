// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

interface IBar {
    function bar() external returns (uint256);
}

contract LowLevelReturnUint {
    function main(address a) public returns (uint256) {
        // call function "bar()" on address a
        // do not use an interface
        // return the return value of the call
        return lowLevelCall(a);

        // bonus challenge: use an interface and a high level call to accomplish the same task
        //return highLevelCall(a);
    }

    function lowLevelCall(address a) private returns (uint256 value) {
        (bool ok, bytes memory data) = a.call(abi.encodeWithSignature("bar()"));
        require(ok, "Call failed");
        value = abi.decode(data, (uint256));
    }

    function highLevelCall(address a) private returns (uint256 value) {
        value = IBar(a).bar();
    }
}