# Sample app to demonstrate secret detection. Do not use as a template.
import os

AWS_ACCESS_KEY_ID = "AKIAIOSFODNN7EXAMPLE"
AWS_SECRET_ACCESS_KEY = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

STRIPE_KEY = "sk_test_REDACTED4eC39HqLyjWDarjtT1zdp7dc"
GITHUB_TOKEN = "ghp_PLACEHOLDERaaaabbbbccccddddeeeeffff111122223333"


def boot() -> dict[str, str]:
    return {
        "aws": AWS_ACCESS_KEY_ID,
        "stripe": STRIPE_KEY,
        "github": GITHUB_TOKEN,
        "env": os.getenv("APP_ENV", "dev"),
    }


if __name__ == "__main__":
    print(boot())
