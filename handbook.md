# Handbook · 個人操作手冊

> 這份是給 Andrew 你自己當「使用者」時用的——當你忘了「該餵什麼資料 / 該下什麼指令 / 怎麼把現實裡聽到看到的東西塞進這個 wiki」時來查。
>
> **跟其他文件的關係：**
> - [README.md](README.md)——專案是什麼、quickstart
> - [METHODOLOGY.md](METHODOLOGY.md)——六階段 pipeline 的方法論細節
> - [CLAUDE.md](CLAUDE.md)——給 LLM 操作這個 repo 的規格書（你**不需要**讀，Claude 會自動讀）
> - **本檔 = 給「有雙手的人類」看的 SOP**：從你手上的東西、你遇到的情境出發

---

## Andrew 個人脈絡（給未來 session 的 Claude 讀）

> 這段是跨 session 的 user context。Claude 進新 session 時讀這段先建立背景，再進 §0 操作流程。

**使用者**：Andrew（jk831224@gmail.com）

**這個 wiki 跟其他系統的分工**：

| 知識性質 | 放哪 | 原因 |
|---|---|---|
| 可攜帶的個人知識（方法論、框架、跨主題反思、書摘、上課筆記、個人觀點累積、Threads 自貼）| **本 wiki**（andrew-llm-atomic-wiki）| 離開任何工作都帶得走；用 atom 層處理大量散落素材 |
| VMFive 業務、產品、組織、客戶、案件、會議、離職專案 | `~/pm-domain-explorer-agent/` | 那邊有完整的 Multi-Agent 編排、Skill Tree Preview、SQLite、6 固定 domain，是綁在 VMFive 業務上的工作 OS |
| 健身 raw data（InBody、每日營養、訓練量等時序數值）| Sheets / fitness apps | 時序數值不適合 atom（不是 claim）；但健身**方法論/觀察**可以進本 wiki 的對應 branch |

**已下的決定**：
- Fork 自 `cablate/llm-atomic-wiki`，rename 為 `jk831224/andrew-llm-atomic-wiki`
- `upstream` 指向原作者，可以 pull 上游更新
- handbook.md 從使用者視角寫（不複製 CLAUDE.md / METHODOLOGY.md 內容，只交叉引用）

**尚未決定的**（下次 session 第一件事可能是這個）：
- Branch 結構還沒設計，[atoms/](atoms/) 下還沒任何 branch 資料夾
- 第一批要 ingest 的素材還沒選

**判斷新素材該不該進本 wiki 的問法**：
> 「離開 VMFive 後，這份素材 / 觀點對我還有價值嗎？」
> - 是 → 進本 wiki
> - 否 → 進 pm-domain-explorer-agent 或別處

---

## §0 · 你需要先理解的三件事

### §0.1 三層心智模型

```
raw/      你丟原始素材的地方（Claude 只讀不寫）
atoms/    Claude 從 raw/ 萃取出的「一段一個 claim」的小檔案
wiki/     Claude 把多個相關 atoms 編譯成可讀的長文章
```

**重點**：你只負責往 `raw/` 丟東西 + 下指令。`atoms/` 和 `wiki/` 都是 Claude 寫的。

### §0.2 你要做的事只有四件

對應 [CLAUDE.md](CLAUDE.md) 的四個操作：

| 操作 | 你說什麼 | Claude 做什麼 |
|---|---|---|
| **Ingest** | 「ingest 這份素材」 | 讀 raw/、篩選、萃取成 atoms |
| **Compile** | 「把 X 主題編成 wiki」 | 把相關 atoms 組成 wiki 頁面 |
| **Query** | 「我之前在哪寫過 Y」 | 讀 index.md → 找到相關頁面 → 回答 |
| **Lint** | 「跑 lint」 | 檢查 wiki 一致性、過期、矛盾 |

### §0.3 第一次使用前必做：決定 branch

