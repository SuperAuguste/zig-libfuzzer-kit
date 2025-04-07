#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>

int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size) {
    if (size == 17) {
        if (data[0] == 'w' &&
            data[1] == 'o' &&
            data[2] == 'w' &&
            data[3] == ' ' &&
            data[4] == 'y' &&
            data[5] == 'o' &&
            data[6] == 'u' &&
            data[7] == ' ' &&
            data[8] == 'f' &&
            data[9] == 'o' &&
            data[10] == 'u' &&
            data[11] == 'n' &&
            data[12] == 'd' &&
            data[13] == ' ' &&
            data[14] == 'm' &&
            data[15] == 'e' &&
            data[16] == '!'
        ) {
            abort();
        }
    }

    return 0;
}
