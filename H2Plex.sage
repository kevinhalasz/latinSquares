#load("LSGenerators.sage")
#   put Dropbox/Code/H2Plex.sage


##############################################################
# (*\textbf{The technical part}*)
# (*\textbf{Input:}*) $S$, a list of lists giving a latin square; Path, a 
# list giving a 2-bounded path in $K_{n,n}(S)$; CC, an array 
# documenting how many times each color has been used in Path; 
# aR and aC, sets giving the rows and columns, respectively, 
# not used by Path; $n$, the order of $S$; $k$, the length of Path
# (*\textbf{Output:}*) if Path can be extended by 1, (True,P) where P
# is the extension. Otherwise, (False,Path)
##############################################################

def Ham2PlexUtil(S,Path,CC,aR,aC,n,k):

    ###########################################################
    # (*\textbf{Base case:}*) if Path has length 2n-1, check that the edge
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
# (*\textbf{The top part}*)
# (*\textbf{Input:}*) $S$, a list of lists giving a latin square
# (*\textbf{Output:}*) A Hamilton 2-plex in $S$, if one exists, otherwise 
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
        



#######################################
#Old stuff you could maybe throw out?
#######################################

#def IsSafeRow(S,Path,CC,r,k):
#    c = Path[k-1][1]
#    s = S[r][c]
#    if CC[s]==2:
#        return False
#    else:
#        return True

#def IsSafeCol(S,Path,CC,c,k):
#    r = Path[k-1][0]
#    s = S[r][c]
#    if CC[s]==2:
#        return False
#    else:
#        return True



#############################################
# A method testing everything in McKay's list and
# writing the output H2Plex to RawData.txt
# Current version specific to n=8
#############################################

def Coerce(n, str):
    s = str[0:n^2]
    m = matrix(n,n,list([int(x) for x in s]))
    return [list(r) for r in m.rows()]


def ExhaustiveTest(n):
    LS8 = open('Documents/Research/CombinatorialData/latin_is8.txt')
    o = open('Desktop/8Data.txt','w')
    count=0
    Check=True
    for line in LS8:
        if Check:
            M=Coerce(8,line)
            H = Ham2Plex(M)
            o.write(str(H)+'\n')
            count+=1
            print(count)
        else:
            break

#############################
#Get quadrant sequence from a
# sequence of cells in 2-step type LS
#############################

def seqit(S,lisst): 
    n = len(S)
    output = [] 
    for pair in lisst: 
        c = pair[1] 
        s = S[pair[0]][pair[1]] 
        if c<n/2 and s<n/2: 
            output.append(1) 
        if c>=n/2 and s>=n/2: 
            output.append(2) 
        if c<n/2 and s>=n/2: 
            output.append(3) 
        if c>=n/2 and s<n/2: 
            output.append(4)
    if output[2*n-2] == 3 or output[2*n-2]==4:
        output.append(3)
    else:
        output.append(1)
    return output 


def drawit(seq): 
    n = (len(seq)+1)/2 
    M = [[0 for i in range(n)] for j in range(n)] 
    for (a,b) in seq: 
        M[a][b]=1
    for i in range(n):
        if sum(M[i]) <2:
            M[i][0]=1
            break
    M=matrix(M) 
    M.subdivide(n/2,n/2) 
    return M 

            

def changes(seq): 
    count = 0 
    n = len(seq) 
    for i in range(n-1): 
        if seq[i]!=seq[i+1]: 
            count+=1 
    if seq[n-1]==3: 
        count+=1 
    return count 