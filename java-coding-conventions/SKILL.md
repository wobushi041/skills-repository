---
name: java-coding-conventions
description: Use when generating new Java/Spring Boot code, adding or refactoring Javadocs and comments, formatting existing classes, or writing unit tests (*Test.java) to enforce strict Chinese commenting, layer-specific Javadocs, and layout rules.
---

# 1. Commenting Rules (Highest Priority)

- **Language, Spacing & Refactoring Boundaries**:
  - **New Code**: Write ALL comments and new error/validation messages in **Chinese** (imperative verb phrases). ALWAYS keep 1 half-width space between Chinese characters and English words/numbers/identifiers (e.g., `注入 Redis 依赖`, `缺少题目 id 参数`).
  - **Commenting / Formatting Existing Code**: Modify ONLY comments and whitespace/formatting. **NEVER modify any existing string literals inside `"..."`** (including but not limited to existing exception messages, `@Size/@Min` validation messages, and log templates) or business logic.
  - **Key & Identifier Exemption**: **NEVER apply spacing or translation rules to any code keys or identifiers** (including but not limited to Redis keys, distributed lock keys, MQ exchange/queue/routing keys, Session attribute names, SQL table/column names, `@Value` property keys, and enum codes). Keep them 100% byte-for-byte untouched.
- **Class / Interface Header Javadoc**:
  - Format: Multi-line `/** ... */` -> Line 1: concise Chinese role summary (no period) -> `[Optional: * TODO: ...]` -> empty comment line ` *` -> `@author wobushi041`.
  - NEVER include `@date`, `@since`, `@createDate`, `@version`, `@TableName`, or `@Entity`.
- **Method Javadoc (100% Coverage)**:
  - EVERY method in `Controller`, `Service`, `ServiceImpl` (**including `@Override` methods**), `Manager`, `Utils`, `Config`, `Factory`, `MQ`, `Runner`, `Enum`, constructors, and **`private` helper methods** MUST have a multi-line Javadoc.
  - **Layer Focus Distinction**:
    - **`Service` Interface**: Describe **WHAT** business contract it fulfills (for callers), without exposing table names, cache keys, or lock details (e.g., `保存异常场景下的兜底聊天消息`).
    - **`ServiceImpl` Class**: Describe **HOW** the concrete mechanism works on `@Override` methods (for maintainers), specifying storage, cache strategy, distributed locks, or side effects (e.g., `兜底保存未成功落库的聊天消息至 Redis`).
    - **`Config` / `Factory` Class**: Describe the target Bean/instance and its core configuration strategy on `@Bean` or factory methods (e.g., `构建并注册自定义 JSON 序列化的 RedisTemplate 实例`).
  - **Tags**: Leave 1 blank comment line (` *`) before tags. Include `@param <name> <Chinese desc>` ONLY if parameters exist (align descriptions vertically with spaces). Include `@return <Chinese desc>` ONLY if return type is not `void` (and not a constructor). **NEVER include `@throws` or `@exception` tags**.
- **Model Layers (`Domain`, `Request`, `DTO`, `VO`, `Enum`) & `///` Section Dividers**:
  - **All Fields (100% 3-Line Javadoc)**: Use 3-line Javadoc (`/** \n * 中文含义 \n */`) for EVERY field across `Domain (Entity)`, `Request`, `DTO / Query`, `VO`, `Enum`, `Properties`, constants, and `@Resource` / `@Value` / `private final` dependencies, separated by 1 blank line.
  - **`Domain` (`model/domain`)**: Pure noun class names (`User`, `Team`). Keep `@TableId` / `@TableLogic` / `@TableField` annotations below the 3-line field Javadoc. Place `serialVersionUID` at the **very bottom** under `/// 序列化字段 ///` and **MUST annotate it with `@TableField(exist = false)`**.
  - **`Request` (`model/request`)**: Named `XxxRequest` (or `PageRequest`) for frontend input payloads. Place validation annotations (`@NotBlank`, `@Size`, `@Min`) below the 3-line field Javadoc. Place `serialVersionUID` at the **very bottom** under `/// 序列化字段 ///` (without `@TableField`).
  - **`DTO / Query` (`model/dto`) & `VO` (`model/vo`)**: `XxxQuery` / `XxxDTO` for internal/query transfer and `XxxVO` for desensitized frontend responses. If `Serializable`, place `serialVersionUID` at the **very bottom** under `/// 序列化字段 ///`.
  - **`Enum` (`model/enums`)**: Named `XxxEnum`. Give every enum constant a 3-line Javadoc separated by 1 blank line, and end the enum constant block with `;` on its own new line. Document all fields, constructors, getters, and lookup methods (`getEnumByValue`).
  - **Section Dividers (`/// 模块名称 ///`)**: Group functional sections in large classes using `/// 模块名称 ///` (e.g., `/// 认证相关接口 ///`). When commenting existing classes, **preserve the original method order** and only insert section headers above existing groups to avoid noisy `git diff` blocks.
- **Inline Phase & Unit Test Comments**:
  - **Production Code**: NEVER use numbered steps (`1. 2.`). Use unnumbered Chinese phase comments (`// 流量控制`, `// 参数检查`) separated by 1 blank line. Place `else if` / `else` explanations on the line above `else`.
  - **Unit Tests (`*Test.java`)**: Place `// 场景：测试 xxx` above `@Test`, and strictly use numbered steps inside: `// 1. 准备测试数据`, `// 2. 调用 xxx 方法`, `// 3. 断言响应体字段正确`.

