# Latin Squares
A collection of methods concerning the existence of k-plexes in latin squares to be run in [Sage](sagemath.org)

The file H2Plex.sage contains the code necessary to determine which of the latin squares in a given set contain Hamilton 2-plexes. For a the definition of latin square, Hamilton 2-plex, and any other undefined terms see [my PhD thesis](https://theses.lib.sfu.ca/file/thesis/6599), for which this code was written.

The three data files demonstrate that all latin squares of order 6,7, and 8 have Hamilton 2-plexes. This was determined using the enumeration of all isotopy classes of latin squares provided by [Brendan McKay](https://users.cecs.anu.edu.au/~bdm/data/latin.html). The Coerce function in H2Plex.sage is meant to translate the list of latin squares from the format in the given source to a list of lists.
