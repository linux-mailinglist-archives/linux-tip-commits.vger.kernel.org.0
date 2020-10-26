Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B21298CFD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1735179AbgJZMlu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:41:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39680 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbgJZMlu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:41:50 -0400
Date:   Mon, 26 Oct 2020 12:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716107;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=g+QG5IGW0Cj12ZEpiCnl0opMi2izM1VC8Y9NT0oYVKI=;
        b=UF54oKoIjBRn12FZvGWQ66+t4Ke5O6zHkvoERI8x93ilMmNmrlCXTkETrTpFuseM3LmuT2
        SswQeQr3ViaOClGYxwLR/44GixA84jZxK5p9QEYGDj2ypUzc5p7XjhfCVaOH2u6brRAuN2
        BIR4MQqzw6cnL+4gtbE1lYK7f6w/7FVLfXKKVahnEeBkkyYaaR/keD7aC9tRY/hjJUtZd1
        +jxqg/9cfKYxbqDIvmVbTr0TeQhW4ggXoblvHh7EYrK2C9JgafZV5CjUJyjJkhodDbmuHU
        d2T56PtEIQ9nXFY99LkHPyuZegtgnKRVELHKEQw8Qz9eIk65Ay0szT2iO35a+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716107;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=g+QG5IGW0Cj12ZEpiCnl0opMi2izM1VC8Y9NT0oYVKI=;
        b=gnrW+RMPVmJfzpqCALxnfEHdE2ZE7Vx153U9nqQSFBWgynJGrVdLG/pzZ3SRhh6PgRsu2H
        to7OgcG1ixCbW3DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] lockdep: Fix preemption WARN for spurious IRQ-enable
Cc:     syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com,
        kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160371610624.397.4200695260381193885.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     f8e48a3dca060e80f672d398d181db1298fbc86c
Gitweb:        https://git.kernel.org/tip/f8e48a3dca060e80f672d398d181db1298fbc86c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 22 Oct 2020 12:23:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Oct 2020 12:37:22 +02:00

lockdep: Fix preemption WARN for spurious IRQ-enable

It is valid (albeit uncommon) to call local_irq_enable() without first
having called local_irq_disable(). In this case we enter
lockdep_hardirqs_on*() with IRQs enabled and trip a preemption warning
for using __this_cpu_read().

Use this_cpu_read() instead to avoid the warning.

Fixes: 4d004099a6 ("lockdep: Fix lockdep recursion")
Reported-by: syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3e99dfe..fc206ae 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4057,7 +4057,7 @@ void lockdep_hardirqs_on_prepare(unsigned long ip)
 	if (unlikely(in_nmi()))
 		return;
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
+	if (unlikely(this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (unlikely(lockdep_hardirqs_enabled())) {
@@ -4126,7 +4126,7 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 		goto skip_checks;
 	}
 
-	if (unlikely(__this_cpu_read(lockdep_recursion)))
+	if (unlikely(this_cpu_read(lockdep_recursion)))
 		return;
 
 	if (lockdep_hardirqs_enabled()) {
