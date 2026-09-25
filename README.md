# 个人笔记

本仓库使用 Zensical 构建各类学习笔记与记录。

## 本地构建

```bash
uvx --from zensical==0.0.62 zensical build --clean --strict
uvx --from zensical==0.0.62 zensical build --clean --strict --config-file zensical.en.toml
```

生成的 `site/` 为构建产物，不纳入版本控制（见 `.gitignore`）。
中文内容位于 `docs/`，发布在网站根路径；英文内容位于 `docs-en/`，发布在 `/en/`。两个站点通过页眉语言菜单切换。当前英文主页已建立，其余文章仍只有中文版。