**branch = 你知識的主題大類別**。在 ingest 任何東西之前，你要先有 branch。

開新 session 跟 Claude 說：

```
我要設計這個 wiki 的 branch 結構。我大概想存這些主題：
- A 主題（簡述）
- B 主題（簡述）
- C 主題（簡述）
請依照 CLAUDE.md 的 4 條件（獨立、規模、邊界、教學獨立性）幫我評估，
給出最終建議的 branch 名稱（lowercase-hyphen 格式）+ 一句邊界定義。
```

確認後 Claude 會在 [atoms/](atoms/) 下開資料夾。**branch 不齊全沒關係，可以邊做邊加**。

---

## §1 · 我手上有 X → 該怎麼餵進 wiki

**核心原則：先把檔案放對位置，再下指令。** Claude 不會自動掃 `raw/`；你不講，Claude 不會知道有新東西。

### §1.1 Threads / IG / FB / Twitter 貼文

**情境**：看到別人一條好貼文、或自己寫過想存檔的貼文。

**怎麼放**：

| 子類 | 放哪 | 怎麼取得 |
|---|---|---|
| 自己 Threads 完整 export | `raw/threads/own/` | Threads 設定 → 下載資料 |
| 別人單條 Threads（含回覆樹）| `raw/threads/<shortcode>/` | 直接貼 URL 給 Claude，用 `/threads-digger` skill 自動抓 |
| IG 自己 export | `raw/ig/own/` | IG 設定 → 下載資料 |
| 單條 FB / Twitter 截下來 | `raw/posts/<source>/<date>-<topic>.md` | 手動 copy 貼文文字 |

**該說什麼**：

```
# 自己的 Threads export
ingest @raw/threads/own/，這是我自己的貼文歷史，
依 METHODOLOGY 預期 70-90% 萃取率

# 別人單條 Threads
分析這條 threads https://www.threads.net/@xxx/post/yyy
（threads-digger skill 會自動 fetch + 分析；分析完問 Claude
「這份 digest 哪些值得進 atoms？」）

# 自己手動 copy 的單條貼文
ingest @raw/posts/twitter/2026-05-11-prompt-engineering.md
```

**注意**：別人的貼文預設「reuse_score: medium」，你自己的觀點才預設 high。Claude 萃取時要保留「誰說的」（在 `source_ids` 標明）。

### §1.2 文章 / 部落格 / 網頁

**情境**：看到一篇好文章想消化進 wiki。

**怎麼放**：

| 來源 | 怎麼存 |
|---|---|
| 一般網頁 | 用 `/defuddle` 抓乾淨 markdown，存到 `raw/articles/<author-or-domain>/<date>-<title>.md` |
| 已經是 .md 的（如 GitHub README）| WebFetch 後直接存到 `raw/articles/` |
| 需要登入 / paywall | 自己手動 copy 全文存 `raw/articles/` |
| Substack / Medium 訂閱信 | Email 裡 copy 全文，存 `raw/articles/` |

**該說什麼**：

```
# 抓網頁
用 /defuddle 抓 https://example.com/article 存到 raw/articles/，
然後 ingest

# 已經存好的
ingest @raw/articles/karpathy/2026-04-llm-wiki.md
```

**萃取重點**：文章的萃取率應該很高（80-95%），但要分清「作者主張」vs「作者引用別人」——後者不算你的知識。

### §1.3 PDF / 簡報 / 講義

**情境**：上課講義、會議講義、買的電子書、產業報告。

**怎麼放**：

```
raw/lectures/<course-or-source>/<date>-<topic>.pdf
raw/books/<author>/<title>.pdf
raw/reports/<source>/<date>-<title>.pdf
```

**該說什麼**：

```
# PDF 直接 ingest
用 /pdf 把 raw/lectures/anthropic/2026-04-skill-design.pdf
轉文字後 ingest

# 簡報
用 /pptx 把 raw/lectures/xxx.pptx 轉文字後 ingest

# 大本的書，分章處理
ingest @raw/books/karpathy/llm-wiki.pdf 的第 1-3 章，
不要一次處理全部
```

