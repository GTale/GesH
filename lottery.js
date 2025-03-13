class LotterySystem {
  constructor(departments, { minPerDept = 1 } = {}) {
    this.departments = departments;
    this.minPerDept = minPerDept;
    this.awarded = new Set(); // 改用Set提升查询效率[citation:6]
    this.results = {
      first: [],
      second: [],
      third: [],
      fourth: [],
      fifth: [],
      sixth: []
    };
    this.currentGrade = 'first';
    this.gradeSequence = ['first', 'second', 'third', 'fourth', 'fifth', 'sixth'];
    this.progressiveGrades = new Set(['third', 'fourth', 'fifth', 'sixth']);
    this.deptStatus = new Map();
  }

  // 初始化部门状态（深拷贝处理）
  _initDeptStatus() {
    this.deptStatus = new Map(
      this.departments.map(dept => [
        dept.name,
        { 
          count: 0,
          // 创建员工对象副本避免污染原始数据[citation:4]
          remaining: dept.employees.map(e => ({ ...e })) 
        }
      ])
    );
  }

  // 主抽奖方法
  drawNext(awardsConfig) {
    if (!this.currentGrade) return { finished: true, winners: [] };
    
    const grade = this.currentGrade;
    const count = awardsConfig[grade];
    
    // 异常处理增强
    if (typeof count !== 'number' || count <= 0) {
      throw new Error(`无效的奖项数量配置: $${grade}`);
    }

    // 首次抽奖初始化
    if (grade === 'first') this._initDeptStatus();

    const winners = this.progressiveGrades.has(grade) 
      ? this._drawBalancedProgressivePrize(count)
      : this._drawRandomPrize(count);

    this._recordWinners(grade, winners);
    this._advanceGrade();

    return {
      finished: !this.currentGrade,
      grade,
      winners
    };
  }

  // 随机抽奖（使用Fisher-Yates洗牌算法）
  _drawRandomPrize(count) {
    const pool = this._getEligibleCandidates();
    return this._shuffle(pool).slice(0, count);
  }

  // 保底抽奖（优化分配策略）
  _drawBalancedProgressivePrize(count) {
    let remaining = count;
    const winners = [];
    const maxPerDept = Math.min(
      Math.ceil(count / this.departments.length),
      Math.floor(count / 2) // 限制单个部门最多获得50%名额[citation:3]
    );

    // 优先分配未达标部门
    this.departments.forEach(dept => {
      if (remaining <= 0) return;
      
      const status = this.deptStatus.get(dept.name);
      if (status.count >= this.minPerDept) return;

      const needed = Math.min(
        this.minPerDept - status.count,
        maxPerDept,
        remaining,
        status.remaining.filter(e => !this.awarded.has(e.id)).length
      );

      if (needed > 0) {
        const selected = this._selectFromDept(status.remaining, needed);
        winners.push(...selected);
        status.count += selected.length;
        remaining -= selected.length;
      }
    });

    // 分配剩余名额
    if (remaining > 0) {
      winners.push(...this._drawRandomPrize(remaining));
    }

    return winners;
  }

  // 辅助方法
  _advanceGrade() {
    const idx = this.gradeSequence.indexOf(this.currentGrade);
    this.currentGrade = this.gradeSequence[idx + 1];
  }

  _getEligibleCandidates() {
    return this.departments.flatMap(dept => 
      dept.employees.filter(e => !this.awarded.has(e.id))
    );
  }

  _shuffle(array) {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
  }

  _selectFromDept(employees, count) {
    return this._shuffle(
      employees.filter(e => !this.awarded.has(e.id))
    ).slice(0, count);
  }

  _recordWinners(grade, winners) {
    winners.forEach(winner => {
      this.awarded.add(winner.id);
      this.results[grade].push(winner);
    });
  }
}
