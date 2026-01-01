import smtplib, ssl
import os
from email.message import EmailMessage
import sys

FILE = sys.argv[1] if len(sys.argv) > 1 else None
if not FILE:
    print("Usage: send-to-kindle.py <file.epub>")
    sys.exit(1)

KINDLE_EMAIL = os.environ.get("KINDLE_EMAIL")
SMTP_USER = os.environ.get("SMTP_USER")
SMTP_PASS = os.environ.get("SMTP_PASS")
SMTP_HOST = os.environ.get("SMTP_HOST", "smtp.gmail.com")
SMTP_PORT = int(os.environ.get("SMTP_PORT", 587))

if not KINDLE_EMAIL or not SMTP_USER or not SMTP_PASS:
    print("KINDLE_EMAIL, SMTP_USER or SMTP_PASS not set")
    sys.exit(1)

msg = EmailMessage()
msg["From"] = SMTP_USER
msg["To"] = KINDLE_EMAIL
msg["Subject"] = "Send to Kindle"
msg.set_content("Kindle document attached")

with open(FILE, "rb") as f:
    data = f.read()
    msg.add_attachment(data, maintype="application", subtype="epub+zip", filename=os.path.basename(FILE))


context = ssl.create_default_context()
with smtplib.SMTP(SMTP_HOST, SMTP_PORT) as smtp:
    # smtp.set_debuglevel(1)
    smtp.ehlo()
    smtp.starttls(context=context)
    smtp.ehlo()
    smtp.login(SMTP_USER, SMTP_PASS)
    smtp.noop()



print(f"Sent {FILE} to {KINDLE_EMAIL}")
