#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <libgen.h>

// Function to clean up temporary files
void cleanup() {
    const char *files[] = {
        "/Users/$USER/Downloads/screen.png",
        "/Users/$USER/Downloads/screen.txt",
        "/Users/$USER/Downloads/screen2speech.aiff"
    };

    for (int i = 0; i < 3; i++) {
        if (access(files[i], F_OK) == 0) {
            remove(files[i]);
        }
    }
}

// Function to expand $USER in paths
void expand_user_path(char *dest, const char *path) {
    const char *user = getenv("USER");
    if (user == NULL) {
        fprintf(stderr, "Failed to get USER environment variable.\n");
        exit(1);
    }

    strcpy(dest, path);
    char *dollar_user = strstr(dest, "$USER");
    if (dollar_user != NULL) {
        memmove(dollar_user + strlen(user), dollar_user + 5, strlen(dollar_user + 5) + 1);
        memmove(dollar_user, user, strlen(user));
    }
}

int main() {
    char screenshot_path[256];
    char output_text_path[256];
    char audio_output_path[256];
    char output_text_path_with_ext[256];

    // Expand paths
    expand_user_path(screenshot_path, "/Users/$USER/Downloads/screen.png");
    expand_user_path(output_text_path, "/Users/$USER/Downloads/screen.txt");
    expand_user_path(audio_output_path, "/Users/$USER/Downloads/screen2speech.aiff");
    snprintf(output_text_path_with_ext, sizeof(output_text_path_with_ext), "%s.txt", output_text_path);

    // Register cleanup function to run on exit
    atexit(cleanup);

    // Capture screen
    printf("Capturing screen...\n");
    char screencapture_cmd[512];
    snprintf(screencapture_cmd, sizeof(screencapture_cmd), "screencapture -s \"%s\"", screenshot_path);
    if (system(screencapture_cmd) != 0) {
        fprintf(stderr, "Failed to capture screen.\n");
        exit(1);
    }

    // Check if screenshot was captured
    if (access(screenshot_path, F_OK) != 0) {
        fprintf(stderr, "Failed to capture screen.\n");
        exit(1);
    }

    // Extract text from screenshot
    printf("Extracting text from screenshot...\n");
    char tesseract_cmd[512];
    snprintf(tesseract_cmd, sizeof(tesseract_cmd), "tesseract \"%s\" \"%s\" 2>/dev/null", screenshot_path, output_text_path);
    if (system(tesseract_cmd) != 0) {
        fprintf(stderr, "Failed to extract text from screenshot.\n");
        exit(1);
    }

    // Check if text extraction succeeded
    if (access(output_text_path_with_ext, F_OK) != 0) {
        fprintf(stderr, "Failed to extract text from screenshot.\n");
        exit(1);
    }

    // Convert text to speech
    printf("Converting text to speech...\n");
    char say_cmd[1024];
    snprintf(say_cmd, sizeof(say_cmd),
             "say --progress -f \"%s\" -v \"Zoe (Premium)\" -o \"%s\"",
             output_text_path_with_ext, audio_output_path);
    if (system(say_cmd) != 0) {
        fprintf(stderr, "Failed to generate audio.\n");
        exit(1);
    }

    // Check if audio was generated
    if (access(audio_output_path, F_OK) != 0) {
        fprintf(stderr, "Failed to generate audio.\n");
        exit(1);
    }

    // Play audio
    printf("Playing audio...\n");
    char mplayer_cmd[512];
    snprintf(mplayer_cmd, sizeof(mplayer_cmd), "mplayer \"%s\"", audio_output_path);
    system(mplayer_cmd);

    return 0;
}