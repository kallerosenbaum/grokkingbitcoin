import java.util.Random;

class BlockGenerationSim {
    public static final void main(String[] args) {
	long rounds = 1000000000L;
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
	for (long round = 0; round < rounds; round++) {
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
	    if (sideAWins == 0 && sideBWins == 0) {
		noBlocksAtAll++;
	    } else if (sideAWins > 0 && sideBWins > 0) {
		noResolution++;
	    }
	}
	
	System.out.println("Rounds: " + rounds);
	System.out.println("No blocks: " + noBlocksAtAll);
	System.out.println("No resolution in " + noResolution + " cases of " + (rounds - noBlocksAtAll));
	System.out.println("Probability of no resolution if any block is found is " + ((double)noResolution/((rounds - noBlocksAtAll))));
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
