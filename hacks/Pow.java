import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Random;
import java.nio.ByteBuffer;
import java.util.Timer;

class Pow {
    private static long start;

    public static void main(String[] args) throws Exception {
        int zeroBits = Integer.parseInt(args[0]);
        ByteBuffer byteBuffer = ByteBuffer.allocate(80);
        Random random = new Random();
        random.nextBytes(byteBuffer.array());
        byteBuffer.putLong(72, -1L);
        byte[] nonce = new byte[8];
        MessageDigest md = MessageDigest.getInstance("SHA-256");

        start = System.currentTimeMillis();
        loop:
        while (true) {
            byte[] input = byteBuffer.putLong(72, byteBuffer.getLong(72) + 1).array();
            byte[] hash1 = md.digest(input);
            byte[] hash2 = md.digest(hash1);
            int byteIndex = zeroBits / 8;
            for (int i = 0; i < byteIndex; i++) {
                if (hash2[i] != 0) {
                    continue loop;
                }
            }
            int lastBits = zeroBits % 8;
            if (lastBits == 0) {
                printSuccess(byteBuffer, hash2, zeroBits);
                return;
            }
            byte b = (byte)0xff;
            b = (byte)(b <<(8 - lastBits));
            if ((hash2[byteIndex] & b) == 0) {
                printSuccess(byteBuffer, hash2, zeroBits);
                return;
            }
        }
    }

    private static void printSuccess(ByteBuffer byteBuffer, byte[] hashResult, int zeroBits) {
        long end = System.currentTimeMillis();
        System.out.println("Found proof with nonce " + byteBuffer.getLong(72));
        System.out.println("Input:  " + getHex(byteBuffer.array()));
        System.out.println("Output: " + getHex(hashResult));
        byte[] maxVal = new byte[32];
        Arrays.fill( maxVal, (byte) 0xff);
        for (int i = 0; i < (zeroBits / 8); i++) {
            maxVal[i] = (byte)0;
        }
        maxVal[(zeroBits) / 8] = (byte) (0xff>>(zeroBits % 8));
        System.out.println("Max   : " + getHex(maxVal));
        System.out.println("Time  : " + (end-start) + " ms");
    }


    static final String HEXES = "0123456789ABCDEF";

    public static String getHex(byte[] raw) {
        if (raw == null) {
            return null;
        }
        final StringBuilder hex = new StringBuilder(2 * raw.length);
        for (final byte b : raw) {
            hex.append(HEXES.charAt((b & 0xF0) >> 4))
                    .append(HEXES.charAt((b & 0x0F)));
        }
        return hex.toString().toLowerCase();
    }
}
