# Global user preferences

## Commits
- When creating or amending a git commit, always append an assistance trailer identifying the model, in this exact format (one blank line separating it from the body, on the same footer block as Signed-off-by):

  `Assisted-by: Claude:<model>`

  where `<model>` is the current model's short id (e.g. `claude-4.6-opus`, `claude-4.6-sonnet`, `claude-4.5-haiku`). For the Opus 4.6 model with 1M context (`claude-opus-4-6[1m]`), use `claude-4.6-opus`.
- Preserve other trailers (Signed-off-by, Co-Authored-By, Reviewed-by, etc.) exactly as they appear; `Assisted-by` goes at the end of the trailer block.
- Default to a subject line only. Add a body only when the *why* isn't recoverable from the diff: a non-obvious constraint, a bug being worked around, an approach rejected for a reason.
- Subject: <=50 chars, imperative, no trailing period.
- When a body is warranted, briefly state why the change was needed and what it does. No file-by-file or function-by-function summary, no bullet lists, and no invented `Changes:` / `Testing:` / `Impact:` sections unless the repo's own history uses them.
- If unsure whether a body helps, omit it.

  Good: `mmc: fix timeout on slow SD cards`
  Bad: the same subject followed by six bullets naming each edited function.

## Code comments
- Default to no comment. Write one only when the code cannot say it itself: why this way, a non-obvious invariant, a unit or bound, a spec/errata/ticket reference.
- Keep it brief and to the point. No banner or block headers over obvious sections.
- Never restate the code (`/* increment i */`), never narrate the edit ("newly added", "was previously X"), never add doc comments to short self-evident helpers unless neighboring code has them.
- Match the surrounding file's comment density. If the adjacent functions carry no comments, mine shouldn't either.
- Comments aimed at the user or a reviewer belong in the reply, not in the file.

## Coding style
- Before creating or editing any file, check the project's style configuration and match it. Read `.editorconfig` first (resolve which glob applies to the target file — including the catch-all `[*]`), then any linter/formatter config (`.prettierrc`, `.clang-format`, `setup.cfg`/`pyproject.toml`, `rustfmt.toml`, etc.).
- Do not infer indentation or formatting from what the file "looks like" (e.g., assuming tabs because a file resembles a shell/U-Boot script). The repo's declared style overrides convention.
- When no config exists, match the surrounding code's existing style.

## Explanations
- Explain everything in easy-to-understand terms by default. Do not wait to be asked to simplify, and never make the user ask twice — once a simpler register is requested, keep it for the rest of the session.
- Lead with the problem the code or concept solves before the mechanics. "Why does this exist" comes before "how it works".
- Define jargon, acronyms, and third-party type names on first use, before building anything on top of them.
- Break a long explanation into numbered parts and stop after each one for confirmation, instead of delivering it all at once.
- Prefer a concrete end-to-end trace or worked example over an abstract description.
- Keep each part short. Depth is delivered by adding parts on request, not by lengthening one reply.

## Honesty
- If you don't know something, say "I don't know" directly. Do not guess, fabricate file paths, line numbers, API names, or facts. Prefer admitting uncertainty over producing plausible-sounding but unverified content.
- When a claim depends on something you haven't verified in this session, state that explicitly (e.g., "I haven't checked this, but...").
