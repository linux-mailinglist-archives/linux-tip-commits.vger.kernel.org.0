Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC942EDFB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbhJOJrT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48952 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbhJOJrK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:10 -0400
Date:   Fri, 15 Oct 2021 09:45:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICxcCSDP/hRrYPxGnlmKMnICQeRSLRDXE8Ew82SnMGc=;
        b=zdK3Myr1JmDVo6i5LSJ2jO+jDPqroRc9nvxpNaZHfa6f7C3IjI8k22pdA2Z9xyLetwenRM
        zlxISIGE6d6EUzPu06KebqikFTzmv/eHJf5LRSyOInsLsMUwUXa1/KV2AL7jqkJQ3xqEXe
        XeodqsLIgjr2Lv4a81hxYDdb6iqsGWZQATGvFOUGYEecGiw+NtKydUgaIqn/ORrIy2w58g
        PGjOTARtDzwmTFhdIE+J0LgkqlkRsmbylYw5B6mCHzZV4TbNVORZYyzmUgQ9f2+9HVEhe/
        O3hkdNg5RCVuSCfeW6wqkLyOoLBtyGCicuZeNOXisOiQ6gBk/im2uC1D7reD9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICxcCSDP/hRrYPxGnlmKMnICQeRSLRDXE8Ew82SnMGc=;
        b=UmgxTEQksikqQCmKiwcOzzEBJL9Enu/dFUD4YQTqjfNuBTC+QdwbY2xfvaLZsOlqFY6KlY
        Mqpzm6I4OMj59FBg==
From:   "tip-bot2 for Qi Zheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86: Fix get_wchan() to support the ORC unwinder
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211008111626.271115116@infradead.org>
References: <20211008111626.271115116@infradead.org>
MIME-Version: 1.0
Message-ID: <163429110248.25758.1547119361326479585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bc9bbb81730ea667c31c5b284f95ee312bab466f
Gitweb:        https://git.kernel.org/tip/bc9bbb81730ea667c31c5b284f95ee312bab466f
Author:        Qi Zheng <zhengqi.arch@bytedance.com>
AuthorDate:    Wed, 29 Sep 2021 15:02:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:14 +02:00

x86: Fix get_wchan() to support the ORC unwinder

Currently, the kernel CONFIG_UNWINDER_ORC option is enabled by default
on x86, but the implementation of get_wchan() is still based on the frame
pointer unwinder, so the /proc/<pid>/wchan usually returned 0 regardless
of whether the task <pid> is running.

Reimplement get_wchan() by calling stack_trace_save_tsk(), which is
adapted to the ORC and frame pointer unwinders.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211008111626.271115116@infradead.org
---
 arch/x86/kernel/process.c | 51 ++------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e..e645925 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -944,58 +944,13 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
-	int count = 0;
+	unsigned long entry = 0;
 
 	if (p == current || task_is_running(p))
 		return 0;
 
-	if (!try_get_task_stack(p))
-		return 0;
-
-	start = (unsigned long)task_stack_page(p);
-	if (!start)
-		goto out;
-
-	/*
-	 * Layout of the stack page:
-	 *
-	 * ----------- topmax = start + THREAD_SIZE - sizeof(unsigned long)
-	 * PADDING
-	 * ----------- top = topmax - TOP_OF_KERNEL_STACK_PADDING
-	 * stack
-	 * ----------- bottom = start
-	 *
-	 * The tasks stack pointer points at the location where the
-	 * framepointer is stored. The data on the stack is:
-	 * ... IP FP ... IP FP
-	 *
-	 * We need to read FP and IP, so we need to adjust the upper
-	 * bound by another unsigned long.
-	 */
-	top = start + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
-	top -= 2 * sizeof(unsigned long);
-	bottom = start;
-
-	sp = READ_ONCE(p->thread.sp);
-	if (sp < bottom || sp > top)
-		goto out;
-
-	fp = READ_ONCE_NOCHECK(((struct inactive_task_frame *)sp)->bp);
-	do {
-		if (fp < bottom || fp > top)
-			goto out;
-		ip = READ_ONCE_NOCHECK(*(unsigned long *)(fp + sizeof(unsigned long)));
-		if (!in_sched_functions(ip)) {
-			ret = ip;
-			goto out;
-		}
-		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && !task_is_running(p));
-
-out:
-	put_task_stack(p);
-	return ret;
+	stack_trace_save_tsk(p, &entry, 1, 0);
+	return entry;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
