import java.util.Random;

class BlockGenerationSim {
    public static final void main(String[] args) {
	long rounds = 1000000L;
	int randomspan = 1800;
	int[] dice = new int[3];
	int divider = 1; // dice[0] is one side and dice[1] and dice[2] on the other side
	int simpleResolutions = 0;
	int delayedResolutions = 0;
	int sideAForks = 0;
	int sideBForks = 0;
	int noBlocksAtAll = 0;
	int noResolution = 0;
	Random random = new Random();
	int[] splitLengths = {0, 0, 0,0,0,0,0,0,0};
	for (long round = 0; round < rounds; round++) {
	    boolean resolved = false;
	    int splitLength = 0;
	    while (!resolved) {		
		int sideAWins = 0;
		int sideBWins = 0;

		for (int i = 0; i < dice.length; i++) {
		    dice[i] = random.nextInt(randomspan);
		    if (dice[i] == 0) {
			if (i < divider) {
			    sideAWins++;
			} else {
			    sideBWins++;
			}	  
		    } 
		}
		if (splitLength == 0) {
		    if (sideAWins+sideBWins > 1) {
			splitLength++;
			continue;
		    }
		    if (sideAWins+sideBWins == 0) {
			continue;
		    }
		    if (sideAWins+sideBWins == 1) {
			splitLengths[0] += 1;
			resolved = true;
			continue;
		    }
		}

		if (sideAWins > 0 && sideBWins > 0) {
		    splitLength++;
		} else {
		    splitLengths[splitLength] += 1;
		    resolved = true;
		}
	    }
	}
	
	System.out.println("Rounds: " + rounds);

	int sum = 0;
	for (int i = 0; i < splitLengths.length; i++) {
	    System.out.println("Length " + i + ": " + splitLengths[i]);
	    sum += splitLengths[i];
	}
	System.out.println("Total splits (including 0 length): " + sum);
	//	System.out.println("Probability of no resolution if any block is found is " + ((double)noResolution/((rounds - noBlocksAtAll))));

	/*
	long twoweeks=2*7*24*60*60L;
	double tryinterval=0.5;
	long tries=(long)(twoweeks/tryinterval);
	int nodes=3;
	long retargetperiod=2016L;
	int randomspan=1000000000;

	double trysuccessprob=((double)retargetperiod / nodes) * tryinterval / twoweeks;
	System.out.println("Try successprob: " + trysuccessprob);
	
	long target=(long)Math.ceil(randomspan *  trysuccessprob);
	System.out.println("Target: " + target);

	int successcount=0;
	Random random = new Random();
	while (tries > 0) {
	    tries--;
	    int ran=random.nextInt(randomspan);
	    if (ran < target) {
		successcount++;
	    }
	}
	System.out.println("Successes: " + successcount);
	System.out.println("Expected about " + retargetperiod / nodes + " successes");
    */
    }
}
