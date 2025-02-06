// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Marketplace {
    IERC20 public token;

    struct AIModel {
        uint256 id;
        string name;
        string description;
        uint256 price;
        address seller;
        bool sold;
    }

    AIModel[] public models;
    mapping(uint256 => address) public modelToBuyer;

    event ModelListed(uint256 id, string name, uint256 price, address seller);
    event ModelSold(uint256 id, address buyer);

    constructor(address tokenAddress) {
        token = IERC20(tokenAddress);
    }

    function listModel(string memory _name, string memory _description, uint256 _price) public {
        require(_price > 0, "Price must be greater than zero");

        uint256 modelId = models.length;
        models.push(AIModel(modelId, _name, _description, _price, msg.sender, false));

        emit ModelListed(modelId, _name, _price, msg.sender);
    }

    function buyModel(uint256 _id) public {
        require(_id < models.length, "Model does not exist");
        AIModel storage model = models[_id];
        require(!model.sold, "Model already sold");
        require(token.transferFrom(msg.sender, model.seller, model.price), "Token transfer failed");

        model.sold = true;
        modelToBuyer[_id] = msg.sender;

        emit ModelSold(_id, msg.sender);
    }

    function getModels() public view returns (AIModel[] memory) {
        return models;
    }
}
