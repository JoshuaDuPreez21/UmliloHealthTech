package Utils;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class PasswordUtil {
	private static final int ITERATIONS = 65536;
	private static final int KEY_LENGTH = 256;
	private static final int SALT_BYTES = 16;

	public static String hashPassword(String password) {
		byte[] salt = new byte[SALT_BYTES];
		new SecureRandom().nextBytes(salt);
		byte[] hash = pbkdf2(password.toCharArray(), salt);
		return Base64.getEncoder().encodeToString(salt) + ":" + Base64.getEncoder().encodeToString(hash);
	}

	public static boolean verifyPassword(String password, String stored) {
		if (stored == null || !stored.contains(":")) {
			return false;
		}
		String[] parts = stored.split(":");
		byte[] salt = Base64.getDecoder().decode(parts[0]);
		byte[] expected = Base64.getDecoder().decode(parts[1]);
		byte[] actual = pbkdf2(password.toCharArray(), salt);
		if (expected.length != actual.length) {
			return false;
		}
		int diff = 0;
		for (int i = 0; i < expected.length; i++) {
			diff |= expected[i] ^ actual[i];
		}
		return diff == 0;
	}

	private static byte[] pbkdf2(char[] password, byte[] salt) {
		try {
			PBEKeySpec spec = new PBEKeySpec(password, salt, ITERATIONS, KEY_LENGTH);
			SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
			return skf.generateSecret(spec).getEncoded();
		} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
			throw new IllegalStateException("Password hashing failed", e);
		}
	}
}
