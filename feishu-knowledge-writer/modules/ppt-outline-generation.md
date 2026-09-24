# PPT Outline Generation

Use this module when the user wants material reorganized into a slide-deck outline instead of a full article.

## Intent

- Convert source material into page-level presentation structure
- Keep each page focused and brief
- Prepare content for later refinement into presentation style

## Core Output Goal

The output must look like a usable PPT outline, not like an article summary or a generic document outline.

Each page should have:

- A clear page title
- A page purpose
- 2 to 5 concise bullet points
- Optional notes on visuals, charts, or cases when needed

## Output Modes

Choose the mode that best fits the user's request.

- `Feishu-ready` (default)
  - Best for writing outline content into a Feishu knowledge document
  - Allows title, audience, slide count, slide-by-slide structure, and optional appendix pages
- `Strict PPT Prompt`
  - Best when the user explicitly wants a rigid prompt-style outline format
  - Uses a fixed sequence and stronger formatting consistency
  - Suitable for later copy-paste into external PPT-generation workflows

If the user asks for “严格格式”“固定页型”“按统一模板输出”, prefer `Strict PPT Prompt`.

## Output Styles

Choose the style that best matches the user's context. If unclear, default to `分享型`.

- `分享型`
  - Suitable for project sharing, knowledge sharing, roadshow, and class presentation
  - Focus on clear logic, engagement, and progressive explanation
- `汇报型`
  - Suitable for management updates, internal reports, and milestone reporting
  - Focus on conclusion first, then status, problems, actions, and next steps
- `教学型`
  - Suitable for lessons, tutorials, and explanatory presentations
  - Focus on concept, principle, process, example, and takeaway
- `项目型`
  - Suitable for business plans, product plans, and implementation proposals
  - Focus on background, pain point, solution, market, model, execution, and risk
- `答辩型`
  - Suitable for defense, evaluation, and competition presentations
  - Focus on problem, method, evidence, differentiation, feasibility, and conclusion

## Slide Type Rules

Prefer using only a small number of stable page roles instead of inventing many custom slide types.

Core page roles:

- Cover
- Agenda / table of contents
- Section list slide
- Summary
- Optional Q&A

In `Strict PPT Prompt` mode, keep page roles highly consistent and avoid unnecessary page-type variation.

## Default Slide Sequence

If the user does not specify another sequence, prefer this structure and adjust as needed:

1. Cover
2. One-line summary or opening conclusion
3. Background / context
4. Core problem or opportunity
5. Solution overview
6. Key mechanism / product / method
7. Differentiation or advantages
8. Market / user / application value
9. Business model or implementation path
10. Milestones / plan / roadmap
11. Team / capability
12. Risk / challenge / response
13. Summary
14. Optional Q&A

Not every outline must use all pages. Compress or expand according to material density.

## Strict Sequence Option

When the user wants a highly standardized outline, prefer this stronger structure:

1. Cover
2. Table of contents
3. One slide for each section listed in the table of contents
4. Optional closing summary

Rules for this mode:

- Table of contents should usually contain 3 to 6 sections
- Each section should map to exactly one main slide unless the user asks for a more detailed deck
- Slide order must follow the table of contents order
- Slide titles should remain consistent with the section names

## Density Rules

- One page should usually express one main idea only.
- Each page should usually contain 2 to 5 bullets.
- Avoid long paragraph bullets.
- Avoid mixing multiple unrelated arguments into one page.
- Prefer short, spoken-language bullets suitable for slide presentation.
- If the source is very long, compress first; do not mirror the original section count mechanically.
- In strict mode, each content slide should usually contain 2 to 4 key points.

## Writing Rules

- Prefer page titles that are short and presentation-friendly.
- Emphasize logic flow between pages, not just local completeness.
- Put the most decision-relevant or audience-relevant points early.
- Keep bullets parallel in wording and scope.
- Use stronger conclusion wording than article-style prose when appropriate.
- If source material is a business plan, prioritize pain point, solution, market, business model, traction, team, finance, and risk.
- If source material is technical, avoid turning every detail into a separate page; group details under fewer stronger themes.
- If the source is already chaptered, do not map every chapter directly to one slide unless the chapter structure already matches presentation logic.
- Prefer section titles that can be read aloud naturally in a presentation.

## Formatting Discipline

- Keep the whole outline in Chinese unless the user explicitly requests another language.
- Output only PPT-outline content, not meta explanations, unless the user asks for analysis.
- Keep title style, bullet style, and section depth consistent across slides.
- If a page uses numbered key points, keep the numbering style consistent for the whole outline.
- In strict mode, do not invent extra wrapper labels unless the user asks for them.

## Visual Hints

When useful, add a short hint for what the slide could visually contain, such as:

- chart
- flow
- comparison
- timeline
- architecture
- case
- key metric

Do not overuse visual hints. Only add them when they would clearly help slide design.

## Anti-Patterns

- Do not output article paragraphs as slide bullets.
- Do not copy the source table of contents directly unless it already fits presentation logic.
- Do not make every chapter of the source document equal to one slide by default.
- Do not create slides that are only definitions without narrative value.
- Do not overload one page with too many bullets, numbers, or subtopics.
- Do not create section titles that are broad but empty, such as generic “Overview” pages with no real message.
- Do not let the table of contents and the actual slide sequence drift apart in strict mode.

## Optional Output Wrapper

When helpful, structure the output as:

- Presentation title
- Target audience
- Suggested total slide count
- Slide-by-slide outline
- Optional appendix pages

For business-plan and competition scenarios, the following wrapper is often useful:

- Presentation title
- Presentation scenario
- Suggested page count
- Main deck outline
- Optional backup / appendix pages

## Quality Check

Before finalizing, check:

- Is this clearly a PPT outline rather than a summary article?
- Can each page be spoken in roughly 30 to 90 seconds?
- Is the opening strong enough?
- Is the ending clear enough?
- Are important business or decision points placed early enough?
- Is the total number of pages reasonable for the scenario?
- If a table of contents is present, does each section have a matching slide?
- In strict mode, are the slide titles and section titles fully aligned?

## Must Also Read If

- The source is a PDF:
  - `pdf-to-feishu.md`
- The source is a Word/docx file:
  - `word-to-feishu.md`
- The source is Markdown or TXT:
  - `markdown-to-feishu.md`
- The PPT outline is being written into an existing Feishu doc:
  - `existing-doc-safe-edit.md`
