

##############################################################
# The Technical Part:
# Input: S, a list of lists giving a latin square; Path, a 
# list giving a 2-bounded path in K_{n,n}(S); CC, an array 
# documenting how many times each color has been used in Path; 
# aR and aC, sets giving the rows and columns, respectively, 
# not used by Path; n, the order of S; k, the length of Path
# Output: if Path can be extended by 1, (True,P) where P
# is the extension. Otherwise, (False,Path)
##############################################################

def Ham2PlexUtil(S,Path,CC,aR,aC,n,k):

    ###########################################################
    # Base Case: if Path has length 2n-1, check that the edge
    # connecting its end to S[0][0] has the correct symbol
    ###########################################################

    if k==2*n-1:
        r = Path[k-1][0]
        s = S[r][0]
        if CC[s]==1:
            Path.append((r,0,s))
            return True,Path
        else:
            return False,Path

    ############################################################
    # For paths of even length, randomly select a row candidate
    # for the next step in the path, then attempt to extend
    ############################################################

    if k%2==0:
        c = Path[k-1][1]
        aR2 = Permutations(list(aR)).random_element()
        for r in aR2:
            s = S[r][c]
            if CC[s]<2:
                Path.append((r,c,S[r][c]))
                CC[s]+=1
                aR.remove(r)
                if Ham2PlexUtil(S,Path,CC,aR,aC,n,k+1)[0]:
                    return True,Path
                Path.pop()
                CC[s]-=1
                aR.add(r)
        return False,Path

    ##############################################################
    # For paths of odd length, randomly select a column candidate
    # for the next step in the path, then attempt to extend
    ##############################################################

    else:
        r = Path[k-1][0]
        aC2 = Permutations(list(aC)).random_element()
        for c in aC2:
            s = S[r][c]
            if CC[s]<2:
                Path.append((r,c,S[r][c]))
                CC[s]+=1
                aC.remove(c)
                if Ham2PlexUtil(S,Path,CC,aR,aC,n,k+1)[0]:
                    return True,Path
                Path.pop()
                CC[s]-=1
                aC.add(c)
        return False,Path

###########################################################
# The Top Part
# Input: $S$, a list of lists giving a latin square
# Output: A Hamilton 2-plex in $S$, if one exists, otherwise 
# False
###########################################################

def Ham2Plex(S):
    n = len(S)
    CC = [0 for i in range(n)]
    CC[S[0][0]]=1
    aR = set(range(1,n))
    aC = set(range(1,n))
    H = Ham2PlexUtil(S,[(0,0,S[0][0])],CC,aR,aC,n,1)
    if H[0]:
        return H[1]
    else:
        return False
        




#######################################################
# A method for converting the string representations
# in B. McKay's database 
# (https://users.cecs.anu.edu.au/~bdm/data/latin.html)
# to a 2-D Python array
########################################################

def Coerce(n, ls):
    output = []
    for i in range(n):
        output.append([int(x) for x in ls[n*i:n*i+n]])
    return output

#######################################################
# A method for testing if all latin squares in path
# have a Hamilton 2-plex, and writing an H2-plex
# for each square in path to the file out
########################################################

def ExhaustiveTest(n,path,out):
    LS = open(path)
    o = open(out,'w')
    Check=True
    for line in LS:
        if Check:
            M=Coerce(n,line)
            H = Ham2Plex(M)
            o.write(str(H)+'\n')
        else:
            break





