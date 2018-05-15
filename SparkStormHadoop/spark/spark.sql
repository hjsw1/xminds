
SqlParser
SqlParser的功能就是将SQL语句解析成Unresolved LogicalPlan。现阶段的SqlParser语法解析功能比较简单，支持的语法比较有限。其解析过程中有两个关键组件和一个关键函数：
词法读入器SqlLexical，其作用就是将输入的SQL语句进行扫描、去空、去注释、校验、分词等动作。
SQL语法表达式query，其作用定义SQL语法表达式，同时也定义了SQL语法表达式的具体实现，即将不同的表达式生成不同sparkSQL的Unresolved LogicalPlan。
函数phrase()，上面个两个组件通过调用phrase(query)(new lexical.Scanner(input))，完成对SQL语句的解析；在解析过程中，SqlLexical一边读入，一边解析，如果碰上生成符合SQL语法的表达式时，就调用相应SQL语法表达式的具体实现函数，将SQL语句解析成Unresolved LogicalPlan。

Analyzer
Analyzer的功能就是对来自SqlParser的Unresolved LogicalPlan中的UnresolvedAttribute项和UnresolvedRelation项，对照catalog和FunctionRegistry生成Analyzed LogicalPlan

Optimizer
Optimizer的功能就是将来自Analyzer的Analyzed LogicalPlan进行多种rule优化，生成Optimized LogicalPlan

Planner将LogicalPlan转换成PhysicalPlan
