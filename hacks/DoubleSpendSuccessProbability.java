
class DoubleSpendSuccessProbability {
    private static long start;

    public static void main(String[] args) throws Exception {

	double[] qs = {0.01, 0.05, 0.1, 0.18, 0.36, 0.45, 0.5};
	int[] zs = {1, 2, 3, 4, 5, 6, 10, 100};
	for (int z : zs) {
	   double[] zresults = new double[qs.length];
	   System.out.format("| %3d ", z);
	   for (int i = 0; i < qs.length; i++) {
	       double q = qs[i];
	       double p = 1-q;
	       double zresult = Math.pow(q/p, z);
	       String format;
	       if (zresult < 0.00001) {
		   format = "| %8.1e ";
	       } else {
		   format = "| %f ";
	       }
	       System.out.format(format, zresult);
	   }
	   System.out.println();
	}
    }
}
