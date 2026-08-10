#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <oqs/oqs.h>

int main() {
    // Initialize the KEM
    OQS_KEM *kem = OQS_KEM_new(OQS_KEM_alg_ml_kem_768);
    if (kem == NULL) {
        fprintf(stderr, "Failed to initialize KEM\n");
        return EXIT_FAILURE;
    }

    printf("Using KEM: %s\n", kem->method_name);
    printf("Public key length: %zu bytes\n", kem->length_public_key);
    printf("Secret key length: %zu bytes\n", kem->length_secret_key);
    printf("Ciphertext length: %zu bytes\n", kem->length_ciphertext);
    printf("Shared secret length: %zu bytes\n", kem->length_shared_secret);

    // Allocate memory for keys and ciphertext
    uint8_t *public_key = malloc(kem->length_public_key);
    uint8_t *secret_key = malloc(kem->length_secret_key);
    uint8_t *ciphertext = malloc(kem->length_ciphertext);
    uint8_t *shared_secret_a = malloc(kem->length_shared_secret);
    uint8_t *shared_secret_b = malloc(kem->length_shared_secret);

    if (!public_key || !secret_key || !ciphertext || !shared_secret_a || !shared_secret_b) {
        fprintf(stderr, "Memory allocation failed\n");
        goto cleanup;
    }

    // Generate key pair
    if (OQS_KEM_keypair(kem, public_key, secret_key) != OQS_SUCCESS) {
        fprintf(stderr, "Failed to generate key pair\n");
        goto cleanup;
    }
    printf("\nKey pair generated successfully\n");

    // Encapsulate shared secret
    if (OQS_KEM_encaps(kem, ciphertext, shared_secret_a, public_key) != OQS_SUCCESS) {
        fprintf(stderr, "Failed to encapsulate shared secret\n");
        goto cleanup;
    }
    printf("Shared secret encapsulated successfully\n");

    // Decapsulate shared secret
    if (OQS_KEM_decaps(kem, shared_secret_b, ciphertext, secret_key) != OQS_SUCCESS) {
        fprintf(stderr, "Failed to decapsulate shared secret\n");
        goto cleanup;
    }
    printf("Shared secret decapsulated successfully\n");

    // Verify shared secrets match
    if (memcmp(shared_secret_a, shared_secret_b, kem->length_shared_secret) != 0) {
        fprintf(stderr, "Shared secrets do not match\n");
        goto cleanup;
    }
    printf("Shared secrets verified successfully\n");

    // Print shared secret for AES-256
    printf("\nShared secret for AES-256:\n");
    for (size_t i = 0; i < kem->length_shared_secret; i++) {
        printf("%02x", shared_secret_a[i]);
    }
    printf("\n");

cleanup:
    // Free memory
    if (public_key) free(public_key);
    if (secret_key) free(secret_key);
    if (ciphertext) free(ciphertext);
    if (shared_secret_a) free(shared_secret_a);
    if (shared_secret_b) free(shared_secret_b);
    OQS_KEM_free(kem);

    return EXIT_SUCCESS;
}