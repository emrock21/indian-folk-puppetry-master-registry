// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract IndianPuppetryRegistry {

    struct PuppetryStyle {
        string region;               // Rajasthan, Karnataka, Odisha, etc.
        string lineageOrWorkshop;    // Bhatt family, Togalu Gombeyaata troupes, etc.
        string styleName;            // Kathputli, Bommalattam, Kundhei, etc.
        string materials;            // wood, leather, cloth, natural dyes
        string mechanism;            // string, rod, glove, shadow
        string performanceTraits;    // music, narration, movement style
        string uniqueness;           // cultural distinctiveness
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct StyleInput {
        string region;
        string lineageOrWorkshop;
        string styleName;
        string materials;
        string mechanism;
        string performanceTraits;
        string uniqueness;
    }

    PuppetryStyle[] public styles;

    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event StyleRecorded(
        uint256 indexed id,
        string styleName,
        string lineageOrWorkshop,
        address indexed creator
    );

    event StyleVoted(
        uint256 indexed id,
        bool like,
        uint256 likes,
        uint256 dislikes
    );

    constructor() {
        styles.push(
            PuppetryStyle({
                region: "India",
                lineageOrWorkshop: "ExampleWorkshop",
                styleName: "Example Style (replace with real entries)",
                materials: "example materials",
                mechanism: "example mechanism",
                performanceTraits: "example traits",
                uniqueness: "example uniqueness",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordStyle(StyleInput calldata s) external {
        styles.push(
            PuppetryStyle({
                region: s.region,
                lineageOrWorkshop: s.lineageOrWorkshop,
                styleName: s.styleName,
                materials: s.materials,
                mechanism: s.mechanism,
                performanceTraits: s.performanceTraits,
                uniqueness: s.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit StyleRecorded(
            styles.length - 1,
            s.styleName,
            s.lineageOrWorkshop,
            msg.sender
        );
    }

    function voteStyle(uint256 id, bool like) external {
        require(id < styles.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;

        PuppetryStyle storage p = styles[id];

        if (like) {
            p.likes += 1;
        } else {
            p.dislikes += 1;
        }

        emit StyleVoted(id, like, p.likes, p.dislikes);
    }

    function totalStyles() external view returns (uint256) {
        return styles.length;
    }
}