# 2. Formatting & Architecture Rules

- **Indentation & Blank Lines**: 4 spaces for Java, 2 spaces for TS/React (NO Tabs). Leave 1 blank line after class `{`, before class `}`, and between EVERY constant, field, enum item, and method.
- **Braces & Validation**: K&R style (`{` at end of line); ALWAYS use `{}` for `if/else/for/while`. Prefer `ThrowUtils.throwIf(...)` + `assert obj != null;` where available. Place trailing `;` of multi-line `LambdaQueryWrapper` chains on its own aligned line.
- **Imports**: 2 groups separated by 1 blank line: (1) project + 3rd-party packages alphabetically, (2) `jakarta.* / javax.*` + `java.*` alphabetically (avoid wildcard `*` imports).
- **Model & Component Naming Suffixes**:
  - `model/domain` (Database Entities) -> Pure nouns (`User`, `Team`, `UserTeam`)
  - `model/request` (Frontend HTTP Requests) -> `XxxRequest` (`TeamAddRequest`, `UserLoginRequest`, `PageRequest`)
  - `model/dto` (Query Conditions / Internal DTOs / MQ Payloads) -> `XxxQuery` / `XxxDTO` / `XxxMessage` (`TeamQuery`)
  - `model/vo` (Frontend View Objects) -> `XxxVO` (`UserVO`, `TeamUserVO`)
  - `model/enums` (Enumerations) -> `XxxEnum` (`TeamStatusEnum`)
  - Middleware, Config & Constants -> `XxxManager` + `XxxConfig` + `XxxProperties` + `XxxFactory`, `interface XxxConstant`

# 3. All-in-One Reference Template

```java
/**
 * <模块中文职责概述，末尾无句号>
 * TODO: <可选待办说明>
 *
 * @author wobushi041
 */
@Service
public class XxxServiceImpl implements XxxService {

    /**
     * 注入 <组件名称> 依赖
     */
    @Resource
    private XxxManager xxxManager;

    /// <业务模块名称> ///

    /**
     * <HOW: 写明存储介质/缓存/锁等底层实现机制>（Service 接口层写 <WHAT: 写明对外业务契约>）
     *
     * @param xxxRequest    <短参数中文说明>
     * @param timeoutMillis <长参数中文说明，与上方说明保持左侧空格纵向对齐>
     * @return <返回值中文说明>
     */
    @Override
    public boolean doSomething(XxxRequest xxxRequest, long timeoutMillis) {
        // 参数检查
        if (xxxRequest == null) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR, "请求参数不能为空");
        }

        // 核心业务处理
        return xxxManager.execute(xxxRequest, timeoutMillis);
    }

    // --- Domain / Request / VO / DTO 模板片段 (Xxx.java / XxxRequest.java) ---
    // /**
    //  * <字段中文含义（枚举型字段注明取值，如：0 - 公开，1 - 私有）>
    //  */
    // private Integer status;
    //
    // /// 序列化字段 ///
    //
    // /**
    //  * 序列化版本号（注：Domain 实体类必须保留 @TableField(exist = false)，Request/VO/DTO 不加）
    //  */
    // @TableField(exist = false)
    // private static final long serialVersionUID = 1L;

    // --- 枚举模板片段 (XxxEnum.java) ---
    // /**
    //  * <枚举项中文含义>
    //  */
    // STATUS_A(0, "状态 A")
    // ;

    // --- 单元测试模板片段 (XxxServiceTest.java) ---
    // // 场景：测试 <被测场景描述>
    // @Test
    // void doSomething_shouldReturnTrue() {
    //     // 1. 准备测试数据
    //     // 2. 调用 doSomething 方法
    //     // 3. 断言响应结果正确
    // }

}
```

# 4. Pre-Output Verification Checklist

- [ ] Run `pwsh "E:/MyFinishProject/skills-repository/java-coding-conventions/scripts/verify-style.ps1" -TargetPath <src-or-file-path>` to automatically verify compliance before claiming completion.
- [ ] Does the class/interface header have `@author wobushi041` and NO `@date` / `@createDate` / `@TableName`?
- [ ] Do **ALL methods (including `@Override` and `private` helpers)** have multi-line Javadoc with space-aligned `@param`, `@return`, and **NO `@throws` tags**?
- [ ] Do `Service` (what/contract), `ServiceImpl` (how/mechanism), and `Config/Factory` (Bean & strategy) Javadocs have distinct focuses?
- [ ] Do all fields in `Domain`, `Request`, `DTO`, `VO`, `Enum`, `Properties`, constants, and `@Resource` dependencies have 3-line Javadocs separated by 1 blank line?
- [ ] Is `serialVersionUID` placed at the bottom under `/// 序列化字段 ///` for `Domain` (with `@TableField(exist = false)`), `Request`, `DTO`, `VO`, `BaseResponse`, and `BusinessException`?
- [ ] Is there 1 half-width space between all Chinese and English/numbers in comments without modifying any code keys or existing string literals?
- [ ] When commenting existing code, is the original method order and business logic 100% preserved?
