im = imread('data/1.jpg');
[h, w, channel] = size(im);
im = im2double(im);
imshow(im) 

k=6;
itr=0;
ini_miu = rand(k,1,3) ;
new_miu = zeros(k,1,3);
ini_h = randi([1, h], k);
ini_w = randi([1, w], k);
for i=1:k
    ini_miu(i, 1, :) = im(ini_h(i), ini_w(i), :);
end
while new_miu ~= ini_miu 
    if (itr ~= 0)
    ini_miu = new_miu;
    end
    count = zeros(k, 1, 3);
    sum = zeros (k, 1, 3);
    for i=1:h
        for j=1:w
            d = zeros(1,k);
            for p=1:k
                dif=im(i,j,:)-ini_miu(p,1,:);
                dif=dif(:);
                d(1,p)=norm(dif)^2;
            end
            
            d_min=min(d);
            for q = 1:k
                dif=im(i,j,:)-ini_miu(q,1,:);
                dif=dif(:);
                d=norm(dif)^2;
                if (abs(d - d_min) < 1e-5)
                   count(q, 1, :)= count(q, 1, :)+1;
                   sum(q, 1, :) = sum(q, 1, :) + im(i,j,:);
                end 
            end 
        end
    end
    for r = 1:k
        new_miu(r, 1, :) = sum(r, 1, :)./count(r, 1, :);
    end
    itr = itr+1;
    disp(itr)
end
disp(new_miu)


for i=1:h
    for j=1:w

        d = zeros(1,k); 
        for p=1:k

            dif=im(i,j,:)-new_miu(p,1,:);
            dif=dif(:);
            d(1,p)=norm(dif)^2;
        end

        d_min=min(d);

        for q = 1:k
            dif=im(i,j,:)-new_miu(q,1,:);
            dif=dif(:);
            d=norm(dif)^2;

            if (abs(d - d_min) < 1e-5)
                im(i,j,:)= new_miu(q,1,:);
            end
        end
    end
end

imshow(im)




