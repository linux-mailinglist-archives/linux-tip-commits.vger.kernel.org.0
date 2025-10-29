Return-Path: <linux-tip-commits+bounces-7097-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A98C1A28D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 13:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11B5F1892D01
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 12:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF472FDC5D;
	Wed, 29 Oct 2025 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xB2rBs6K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KRIsujMf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5E2F744B;
	Wed, 29 Oct 2025 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740180; cv=none; b=mIKUVnfTwZp9FZHxqJyiqoB/l+zLLszKuTmNzseC3zGIDyAPWxtQQIA2tC5RvcWA0Ecfy+csC15wI2W78xm3nbIdmiiGR4dIyDWNtgOvA5BkHhprvVHfrwitx7Qfdi1DGoXdGiIOrSuEoo/Wnx6VZ30AzZLTubL9jJ2+xylZK8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740180; c=relaxed/simple;
	bh=ICwUemZd5nIIKgcKrUJx2EyfUH1K0MeWHv0Y75FLaPo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BtS4I+3jl0SrR9LYaYxrHLvwL01tMWSilPuXF26FNmV62so8+lC1wRDELnzYSt1gEkfQX8Zy39DFpyYnXxpcyJD5ta23LBqB8iTDwBMXkJHCtAvJAgq2dPKvC24TGgO3Rl3QAdpxNymCMXHhVQ0hCy1jZYoLFFhmvIko1E4lFD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xB2rBs6K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KRIsujMf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 12:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761740177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg8xc8Je+Ajb1Qeo+LRheMx0pBRpQw/nner2cAfbt38=;
	b=xB2rBs6K7XfZtdzJxDW1iIWREEvOhZiap0mLR3kUbgV3PQajzvjH9yuYfWG3/uTAIiqVMR
	ufxwu7Sx11Z+jTnn0/pSo9asRC1H03dpy3gGDJz7zqElMg3YDRV7yjq0uKuJ7JOKkfjEZ5
	GMsJ4uXM5fbiltLY+e76lQ/mZfzn6XtobYlXUPNYEJIIv3uf0Sq/1QDTySxIK9oYWenP3d
	ZdDGUxe8IrmE95HIFKEUboQn0u4yVS4zYEWQ4Y2CV02Ye145bAWN4HIy/ZfNv32sFkPH3b
	bXekGcQqoZ821jWPQDSM9xBL6AZdlp8iM+0cq8TmEOJ1jzxS/wgtBXwkGP/XuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761740177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kg8xc8Je+Ajb1Qeo+LRheMx0pBRpQw/nner2cAfbt38=;
	b=KRIsujMfVFuMNd/I8awdBKbiXGNcmSEg6GQnZo3MqJUabxqWBL/BUsB2nkAgIkyxlVLhaU
	G7rMZ5j8ULxjacBQ==
From: "tip-bot2 for Tengda Wu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/dumpstack: Prevent KASAN false positive warnings
 in __show_regs()
Cc: Tengda Wu <wutengda@huaweicloud.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251023090632.269121-1-wutengda@huaweicloud.com>
References: <20251023090632.269121-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176174017540.2601451.6366228429551447185.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ced37e9ceae50e4cb6cd058963bd315ec9afa651
Gitweb:        https://git.kernel.org/tip/ced37e9ceae50e4cb6cd058963bd315ec9a=
fa651
Author:        Tengda Wu <wutengda@huaweicloud.com>
AuthorDate:    Thu, 23 Oct 2025 09:06:32=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Oct 2025 13:07:21 +01:00

x86/dumpstack: Prevent KASAN false positive warnings in __show_regs()

When triggering a stack dump via sysrq (echo t > /proc/sysrq-trigger),
KASAN may report false-positive out-of-bounds access:

  BUG: KASAN: out-of-bounds in __show_regs+0x4b/0x340
  Call Trace:
    dump_stack_lvl
    print_address_description.constprop.0
    print_report
    __show_regs
    show_trace_log_lvl
    sched_show_task
    show_state_filter
    sysrq_handle_showstate
    __handle_sysrq
    write_sysrq_trigger
    proc_reg_write
    vfs_write
    ksys_write
    do_syscall_64
    entry_SYSCALL_64_after_hwframe

The issue occurs as follows:

  Task A (walk other tasks' stacks)           Task B (running)
  1. echo t > /proc/sysrq-trigger
  show_trace_log_lvl
    regs =3D unwind_get_entry_regs()
    show_regs_if_on_stack(regs)
                                              2. The stack value pointed by
                                                 `regs` keeps changing, and
                                                 so are the tags in its
                                                 KASAN shadow region.
      __show_regs(regs)
        regs->ax, regs->bx, ...
          3. hit KASAN redzones, OOB

When task A walks task B's stack without suspending it, the continuous changes
in task B's stack (and corresponding KASAN shadow tags) may cause task A to
hit KASAN redzones when accessing obsolete values on the stack, resulting in
false positive reports.

Simply stopping the task before unwinding is not a viable fix, as it would
alter the state intended to inspect. This is especially true for diagnosing
misbehaving tasks (e.g., in a hard lockup), where stopping might fail or hide
the root cause by changing the call stack.

Therefore, fix this by disabling KASAN checks during asynchronous stack
unwinding, which is identified when the unwinding task does not match the
current task (task !=3D current).

  [ bp: Align arguments on function's opening brace. ]

Fixes: 3b3fa11bc700 ("x86/dumpstack: Print any pt_regs found on the stack")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/all/20251023090632.269121-1-wutengda@huaweiclo=
ud.com
---
 arch/x86/kernel/dumpstack.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 71ee201..b10684d 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -181,8 +181,8 @@ static void show_regs_if_on_stack(struct stack_info *info=
, struct pt_regs *regs,
  * in false positive reports. Disable instrumentation to avoid those.
  */
 __no_kmsan_checks
-static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *reg=
s,
-			unsigned long *stack, const char *log_lvl)
+static void __show_trace_log_lvl(struct task_struct *task, struct pt_regs *r=
egs,
+				 unsigned long *stack, const char *log_lvl)
 {
 	struct unwind_state state;
 	struct stack_info stack_info =3D {0};
@@ -303,6 +303,25 @@ next:
 	}
 }
=20
+static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *reg=
s,
+			       unsigned long *stack, const char *log_lvl)
+{
+	/*
+	 * Disable KASAN to avoid false positives during walking another
+	 * task's stacks, as values on these stacks may change concurrently
+	 * with task execution.
+	 */
+	bool disable_kasan =3D task && task !=3D current;
+
+	if (disable_kasan)
+		kasan_disable_current();
+
+	__show_trace_log_lvl(task, regs, stack, log_lvl);
+
+	if (disable_kasan)
+		kasan_enable_current();
+}
+
 void show_stack(struct task_struct *task, unsigned long *sp,
 		       const char *loglvl)
 {

