    clc
    clear all

    [FileName, PatchName] = uigetfile('*', 'Selecione o arquivo');
    diretorio = strcat(PatchName, FileName);

    IDarquivo = fopen(diretorio); 
    ConteudoArquivo = uint8(fread(IDarquivo, [1, inf], 'ubit1')); 
    Tam = length(ConteudoArquivo);
    
    VetorTemporario = cell(0);
    
    for i = 1:8:Tam
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

    Filecodif = fopen('BitsComTRC.bin', 'wb');
    fwrite(Filecodif, VetorTemporario, 'ubit1');
    fclose(Filecodif);