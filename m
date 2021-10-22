Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8633B437A34
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Oct 2021 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhJVPoV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Oct 2021 11:44:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbhJVPoU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Oct 2021 11:44:20 -0400
Date:   Fri, 22 Oct 2021 15:42:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634917321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J/2cE55mamwnR8HTiDCvPJIxSOFaUQMjuoic+ewUOcI=;
        b=PtV5L4qkz2Cn59vRoFtt7AweRlP8YfPqPrEnNzuQkvZtoblvn0M4MsFQ3EVssjc/EZ8FdC
        pAiHyc/Nxe5amoD1TNf+vabHZ0fGw2oZwDO5zoiKwV+XuETZOddvw7qGrux1AqQy7VPgHo
        DuM3ZE5Vs3yWlCcgQlv6Lbp48f1drEQlttl7c76pW7/mNgbXf5mai6OuDOZqyM8ka+/oQH
        q3XIqwce44mWVcnYtLK+VSx5kKW6L3/WzU1MZ2d2V8gNr5lG5SUyMj7+63UklewFdbDrKl
        dKvenaZb6Jp/U526dXVMBjcwOlISb+Eqt8aeY/trlHEeS9CJ0mBr7TTYIvTv1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634917321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J/2cE55mamwnR8HTiDCvPJIxSOFaUQMjuoic+ewUOcI=;
        b=yKcJ4yXktORCN2uL9Y+vDuVSrTPgGEwYiIvFHzbI7wqhRFK0lG1W1vLY/OmkyoZ87zrBOD
        jGA32HPlTqgyDvAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Improve wake_up_all_idle_cpus() take #2
Cc:     syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com,
        Pavel Machek <pavel@ucw.cz>,
        Qian Cai <quic_qiancai@quicinc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163491732050.626.7063177885840173683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     96611c26dc351c33f73b48756a9feacc109e5bab
Gitweb:        https://git.kernel.org/tip/96611c26dc351c33f73b48756a9feacc109e5bab
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 18 Oct 2021 16:41:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Oct 2021 15:32:46 +02:00

sched: Improve wake_up_all_idle_cpus() take #2

As reported by syzbot and experienced by Pavel, using cpus_read_lock()
in wake_up_all_idle_cpus() generates lock inversion (against mmap_sem
and possibly others).

Instead, shrink the preempt disable region by iterating all CPUs and
checking the online status for each individual CPU while having
preemption disabled.

Fixes: 8850cb663b5c ("sched: Simplify wake_up_*idle*()")
Reported-by: syzbot+d5b23b18d2f4feae8a67@syzkaller.appspotmail.com
Reported-by: Pavel Machek <pavel@ucw.cz>
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Qian Cai <quic_qiancai@quicinc.com>
---
 kernel/smp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index ad0b68a..01a7c17 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1170,14 +1170,12 @@ void wake_up_all_idle_cpus(void)
 {
 	int cpu;
 
-	cpus_read_lock();
-	for_each_online_cpu(cpu) {
-		if (cpu == raw_smp_processor_id())
-			continue;
-
-		wake_up_if_idle(cpu);
+	for_each_possible_cpu(cpu) {
+		preempt_disable();
+		if (cpu != smp_processor_id() && cpu_online(cpu))
+			wake_up_if_idle(cpu);
+		preempt_enable();
 	}
-	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
