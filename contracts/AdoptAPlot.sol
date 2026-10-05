// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Adopt-a-Plot
/// @notice Blockchain-based Organic Farming Platform
/// @dev Users adopt virtual farming plots on-chain; each plot records
///      the owner, crop type, growth status and whether it is active.
contract AdoptAPlot {
    /// @notice A single adopted farming plot.
    struct Plot {
        uint256 id;        // Unique plot id
        address owner;     // Address that adopted this plot
        string cropType;   // What is being grown (e.g. "Organic Tomato")
        string status;     // Growth status (e.g. "Seedling", "Growing", "Harvested")
        bool isActive;     // Whether the plot still exists
    }

    /// @notice All adopted plots, keyed by plot id (id starts at 1).
    mapping(uint256 => Plot) public plots;

    /// @notice Total number of plots adopted so far.
    uint256 public plotCount;

    /// @notice Adopt a new plot with the given crop type.
    /// @param _cropType The crop type to grow on the new plot.
    /// @dev Each new plot starts with status "Seedling" and is active.
    function adoptPlot(string memory _cropType) public {
        plotCount += 1;
        plots[plotCount] = Plot(plotCount, msg.sender, _cropType, "Seedling", true);
    }

    /// @notice Update the growth status of a plot.
    /// @param _id The plot id to update.
    /// @param _newStatus The new status string (e.g. "Growing", "Harvested").
    /// @dev Only the plot owner can update the status.
    function updatePlotStatus(uint256 _id, string memory _newStatus) public {
        require(plots[_id].isActive, "Plot does not exist.");
        require(plots[_id].owner == msg.sender, "Only the owner can update the status.");
        plots[_id].status = _newStatus;
    }

    /// @notice Read the basic details of a plot (id, owner, crop type, status).
    /// @param _id The plot id to read.
    /// @return The plot id, owner address, crop type and current status.
    function getPlot(uint256 _id) public view returns (uint256, address, string memory, string memory) {
        Plot storage p = plots[_id];
        return (p.id, p.owner, p.cropType, p.status);
    }
}
