from cryptography import x509
from cryptography.x509.oid import NameOID
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import rsa
from datetime import datetime, timedelta
import os

os.makedirs("/etc/ssl/private", exist_ok=True)
os.makedirs("/etc/ssl/certs", exist_ok=True)

key = rsa.generate_private_key(
    public_exponent=65537,
    key_size=2048
)

subject = x509.Name([
    x509.NameAttribute(NameOID.COUNTRY_NAME, "MA"),
    x509.NameAttribute(NameOID.STATE_OR_PROVINCE_NAME, "Morocco"),
    x509.NameAttribute(NameOID.LOCALITY_NAME, "Casablanca"),
    x509.NameAttribute(NameOID.ORGANIZATION_NAME, "1337"),
    x509.NameAttribute(NameOID.COMMON_NAME, "localhost"),
])

cert = (
    x509.CertificateBuilder()
    .subject_name(subject)
    .issuer_name(subject)
    .public_key(key.public_key())
    .serial_number(x509.random_serial_number())
    .not_valid_before(datetime.utcnow())
    .not_valid_after(datetime.utcnow() + timedelta(days=365))
    .add_extension(
        x509.SubjectAlternativeName([x509.DNSName("localhost")]),
        critical=False,
    )
    .sign(key, hashes.SHA256())
)

with open("/etc/ssl/private/nginx-selfsigned.key", "wb") as f:
    f.write(
        key.private_bytes(
            encoding=serialization.Encoding.PEM,
            format=serialization.PrivateFormat.TraditionalOpenSSL,
            encryption_algorithm=serialization.NoEncryption(),
        )
    )

with open("/etc/ssl/certs/nginx-selfsigned.crt", "wb") as f:
    f.write(cert.public_bytes(serialization.Encoding.PEM))
