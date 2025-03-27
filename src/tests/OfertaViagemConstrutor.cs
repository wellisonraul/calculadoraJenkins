namespace JornadaMilhas.Tests;
using JornadaMilhasV1.Modelos;

public class OfertaViagemConstrutor
{
    // [Theory]
    // [InlineData("Recife", "São Paulo", "2025-03-26", "2025-03-28", 1000, true)]
    // [InlineData(null, "São Paulo", "2025-03-26", "2025-03-28", 1000, false)]
    // [InlineData(null, "São Paulo", "2025-01-01", "2025-01-02", -1, false)] // #5 Passar validação, passar no paramêtro
    // [InlineData("Vitória", "São Paulo", "2025-01-01", "2025-01-01", 0, true)] // #8  
    // [InlineData("Rio de Janeiro", "São Paulo", "2025-01-01", "2025-01-02", -500, true)]  // #8
    // public void RetornaOfertaValidaQuandoDadosValidos(string origem, string destino, string dataIda, string dataVolta, double preco, bool validacao)
    // {
    //     // Arrange
    //     Rota rota = new Rota(origem, destino);
    //     Periodo periodo = new Periodo(DateTime.Parse(dataIda), DateTime.Parse(dataVolta));

    //     // Act
    //     OfertaViagem oferta = new OfertaViagem(rota, periodo, preco);

    //     // Assert  
    //     Assert.Equal(validacao, oferta.EhValido);
    // }

    [Fact]
    public void RetornaOfertaInvalidaQuandoPrecoNegativo()
    {
        // Arrange
        Rota rota = new Rota("Recife", "São Paulo");
        Periodo periodo = new Periodo(new DateTime(2025, 3, 26), new DateTime(2025, 3, 28));
        double preco = -250;

        // Act
        OfertaViagem oferta = new OfertaViagem(rota, periodo, preco);

        // Assert  
        Assert.Contains("O preço da oferta de viagem deve ser maior que zero.", oferta.Erros.Sumario);
    }

    [Fact]
    public void RetornaPrecoComDescontoCorreto()
    {

        // Arrange
        Rota rota = new Rota("Recife", "São Paulo");
        Periodo periodo = new Periodo(new DateTime(2025, 3, 26), new DateTime(2025, 3, 28));
        double precoOriginal = 100;
        double desconto = 20;
        double precoComDesconto = precoOriginal - desconto;
        
        OfertaViagem oferta = new OfertaViagem(rota, periodo, precoOriginal);

        // Act
        oferta.Desconto = desconto;

        // Assert
        Assert.Equal(precoComDesconto, oferta.Preco);
    }

     [Theory]
    [InlineData(120, 30)]
    [InlineData(100, 30)]
    [InlineData(80, 20)]
    public void RetornaDescontoMaximoQuandoValorDescontoMaiorOuIgualQuePreco(double desconto, double precoComDesconto)
    {

        // Arrange
        Rota rota = new Rota("Recife", "São Paulo");
        Periodo periodo = new Periodo(new DateTime(2025, 3, 26), new DateTime(2025, 3, 28));
        double precoOriginal = 100;
        
        OfertaViagem oferta = new OfertaViagem(rota, periodo, precoOriginal);

        // Act
        oferta.Desconto = desconto;

        // Assert
        Assert.Equal(precoComDesconto, oferta.Preco, 0.0001);
    }

    [Fact]
    public void RetornaTresErrosDeValidacaoQuandoRotaPeriodoEPRecoSaoInvalidos()
    {
        // Setup
        int quantidadeEsperada = 3; // #5
        Rota rota = null; // #4
        Periodo periodo = new Periodo(new DateTime(2024, 6, 1), new DateTime(2024, 5, 10)); // #4
        double preco = -100; 
    
        // Act
        OfertaViagem oferta = new OfertaViagem(rota, periodo, preco);

    
        // Assert
        Assert.Equal(quantidadeEsperada, oferta.Erros.Count());
    }

}