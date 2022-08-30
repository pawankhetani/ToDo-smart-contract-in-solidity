// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.5.0;

contract ToDoApp {

    struct Task {
        string title;
        string body;
        bool completed;
    }

    mapping(address => Task[]) private user;

    event TaskCreated(
        uint taskNo,
        address user,
        string title,
        string body,
        bool completed
    );

    function createTask(string calldata _title, string calldata _body) external {
        user[msg.sender].push(Task(_title, _body, false));
        emit TaskCreated(user[msg.sender].length+1, msg.sender, _title, _body, false);
    }

    function viewTask(uint taskNo) public view returns (string memory, string memory, bool) {
        require(taskNo < user[msg.sender].length, "Task doesn't exsist");
        return(user[msg.sender][taskNo].title, user[msg.sender][taskNo].body, user[msg.sender][taskNo].completed);
    }

    function checkTask(uint taskNo) public {
        require(taskNo < user[msg.sender].length, "Task doesnt exsist");
        user[msg.sender][taskNo].completed = !user[msg.sender][taskNo].completed;
    }
}
