// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

interface IBaz {
    function baz() external returns (string memory);
}

contract LowLevelReturnString {
    function main(address a) public returns (string memory) {
        // call function "baz()" on address a
        // do not use an interface
        // baz() returns a string. Return the string.
        // However, if baz reverts, return an empty string 
        return lowLevelCall(a);

        // bonus challenge: use an interface and a high level call to accomplish the same task
        //return highLevelCall(a);
    }

    function lowLevelCall(address a) private returns (string memory value) {
        (bool ok, bytes memory data) = a.call(abi.encodeWithSignature("baz()"));
        if (ok) {
            value = abi.decode(data, (string));
        }
    }

    function highLevelCall(address a) private returns (string memory) {
        try IBaz(a).baz() returns (string memory value) {
            return value;
        } catch {
            return "";
        }
    }
}
