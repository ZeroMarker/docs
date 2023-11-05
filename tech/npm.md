# Stage #1 npm
foo
    index.js
    package.json
    node_modules
    bar
        index.js
        ...

dependency tree too long

package reuse

# Stage #2 npm@v3 yarn pnpm
flat node_modules
foo
    index.js
    ...
bar
    index.js
    ...

illeagal access

resolving dependency tree

# Stage #3 pnpm
symlink

symbol link

- Phantom dependencies
- doppelgangers

[为什么选择pnpm? 包管理器的依赖处理简史](https://www.bilibili.com/video/BV1B34y1E7MS/)

[pnpm如何避免一些愚蠢的bug，对比npm](https://www.bilibili.com/video/BV1U94y1U7ar/)

[JavaScript 包管理器简史（npm/yarn/pnpm）](https://zhuanlan.zhihu.com/p/451025256)
