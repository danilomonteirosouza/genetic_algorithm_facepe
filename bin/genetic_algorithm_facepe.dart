import 'dart:math';

// Exemplo de dados (coordenadas x, y para pontos de demanda e CTO/CDO)
List<List<int>> clientes = [
  [2, 3],
  [5, 8],
  [1, 2],
  [7, 5],
  [6, 3]
];

List<List<int>> possiveisCtosCdos = [
  [3, 4],
  [6, 6],
  [5, 2],
  [8, 7],
  [2, 6]
];

// Custos de operação e cobertura máxima por CTO/CDO
List<int> custosOperacionais = [10, 15, 8, 20, 12];
List<int> coberturaMaxima = [3, 4, 2, 5, 3];

// Função de fitness: minimiza o custo total e maximiza a cobertura
double calcularFitness(List<int> solucao) {
  double fitness = 0.0;
  Map<int, int> alocacaoCtos = {for (int i = 0; i < possiveisCtosCdos.length; i++) i: 0};

  for (var cliente in clientes) {
    List<double> distancias = solucao
        .map((cto) =>
        sqrt(pow(cliente[0] - possiveisCtosCdos[cto][0], 2) + pow(cliente[1] - possiveisCtosCdos[cto][1], 2)))
        .toList();
    int ctoMaisProximo = solucao[distancias.indexOf(distancias.reduce(min))];
    alocacaoCtos[ctoMaisProximo] = alocacaoCtos[ctoMaisProximo]! + 1;
    fitness += distancias.reduce(min);
  }

  for (int cto = 0; cto < possiveisCtosCdos.length; cto++) {
    fitness += custosOperacionais[cto];
    if (alocacaoCtos[cto]! > coberturaMaxima[cto]) {
      fitness += (alocacaoCtos[cto]! - coberturaMaxima[cto]) * 100.0; // Penalidade alta
    }
  }

  return fitness;
}

// Gera uma solução inicial aleatória
List<int> gerarSolucaoInicial() {
  return List<int>.generate(clientes.length, (_) => Random().nextInt(possiveisCtosCdos.length));
}

// Crossover entre duas soluções
List<List<int>> crossover(List<int> pai1, List<int> pai2) {
  int pontoCorte = Random().nextInt(pai1.length - 1) + 1;
  List<int> filho1 = [...pai1.sublist(0, pontoCorte), ...pai2.sublist(pontoCorte)];
  List<int> filho2 = [...pai2.sublist(0, pontoCorte), ...pai1.sublist(pontoCorte)];
  return [filho1, filho2];
}

// Mutação de uma solução
void mutacao(List<int> solucao) {
  int indice = Random().nextInt(solucao.length);
  solucao[indice] = Random().nextInt(possiveisCtosCdos.length);
}

void main() {
  // Configurações do algoritmo genético
  int populacaoTamanho = 10;
  int numGeracoes = 50;
  double taxaMutacao = 0.1;

  // Inicializa a população
  List<List<int>> populacao =
  List<List<int>>.generate(populacaoTamanho, (_) => gerarSolucaoInicial());

  for (int geracao = 0; geracao < numGeracoes; geracao++) {
    // Avalia a população
    populacao.sort((a, b) => calcularFitness(a).compareTo(calcularFitness(b)));

    // Seleção dos melhores indivíduos
    int metadePopulacao = (populacaoTamanho / 2).floor();
    List<List<int>> novaPopulacao = populacao.sublist(0, metadePopulacao);

    // Recombinação (crossover)
    while (novaPopulacao.length < populacaoTamanho) {
      List<int> pai1 = novaPopulacao[Random().nextInt(metadePopulacao)];
      List<int> pai2 = novaPopulacao[Random().nextInt(metadePopulacao)];
      novaPopulacao.addAll(crossover(pai1, pai2));
    }

    // Aplica mutação
    for (var individuo in novaPopulacao) {
      if (Random().nextDouble() < taxaMutacao) {
        mutacao(individuo);
      }
    }

    populacao = novaPopulacao.take(populacaoTamanho).toList();
  }

  // Solução final
  List<int> melhorSolucao = populacao.reduce((a, b) =>
  calcularFitness(a) < calcularFitness(b) ? a : b);
  double melhorFitness = calcularFitness(melhorSolucao);
  List<List<int>> melhorCoordenadas =
  melhorSolucao.map((cto) => possiveisCtosCdos[cto]).toList();

  print('Melhor solução encontrada: $melhorSolucao');
  print('Fitness da melhor solução: $melhorFitness');
  print('Coordenadas da melhor solução: $melhorCoordenadas');
}