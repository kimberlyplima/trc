    clc
    clear all

    [FileName, PatchName] = uigetfile('*', 'Selecione o arquivo');
    diretorio = strcat(PatchName, FileName);

    IDarquivo = fopen(diretorio); 
    BitsComTrc = uint8(fread(IDarquivo, [1, inf], 'ubit1'));
    Tam = length(BitsComTrc);
    BitsCorrompidos = 0;
    
    for p = 7:-1:0
        x = (Tam - p)/9;
        
        if (round(x) == x)
            Contador = 9*x;
            break
        end
    end
        
    for i = 1:Contador
       BitACorromper = randi(Tam);

       if (rand(1) <= 0.03)
            BitsComTrc(BitACorromper) = not(BitsComTrc(BitACorromper));
            BitsCorrompidos = BitsCorrompidos + 1;
       end
    end
    
    BitsCorrompidos

    Filecodif = fopen('BitsCorrompidosComTRC.bin', 'wb');
    fwrite(Filecodif, BitsComTrc, 'ubit1');
    fclose(Filecodif);