**注意**：書籍類萃取率高、但量大，**分批 ingest**（一次 1-3 章），免得一次萃出 200 個 atoms 後品質失控。

### §1.4 Podcast / YouTube / 影片

**情境**：聽完一集 podcast 想記重點、看完一個 talk 想存洞見。

**怎麼放**：

```
raw/podcasts/<show>/<episode-id>-<title>.md   ← 自己邊聽邊打的筆記
raw/transcripts/<source>/<date>-<title>.md    ← 完整逐字稿（NotebookLM/Whisper 轉的）
```

**該說什麼**：

```
# 邊聽邊記的筆記（短）
ingest @raw/podcasts/lex/2026-05-karpathy-talk.md

# 完整逐字稿（長）
ingest @raw/transcripts/xxx.md，用 transcript 級別的萃取標準
（預期 40-60% 萃取率，跳過開場、寒暄、重複）
```

**建議**：影片內容如果你只聽完想記 3 個重點，**直接在 chat 講給 Claude**（見 §1.8），不需要存 raw 檔。要存逐字稿才走 ingest。

### §1.5 書籍 / 書摘

**情境**：讀完一本書想萃取核心觀點。

**選哪條路**：

| 我讀完的程度 | 路徑 |
|---|---|
| 已經讀完，要萃取自己的 takeaway | 跟 Claude 對話講重點 → §1.8 |
| 有 PDF 全文 + 想做完整萃取 | §1.3 分章 ingest |
| 還沒讀，想評估值不值得讀 | `/book-worthit` 先評估 |
| 看完想做書評 / 整合進已有主題 | 對話模式 → 萃成 atom 後可能 compile 進既有 wiki page |

### §1.6 截圖

**情境**：dashboard 截圖、聊天截圖、UI 範例、錯誤畫面。

**怎麼放**：

```
raw/screenshots/<context>/<date>-<topic>.png
```

**該說什麼**：

```
# 想萃取知識
分析 raw/screenshots/dashboard/2026-05-claude-token-usage.png
裡面有什麼值得 ingest 的觀點

# 純 debug context（不入庫）
直接拖進 chat
```

**注意**：截圖比較難「萃取成 atom」（圖片是 binary，atom 是文字）。比較好的做法是 **Claude 看圖 → 描述成文字 → 你補一兩句你的觀點 → 存成 .md → ingest**。

### §1.7 對話紀錄 / 訪談逐字稿

**情境**：跟 mentor 的對話、訪談稿、Slack/LINE/IG DM 的有意義對話。

**怎麼放**：

```
raw/conversations/<who>/<date>-<topic>.md
raw/interviews/<who>/<date>-<topic>.md
```

**該說什麼**：

```
# 訪談逐字稿（你訪別人 / 別人訪你）
用 /personal-transcript-analyst 分析
raw/interviews/2026-05-jane-doe.md，
分析完問我哪些 takeaway 值得 ingest

# 跟某人的長串對話
ingest @raw/conversations/mentor-x/2026-05-career-pivot.md
```

**注意**：別人的話要保留「誰說的」，你的觀察跟對方的觀點要分開萃成不同 atoms。

### §1.8 我的口述觀察 / 突然的想法（無檔案）

**情境**：你在散步、洗澡、開車時突然有個想法，想存下來。**沒有檔案，純口述**。

**直接在 chat 講就好，不需要建檔。**

```
我想分享一個觀察：[講你的觀察]
請幫我萃成 atom，建議放哪個 branch
```

Claude 會：
1. 跟你來回確認核心 claim
2. 問你 source_type（你會說「note」或「observation」）
3. 寫成 atom（檔名：`YYYY-MM-DD-<slug>.md`），存進對應 branch
4. 跟你確認 frontmatter（type / depth / reuse_score）

