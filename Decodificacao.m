    clc
    clear all

    IDarquivo = fopen('BitsCorrompidosComTRC.bin', 'r'); 
    ConteudoArquivo = uint8(fread(IDarquivo, [1, inf], 'ubit1'));
    Contador = length(ConteudoArquivo);

    for i = Contador:-1:1
        if (mod(i,9) == 0)
           Contador = i;
           break
        end
    end
    
    VetorTemporario = cell(0);
    
    for i = 1:9:Contador
        if (i == 1)
            VetorTemporario = ConteudoArquivo(i:i+7);
        else
            VetorTemporario = cat(2,VetorTemporario,ConteudoArquivo(i:i+7));
        end
        
        ContadorDeUm = numel(find(ConteudoArquivo(i:i+7) == 1));
        
        if (mod(ContadorDeUm, 2) ~= 0)
            VetorTemporario(length(VetorTemporario)+1) = 0;
        else
            VetorTemporario(length(VetorTemporario)+1) = 1;
        end
    end
    
    Padding = zeros(1, (length(ConteudoArquivo) - Contador));
    VetorTemporario = cat(2,VetorTemporario,Padding);    
    BitCorrompido = find(xor(ConteudoArquivo, VetorTemporario) == 1);