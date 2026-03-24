package Utils;

public class PasswordHashTool {
	public static void main(String[] args) {
		if (args.length < 1) {
			System.out.println("Usage: PasswordHashTool <plainPassword>");
			return;
		}
		System.out.println(PasswordUtil.hashPassword(args[0]));
	}
}
