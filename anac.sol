// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title ANAC - Gestão de Idade para Passageiros
contract Anac {
    uint256 private idade = 18; // Idade inicial padrão
    address private dono;
    bool private isBrasileiro;

    /// @dev Define o dono do contrato e a nacionalidade do passageiro
    constructor(bool _isBrasileiro) {
        dono = msg.sender;
        isBrasileiro = _isBrasileiro;
    }

    /// @dev Restrição para permitir apenas o dono modificar a idade
    modifier apenasDono() {
        require(msg.sender == dono, "Somente o dono pode alterar a idade");
        _;
    }

    /// @dev Atualiza a idade do passageiro
    function setIdade(uint256 _idade) public apenasDono {
        require(_idade >= 0, "Idade invalida");
        idade = _idade;
    }

    /// @dev Retorna a idade do passageiro
    function getIdade() public view returns (uint256) {
        return idade;
    }

    /// @dev Retorna a documentação necessária conforme idade e nacionalidade
    function getDocumentacaoNecessaria() public view returns (string memory) {
        if (isBrasileiro) {
            return idade >= 18 ? "RG ou CNH" : "Certidao de nascimento e autorizacao dos responsaveis";
        } 
        return "Passaporte e visto (se aplicavel)";
    }

    /// @dev Retorna a categoria do passageiro
    function getCategoriaPassageiro() public view returns (string memory) {
        if (isBrasileiro) {
            return idade >= 18 ? "Adulto Brasileiro" : "Crianca ou Adolescente Brasileiro";
        }
        return "Estrangeiro";
    }
}
