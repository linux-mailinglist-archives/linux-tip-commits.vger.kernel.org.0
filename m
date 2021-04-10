Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B979635AD05
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Apr 2021 13:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhDJLjL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 10 Apr 2021 07:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhDJLjL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 10 Apr 2021 07:39:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B111BC061762;
        Sat, 10 Apr 2021 04:38:56 -0700 (PDT)
Date:   Sat, 10 Apr 2021 11:38:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618054728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITi7bi6xSutRev64wLK9JPZJg1OEWebQLDEmdkBSCAk=;
        b=TTfmPEB1QYFiGu1nIFlZvE3+0g2xsYXOrrm1VCoH6ZrdMswrUAKCeVeUHklLGDNY0jYNy7
        j8HRnAu49Y4NcpX6Sp4nMeQFncaQ8RMGdyB68Eii6d4kIgsw7UpQHHJWrpqBuFiLL5Gwgv
        ftfHzpBKkMEi5LTTxV08bAEL927+s+X1RHeOjctMaVGhc9a5b28a4P6oDuDdgqWlWiB34P
        lxpoSQy+mGGyStIY0mWOpkZSJq2ydhQD0BodMxDRYRevOR4fYmJusTYcQqPnEiXo/enCCr
        UZhnq9LmCNDM/0RiU/wQqnK88KJjK12WY1OGuuRoXoE827k67IXj1t2b+wAOTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618054728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ITi7bi6xSutRev64wLK9JPZJg1OEWebQLDEmdkBSCAk=;
        b=gbNgGgsDnSgMm8mOGTlpeElHtEgsCRq8RXoQ5GXy24VqONCX8Os6Yyce6gEzUQGD0gT4Wo
        X3OUgpo/mMkqZdAQ==
From:   "tip-bot2 for Tetsuo Handa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] kernel: Initialize cpumask before parsing
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210401055823.3929-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20210401055823.3929-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Message-ID: <161805472789.29796.5155765313252278244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c5e3a41187ac01425f5ad1abce927905e4ac44e4
Gitweb:        https://git.kernel.org/tip/c5e3a41187ac01425f5ad1abce927905e4ac44e4
Author:        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
AuthorDate:    Thu, 01 Apr 2021 14:58:23 +09:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 10 Apr 2021 13:35:54 +02:00

kernel: Initialize cpumask before parsing

KMSAN complains that new_value at cpumask_parse_user() from
write_irq_affinity() from irq_affinity_proc_write() is uninitialized.

  [  148.133411][ T5509] =====================================================
  [  148.135383][ T5509] BUG: KMSAN: uninit-value in find_next_bit+0x325/0x340
  [  148.137819][ T5509]
  [  148.138448][ T5509] Local variable ----new_value.i@irq_affinity_proc_write created at:
  [  148.140768][ T5509]  irq_affinity_proc_write+0xc3/0x3d0
  [  148.142298][ T5509]  irq_affinity_proc_write+0xc3/0x3d0
  [  148.143823][ T5509] =====================================================

Since bitmap_parse() from cpumask_parse_user() calls find_next_bit(),
any alloc_cpumask_var() + cpumask_parse_user() sequence has possibility
that find_next_bit() accesses uninitialized cpu mask variable. Fix this
problem by replacing alloc_cpumask_var() with zalloc_cpumask_var().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20210401055823.3929-1-penguin-kernel@I-love.SAKURA.ne.jp

---
 kernel/irq/proc.c    | 4 ++--
 kernel/profile.c     | 2 +-
 kernel/trace/trace.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9813878..7c5cd42 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -144,7 +144,7 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
 		return -EIO;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	if (type)
@@ -238,7 +238,7 @@ static ssize_t default_affinity_write(struct file *file,
 	cpumask_var_t new_value;
 	int err;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(buffer, count, new_value);
diff --git a/kernel/profile.c b/kernel/profile.c
index 6f69a41..c2ebddb 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -430,7 +430,7 @@ static ssize_t prof_cpu_mask_proc_write(struct file *file,
 	cpumask_var_t new_value;
 	int err;
 
-	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(buffer, count, new_value);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index eccb4e1..7607dc8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4827,7 +4827,7 @@ tracing_cpumask_write(struct file *filp, const char __user *ubuf,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
-	if (!alloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
 
 	err = cpumask_parse_user(ubuf, count, tracing_cpumask_new);
