import torch

import triton
import triton.language as tl
import torch


@triton.jit
def add_kernel(
        x_ptr, 
        y_ptr, 
        out_ptr, 
        n, 
        BLOCK_SIZE: tl.constexpr
    ) -> None: 
    pid = tl.program_id(0)
    block_start = pid * BLOCK_SIZE
    offsets = block_start + tl.arange(0, BLOCK_SIZE)

    x = tl.load(x_ptr + offsets) 
    y = tl.load(y_ptr + offsets)

    output = x + y

    tl.store(out_ptr + offsets, output)

add_kernel = triton.jit(..., add_kernel)


def main() -> None:
    x = torch.randn(32,) 
    y = torch.randn(32,)

    outputs = torch.empty_like(x)

    (x, y, outputs) = tuple([t.to("cuda") for t in [x,y,outputs]])

    n = outputs.numel()

    # Define block size
    BLOCK_SIZE = 16

    # Grid of programs
    grid = lambda meta: (n // meta["BLOCK_SIZE"],)


    add_kernel[grid](x, y, outputs, n, BLOCK_SIZE=BLOCK_SIZE)

    print(outputs)

print(type(main))

if __name__ == "__main__":
    main()



