function bool = isValid(row,col,mat)

[a,b] = size(mat);
if (row > 0 && row < a+1) && (col > 0 && col < b+1)
    bool = 1;
else
    bool = 0;
end


end