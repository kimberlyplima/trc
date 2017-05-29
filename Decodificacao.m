    clc
    clear all

    [FileName, PatchName] = uigetfile('*', 'Selecione o arquivo');
    diretorio = strcat(PatchName, FileName);
    
    IDarquivo = fopen(diretorio); 
    BitsCorrompidosComTRC = uint8(fread(IDarquivo, [1, inf], 'ubit1'));
    Tam = length(BitsCorrompidosComTRC);
    
    for p = 7:-1:0
        x = (Tam - p)/9;
        
        if (round(x) == x)
            Contador = 9*x;
            Padding = p;
            break
        end
    end
    
    VetorTemporario = cell(0);
    
    for i = 1:9:Contador
        if (i == 1)
            VetorTemporario = BitsCorrompidosComTRC(i:i+7);
        else
            VetorTemporario = cat(2,VetorTemporario,BitsCorrompidosComTRC(i:i+7));
        end
        
        ContadorDeUm = numel(find(BitsCorrompidosComTRC(i:i+7) == 1));
        
        if (mod(ContadorDeUm, 2) ~= 0)
            VetorTemporario(length(VetorTemporario)+1) = 0;
        else
            VetorTemporario(length(VetorTemporario)+1) = 1;
        end
    end
   
    if (Padding ~= 0)
        if (Padding > 1)
            Padding = zeros(1,Padding);
            VetorTemporario = cat(2,VetorTemporario,Padding);
        else
            VetorTemporario = cat(2,VetorTemporario,Padding);
        end
    end
  
    BitsCorrompidos = numel(find(xor(BitsCorrompidosComTRC, VetorTemporario) == 1));
    BitsCorrompidos