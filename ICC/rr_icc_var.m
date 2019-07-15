function [SIGMA2] = rr_icc_var(A,K,LENGTH)
%   A - var-cov matrix
%   K - number of runs, or just size(A,1)=size(A,2)
%   LENGTH - functional length

    DA = zeros(size(A));
    DELTA = 0.005;

    for I = 1:K
      for J = 1:I
        % F1
        A(I,J) = A(I,J) - 2 * DELTA; 
        A(J,I) = A(I,J);
        F1 = rr_icc_val(A);
        % F2
        A(I,J) = A(I,J) + DELTA; 
        A(J,I) = A(I,J);
        F2 = rr_icc_val(A);
        % F3
        A(I,J) = A(I,J) + 2 * DELTA; 
        A(J,I) = A(I,J);
        F3 = rr_icc_val(A);
        % F4
        A(I,J) = A(I,J) + DELTA;
        A(J,I) = A(I,J);
        F4 = rr_icc_val(A);
        % RESTORE A
        A(I,J) = A(I,J) - 2 * DELTA;
        A(J,I) = A(I,J);
        % DA
        DA(I,J) = (F1 - 8 * F2 + 8 * F3 - F4) / (12 * DELTA);
        DA(J,I) = DA(I,J);
      end
    end

    SUM = 0;
    for I = 1:K
      for J = I:K
        for M = 1:K
          for N = M:K
            SUM = SUM + DA(I,J) * DA(M,N) * ((A(I,M) * A(J,N) + A(I,N) * A(J,M)));
          end
        end
      end
    end

    SIGMA2 = (SUM / (LENGTH - 1));

end