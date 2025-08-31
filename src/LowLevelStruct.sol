// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

interface IPoint {
    function point() external returns (uint256 x, uint256 y);
}

contract LowLevelStruct {
    function main(address a) public returns (uint256 x, uint256 y) {
        // call function "point()" on address a
        // do not use an interface
        // point() returns a struct with two uint256 fields, i.e. 
        // struct Point {
        //     uint256 x;
        //     uint256 y;
        // }
        // return the two fields
        // revert if the low level call reverts
        return lowLevelCall(a);

        // bonus challenge: use an interface and a high level call to accomplish the same task
        //return highLevelCall(a);
    }

    function lowLevelCall(address a) private returns (uint256 x, uint256 y) {
        (bool ok, bytes memory data) = a.call(
            abi.encodeWithSignature("point()")
        );
        require(ok, "Call failed");
        (x, y) = abi.decode(data, (uint256, uint256));
    }

    function highLevelCall(address a) private returns (uint256 x, uint256 y) {
        return IPoint(a).point();
    }
}   