**這是最快的入庫方式**，建議養成「想到就講」的習慣。

### §1.9 既有筆記檔案（Obsidian / Notion / 散落 .md）

**情境**：你過去散落在各處的 .md 筆記，想搬進這個 wiki。

**怎麼放**：

```
raw/legacy/<source-system>/<original-path-or-date>.md
```

例如：

```
raw/legacy/obsidian/2024-q1/...
raw/legacy/notion/exported-2026-04-15/...
```

**該說什麼**：

```
ingest @raw/legacy/obsidian/，但採取保守萃取——
這些是過去 self-curated 的筆記，預設品質高，
但可能跨多個 branch，需要分類
```

**注意**：legacy 筆記常常一份 .md 包含多個主題，要請 Claude 「先做 segment classification 再 ingest」（見 [METHODOLOGY.md Phase 2](METHODOLOGY.md#phase-2-segment-classification)）。

---

## §2 · 我遇到 Y 情境 → 該怎麼處理

### §2.1 突然想到一個觀點

→ §1.8 直接講給 Claude，最快。

### §2.2 跟人聊天聽到值得記的話

**當下**：手機備忘錄記下「誰、在哪、說了什麼」。
**回家**：

```
我今天跟 [人] 在 [場合] 聽到他說：「[直接引述]」
我的反思是：[你的解讀]
請幫我萃成 atom——對方的話跟我的反思要分開
```

Claude 會萃出 1-2 個 atoms：一個記對方原話（type: opinion / source: 對方），一個記你的延伸（type: opinion / source: note / 你）。

### §2.3 參加分享會 / workshop / conference

**當下**：拍投影片、記筆記。
**回家**：

```
1. 投影片照片 → raw/events/<event-name>/slides/
2. 你的筆記 → raw/events/<event-name>/notes.md
3. 跟 Claude 說：
   「我去了 [event]，這是我的筆記和投影片，
    幫我消化——先告訴我你看到哪些主題，
    再讓我選哪些要 ingest」
```

**為什麼分兩步**：event 通常涵蓋很多主題、品質參差，先讓 Claude 列大綱你篩，再 ingest 你選的部分。

### §2.4 看完一本書 / 一篇論文

**長度短（<10 頁論文 / 簡短文章）**：直接 §1.3。

**長度長（書 / 教科書）**：

```
1. 先 /book-worthit 評估（如果還在猶豫讀不讀）
2. 讀完邊讀邊在某個 .md 記重點 → raw/books/<author>/<title>-takeaways.md
3. ingest 這份 takeaways
4. （可選）原書 PDF 進 raw/books/，但不全 ingest，當參考
```

### §2.5 完成一個案子 / 經歷一件事，想萃取教訓

```
1. 開檔 raw/cases/<date>-<case-name>.md
2. 自己寫下：
   - 發生什麼
   - 我做了什麼
   - 結果如何
   - 我學到什麼（最重要）
3. ingest，請 Claude 重點萃取「學到什麼」
4. （可選）/experience-extractor 做更深的周哈里窗萃取
```

### §2.6 多個來源指向同一個主題（要跨來源整合）

**例**：你在 A 文章看到一個觀點、B podcast 聽到呼應的、C 自己也想到。

```
1. 三個來源各自 ingest 成 atoms（會在同一個 branch）
2. 跟 Claude 說：
   「branch <X> 累積了一批 atoms 在談 [主題]，
    幫我 compile 成一篇 wiki page」
3. Claude 會找出 3-8 個相關 atoms，編成 wiki/<branch>-<topic>.md
```

→ 詳細見 §3.2。

### §2.7 我發現我之前萃過的 atom 觀點變了 / 過時了

**規則：atoms 不可變**（[CLAUDE.md](CLAUDE.md) 鐵律）。但知識會演進。處理方式：

```
我對 atom <id> 的觀點變了。新的 claim 是 [新的講法]。
請：
1. 寫一個新 atom 表達新主張
2. 在舊 atom frontmatter 加 superseded_by: <新 atom id>
3. 把舊 atom 移到 _archive/
4. 如果有 wiki page 引用過舊 atom，需要重 compile
```

不要直接改 atom——會破壞 source-of-truth 的不可變性。

---

## §3 · 該下什麼指令給 Claude（四操作詳解）

### §3.1 Ingest（萃取新素材成 atoms）

**最簡形式**：

```
ingest @raw/<path>
```

**完整形式**（建議第一批時用，校準品質）：

```
ingest @raw/<path>
- 預期 source_type: <post | article | transcript | note | ...>
- 第一批 10 個 segment 萃完先停，給我看品質，我校準後再繼續
- 不確定 branch 的標 deferred，不要硬塞
```

**你該檢查什麼**：
- atoms 寫得對嗎（一個 claim 一個 atom，沒混兩個主張）
- branch 分對嗎
- frontmatter 的 type / depth / reuse_score 合理嗎
- 有沒有「直接複製原文」沒做萃取（壞 atom，要重做）

### §3.2 Compile（把 atoms 編成 wiki page）

**什麼時候 compile**：
- 某個 branch 累積到 5+ atoms 在談相近主題
- 你想要某個主題能被「整篇讀」（atoms 是碎片）
- 為了之後 query 方便（query 主要讀 wiki，不讀 atoms）

**該說什麼**：

```
# 你知道要編什麼
compile branch <branch-name> 的「<主題>」，
我預期會用到這些 atoms：[列幾個 id]
（Claude 會自己找出全部相關 atoms）

# 你不知道有什麼可編
告訴我 branch <branch-name> 目前累積了什麼 atoms，
有哪些可以 compile 成 wiki page，給我候選清單

# 一個 branch 全部 compile
branch <branch-name> 的 atoms 都到了該整理的時候，
幫我規劃 wiki page 結構（幾頁、每頁範圍、預估 word count）
```

**你該檢查什麼**：
- wiki page 字數 1500-2500 word（太短 merge、太長 split）
- 有 `[[wiki-link]]` 連到其他相關 page（不要孤島）
- 末尾有 `*Compiled from atoms: ...*` 標明來源

**Compile 後必跑**：

```bash
./scripts/gen-index.sh
./scripts/log-append.sh "compiled <branch>-<topic>"
./scripts/lint.sh
```

或直接跟 Claude 說「跑完 compile 三件套」。

### §3.3 Query（問自己的 wiki）

**什麼時候 query**：
- 你想找之前寫過什麼
- 你要寫文章 / 演講前查資料
- 你要回答別人問題前找彈藥

**該說什麼**：

```
# 一般查
我之前在 wiki 寫過關於「<主題>」嗎？引用相關段落

# 跨主題綜合
從 wiki 找所有跟「<X>」有關的內容，給我綜合答案，
標明引用了哪幾個 page

# 要寫成新 atom
基於 wiki 已有的 [page-A] 和 [page-B]，
我認為 [新觀點]，請：
1. 評估這算不算新觀點
2. 如果是，幫我寫成新 atom 進 branch <X>
```

**Query 規則**（[CLAUDE.md](CLAUDE.md)）：
- Claude 應該先讀 [index.md](index.md)，不是全 wiki 掃
- Claude 應該標明引用了哪些 page（防止幻覺）
- Claude 應該分清「wiki 裡寫的」vs「我在 wiki 上面的綜合」

### §3.4 Lint（健康度檢查）

**兩層 lint，照順序跑**：

```bash
# 1. 程式 lint（秒級、確定性）
./scripts/lint.sh
# 看 lint-report.md 有沒有 error
```

如果通過，再跑 LLM lint：

```
跑 LLM lint：讀 index.md + 全 wiki，找：
- 矛盾（A page 說 X 是好做法、B page 說 X 過時）
- 概念缺口（多 page 引用某概念但沒專門 page）
- 過期 claim（版號、日期、temporal marker）
- 弱孤兒（連結是有但概念上脫節）
追加到 lint-report.md 的 ## LLM Lint 段
```

**多久跑一次**：
- 程式 lint：每次 compile / 改 wiki 後一定跑
- LLM lint：每週、或每次大批 ingest+compile 後

---

## §4 · 流程順序速查

### §4.1 第一次 setup（branch 還沒齊）

```
Day 1: 跟 Claude 對話設計 branch（§0.3）→ 產生 atoms/<branches>/
Day 2: 丟一小批 raw/ → ingest 試水溫 → 校準萃取品質
Day 3+: 大批 ingest → 累積 atoms → 第一次 compile
```

### §4.2 日常增量（branch 已齊、有東西要加）

```
1. 把素材丟對 raw/ 子資料夾
2. 跟 Claude 說「ingest @raw/<path>」
3. 校準前幾個 atoms 品質（必要時調整提示）
4. Claude 跑完，atoms 進 atoms/<branch>/
5. ./scripts/gen-index.sh + log-append.sh
6. 沒到 compile 規模就先這樣
```

### §4.3 主題成熟（單 branch 累積 5+ atoms 談相近主題）

```
1. 跟 Claude 說「branch <X> 的 atoms 哪些可以 compile」
2. 確認 compile 範圍 → Claude 寫 wiki/<slug>.md
3. ./scripts/gen-index.sh + log-append.sh + lint.sh
4. 修 lint 報出的 error
```

### §4.4 週期維護（建議週末跑）

```
1. ./scripts/lint.sh
2. 跟 Claude 說「跑 LLM lint」
3. 看 lint-report.md
4. 修矛盾、補缺口、verify 過期 claim
5. 必要時：archive 舊 atom + 重 compile 受影響 wiki page
```

### §4.5 重大主題完成（某 branch 已成熟、想對外發表）

```
1. 確認該 branch 全部 atoms 都已 compile 進 wiki page
2. 跑 lint
3. 把該 branch 的 wiki page 集合 export 出去
   （複製 / 轉 Obsidian / 發部落格）
4. atoms/<branch>/ 留著，未來新 atoms 進來再增量 compile
```

---

## §5 · raw/ 資料夾組織建議

`raw/` 是 gitignored、你愛怎麼組織都行。但建議按 **source 類型** 分子目錄（不是按 branch / 主題分）：

```
raw/
├── threads/         # Threads 貼文 / 回覆
├── posts/           # 其他平台貼文
├── articles/        # 文章
├── lectures/        # 課程講義
├── books/           # 書籍 / 書摘
├── podcasts/        # podcast 筆記
├── transcripts/     # 完整逐字稿
├── conversations/   # 對話紀錄
├── interviews/      # 訪談
├── events/          # 分享會 / workshop / conference
├── cases/           # 個人經歷 / case 反思
├── screenshots/     # 截圖
├── reports/         # 產業報告
├── legacy/          # 從舊系統搬來的筆記
└── temp/            # 臨時 staging（不確定要不要進的東西）
```

**為什麼按 source 不按主題**：
- 主題分類是 atoms 層的事（branch）
- 一份素材常跨多主題、但只屬於一個 source
- 萃取後 atoms 進對應 branch，raw 檔留原地當溯源

**檔案命名建議**：`<date>-<short-slug>.md`，例如：

```
raw/articles/karpathy/2026-04-llm-wiki.md
raw/conversations/mentor-x/2026-05-career-pivot.md
raw/threads/abc123/post-and-replies.md
```

---

## §6 · 我忘了 X → 怎麼救援

### §6.1 我忘了現在有哪些 branch

```bash
ls atoms/
```

或跟 Claude 說：

```
列出目前所有 branch + 每個的一句邊界定義
```

### §6.2 我忘了某個 atom 在哪 / 是否寫過

```
# Claude 查
我想找之前萃過的關於「<主題>」的 atom，搜尋 atoms/

# 或自己 grep
grep -ri "<關鍵字>" atoms/
```

### §6.3 我忘了某主題寫過 wiki 沒

```
# 看 index
cat index.md | grep -i <關鍵字>

# 或問 Claude
wiki 裡有寫過「<主題>」嗎
```

### §6.4 我忘了該下什麼指令

→ 翻 §3。或最簡單：

```
我手上有 X，想做 Y，請告訴我該怎麼操作這個 wiki
```

Claude 會自動讀 [CLAUDE.md](CLAUDE.md) 給你正確路徑。

### §6.5 我完全失憶

```
我打開了 LLM-Wiki 但完全忘記怎麼用，
請：
1. Read handbook.md
2. 告訴我目前有哪些 branch、累積了多少 atoms 和 wiki page
3. 推薦我下一步該做什麼
```

### §6.6 我忘了某個 atom 為什麼這樣寫

→ 看 atom frontmatter 的 `source_ids`，回去讀 raw/ 對應檔案。**這就是為什麼每個 atom 都要標 source**。

### §6.7 我忘了上次處理到哪

```
# 看變更日誌
cat log.md | tail -30

# 或問 Claude
我上次處理這個 wiki 是什麼時候、做了什麼
```

---

## §7 · 跟 Claude 的協作守則

### §7.1 我（使用者）該主動告訴 Claude 的

| 情境 | 主動說 |
|---|---|
| 新素材丟進 raw/ | 「我有新素材 @raw/<path>，幫我 ingest」（Claude 不會自動掃）|
| 突然有想法 | 「我想分享一個觀察」（直接 §1.8）|
| 對 atom 品質不滿 | 「上一批 atoms 第 N 個寫得太像複製，重萃」 |
| 想換方向 | 「停下來，這次只處理 X，其他先不動」 |
| 觀點變了 | 「atom <id> 觀點變了」→ 走 §2.7 supersede 流程 |

### §7.2 Claude 該做但常忘的

| Claude 該做 | 沒做時你補一句 |
|---|---|
| Ingest 後跑 gen-index + log-append | 「跑三件套」 |
| Compile 後跑 lint | 「跑 lint」 |
| 第一批校準後停下來等你看 | 你先說「第一批 N 個先停給我看」 |
| 不確定 branch 時標 deferred 而非硬塞 | 「不確定就 deferred，不要硬塞」 |
| 引用 wiki 答 query 時標來源 page | 「答案要標哪個 page」 |

### §7.3 何時該打斷 Claude

**該打斷**：
- Claude 開始大批寫 atoms 但你還沒看品質
- Claude 把不同主題的 claim 塞同一個 atom
- Claude 寫的方向跟你想的不同
- Claude 要建你沒同意的 branch

**不要打斷**：
- Claude 在跑 lint（讓他跑完）
- Claude 在對話釐清你的口述觀察（讓他問完）

### §7.4 校正方向常用句

| 我想 | 我說 |
|---|---|
| 完全停下來 | 「停下來」 |
| 縮小範圍 | 「這次只處理 X」 |
| 讓我看品質 | 「先處理 N 個給我看」 |
| 重新萃 | 「第 N 個重萃，原因是 Y」 |
| 換 branch | 「這 atom 改放 branch <Z>」 |
| 我自己接手 | 「接下來我自己寫」 |

### §7.5 Auto Mode 注意

進入 auto mode 時 Claude 會：
- 連續執行多步（ingest → gen-index → log-append → lint）
- 不會做破壞性操作（rm atoms / force push）→ 仍會問
- 不會 silently 改 atoms → 仍會問

你仍可隨時打斷。auto mode 不代表 Claude 失控，只是減少問問題的頻率。

---

## §8 · Session 結束前的自我檢查

| 檢查項 | 沒做的後果 |
|---|---|
| 有 ingest 嗎 → gen-index + log-append 跑了嗎 | index.md 沒更新、log.md 沒紀錄 |
| 有 compile 嗎 → lint 跑了嗎 | wiki 可能有 ghost link / orphan |
| 有大批新增嗎 → branch 數有沒有失控（單 branch >30 atoms）| 該拆了還沒拆 |
| 有重要決策（如 branch 邊界改了）→ 寫進 log.md 嗎 | 半年後忘了為什麼這樣分 |

---

## 附錄 A · 一頁速查

```
┌────────────────────────────────────────────────────────────┐
│ 第一次：先設計 branch（跟 Claude 對話）                     │
├────────────────────────────────────────────────────────────┤
│ 我手上有 X：                                                │
│   Threads/IG export   → raw/threads/ 或 raw/ig/            │
│   單條 Threads URL    → 直接貼 → /threads-digger           │
│   文章 URL            → /defuddle → raw/articles/          │
│   PDF / 講義          → raw/lectures/ 或 raw/books/        │
│   逐字稿              → raw/transcripts/                   │
│   截圖                → raw/screenshots/                   │
│   口述觀察            → 直接 chat（最快）                  │
│   既有筆記            → raw/legacy/                        │
│                                                             │
│   都跟 Claude 說：「ingest @raw/<path>」                    │
├────────────────────────────────────────────────────────────┤
│ 四操作：                                                    │
│   Ingest   → 「ingest @raw/<path>」                        │
│   Compile  → 「branch <X> 哪些可以 compile」                │
│   Query    → 「wiki 寫過 <主題> 嗎」                       │
│   Lint     → ./scripts/lint.sh + 「跑 LLM lint」           │
├────────────────────────────────────────────────────────────┤
│ 三件套（每次有變動跑）：                                    │
│   ./scripts/gen-index.sh                                    │
│   ./scripts/log-append.sh "what you did"                    │
│   ./scripts/lint.sh （compile 後）                          │
├────────────────────────────────────────────────────────────┤
│ 失憶救援：                                                  │
│   忘了 branch       → ls atoms/                             │
│   忘了寫過沒        → grep atoms/ 或 cat index.md           │
│   忘了上次做啥      → cat log.md | tail                     │
│   完全失憶          → 「Read handbook.md，告訴我下一步」    │
└────────────────────────────────────────────────────────────┘
```

## 附錄 B · 不要做的事

- 不要直接編輯 atoms（atom 是不可變的；要改走 §2.7 supersede 流程）
- 不要寫進 raw/（Claude 只讀，你寫了 Claude 不會主動掃）
- 不要叫 Claude 自己發明 branch（branch 設計要你拍板）
- 不要把 wiki 當 source of truth（atoms 才是；wiki 錯了要回去改 atom）
- 不要 silently 刪 atom 或 wiki page（用 `_archive/`）
- 不要平行 compile 不同 page 但沒先 lock slug（會撞名）
- 不要假設 Claude 會主動掃 raw/（你不講，Claude 不知道有新東西）

## 附錄 C · 跟其他文件的索引

| 我想找 | 去哪 |
|---|---|
| 專案是什麼 | [README.md](README.md) |
| 方法論細節（六階段 pipeline）| [METHODOLOGY.md](METHODOLOGY.md) |
| Claude 的操作規格（你不需要讀） | [CLAUDE.md](CLAUDE.md) |
| 變更歷史 | [log.md](log.md)（要先有東西才會生成）|
| Wiki 索引 | [index.md](index.md)（要先有 wiki page 才會生成）|
| Lint 報告 | [lint-report.md](lint-report.md)（要先跑過才會生成）|
| Atom 模板 | [atoms/_template.md](atoms/_template.md) |
| Wiki 模板 | [wiki/_template.md](wiki/_template.md) |

---

**最後更新**：2026-05-11
**維護方式**：每次發現「我忘了 X」沒被 §6 涵蓋、或某類素材沒在 §1 列出，補上對應段落。
