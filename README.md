# Algoritmo Genético para Alocação de CTOs e CDOs

Este projeto implementa um algoritmo genético em Dart para resolver o problema de alocação de CTOs (Caixas de Terminação Óptica) e CDOs (Caixas de Distribuição Óptica) em um Provedor de Internet. O objetivo é minimizar os custos operacionais, respeitar as limitações de infraestrutura e maximizar a cobertura da rede.

## Como funciona

O algoritmo genético utiliza:
- **Soluções iniciais aleatórias** como ponto de partida.
- **Função de fitness** que avalia as soluções com base no custo total, cobertura e restrições.
- **Operadores genéticos** como crossover e mutação para gerar novas soluções.
- **Seleção** para manter os melhores indivíduos a cada geração.

### Entrada
- Lista de **clientes** com suas coordenadas (pontos de demanda).
- Lista de **possíveis localizações** para CTOs/CDOs.
- **Custos operacionais** e **cobertura máxima** permitida por cada CTO/CDO.

### Saída
- Melhor solução encontrada, representando os CTOs/CDOs alocados a cada cliente.
- Coordenadas dos CTOs/CDOs na melhor solução.
- Fitness da melhor solução.

## Requisitos

Certifique-se de ter o ambiente Dart instalado. Para mais detalhes, acesse [Dart Lang](https://dart.dev/).

## Como executar

1. Clone este repositório.
2. Navegue até o diretório do projeto.
3. Execute o arquivo principal com o comando:

   ```bash
   dart run <nome_do_arquivo>.dart
