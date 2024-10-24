// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ProductManager {
    struct Product {
        uint256 id;
        string name;
        uint256 quantity;
        uint256 price; // in wei
    }

    struct Sale {
        uint256 productId;
        address buyer;
        uint256 timestamp;
    }

    function getProductsPurchasedBy(
        Sale[] memory sales,
        Product[] memory products,
        address _customer
    ) public pure returns (Product[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < sales.length; i++) {
            if (sales[i].buyer == _customer) {
                count++;
            }
        }

        Product[] memory purchasedProducts = new Product[](count);
        uint256 index = 0;
        for (uint256 i = 0; i < sales.length; i++) {
            if (sales[i].buyer == _customer) {
                purchasedProducts[index] = products[sales[i].productId];
                index++;
            }
        }
        return purchasedProducts;
    }

    function calculateSalesAmount(
        Sale[] memory sales,
        Product[] memory products,
        uint256 _startTime,
        uint256 _endTime
    ) public pure returns (uint256) {
        uint256 totalAmount = 0;
        for (uint256 i = 0; i < sales.length; i++) {
            if (sales[i].timestamp >= _startTime && sales[i].timestamp <= _endTime) {
                totalAmount += products[sales[i].productId].price;
            }
        }
        return totalAmount;
    }
}

contract FashionCommerceManager is ProductManager {
    address public owner;

    Product[] public products;
    Sale[] public sales;
    uint256 public totalSales;

    event SaleRecorded(uint256 saleId, uint256 productId, address buyer, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // new product
    function addProduct(string memory _name, uint256 _quantity, uint256 _price) public onlyOwner returns (uint256 productId) {
        products.push(Product(products.length, _name, _quantity, _price));
        return products.length - 1;
    }

    // productID info
    function getProduct(uint256 _productId) public view returns (Product memory) {
        require(_productId < products.length, "Product does not exist");
        return products[_productId];
    }

    // purchase
    function purchaseProduct(uint256 _productId) public payable {
        Product storage product = products[_productId];
        require(product.quantity > 0, "Product out of stock");
        require(msg.value >= product.price, "Insufficient payment");

        // register sale
        sales.push(Sale(_productId, msg.sender, block.timestamp));
        totalSales++;

        emit SaleRecorded(sales.length - 1, _productId, msg.sender, block.timestamp);
    }

    // withdraw
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // Function to retrieve a sale by ID
    function getSale(uint256 _saleId) public view returns (Sale memory) {
        require(_saleId < sales.length, "Sale does not exist");
        return sales[_saleId];
    }
}
