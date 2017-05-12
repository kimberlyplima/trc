    clc
    clear all

    [FileName, PatchName] = uigetfile('*', 'Selecione o arquivo');
    diretorio = strcat(PatchName, FileName);

    IDarquivo = fopen(diretorio); 
    ConteudoArquivo = uint8(fread(IDarquivo, [1, inf], 'ubit1')); 
    Tam = length(ConteudoArquivo);

    for i = 1:8:Tam
        VetorComTrc = zeros(1,8);
        Contador = 0;
        
        for j = i:(i+7)
            if (ConteudoArquivo(j) == 1)
                Contador = Contador + 1;
            end
        end

        if (mod(Contador, 2) ~= 0)
            VetorComTrc(9) = 0;
        else
            VetorComTrc(9) = 1;
        end

        VetorComTrc(1) = ConteudoArquivo(i);
        VetorComTrc(2) = ConteudoArquivo(i+1);
        VetorComTrc(3) = ConteudoArquivo(i+2);
        VetorComTrc(4) = ConteudoArquivo(i+3);
        VetorComTrc(5) = ConteudoArquivo(i+4);
        VetorComTrc(6) = ConteudoArquivo(i+5);
        VetorComTrc(7) = ConteudoArquivo(i+6);
        VetorComTrc(8) = ConteudoArquivo(i+7);         

        Filecodif = fopen('BitsComTRC.bin', 'a+');
        fwrite(Filecodif, VetorComTrc, 'uint8');
        fclose(Filecodif);
    end