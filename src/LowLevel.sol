// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

interface IFoo {
    function foo() external;
}

contract LowLevel {
    function main(address a) public returns (bool) {
        // call function "foo()" on address a
        // do not use an interface, use a low level call
        // return true if the call succeeded
        // return false if the call failed
        return lowLevelCall(a);

        // bonus challenge: use an interface and a high level call to accomplish the same task
        //return highLevelCall(a);
    }

    function lowLevelCall(address a) private returns (bool) {
        (bool ok, ) = a.call(abi.encodeWithSignature("foo()"));
        return ok;
    }

    function highLevelCall(address a) private returns (bool) {
        try IFoo(a).foo() {
            return true;
        } catch {
            return false;
        }
    }
}
