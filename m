Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03BE298D43
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775684AbgJZMwm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:52:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39856 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773165AbgJZMwk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:40 -0400
Date:   Mon, 26 Oct 2020 12:52:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Swv217vlI9IVqG7kr0H4qCMk7dhVLdh3BE+GSI6xYk0=;
        b=HmF6Yb5/byl7F4rqOVGlQ4rhqvcHSFw89E6UohJzWHNZu+BN27xMhxAfqfdSNSW8TVbhgI
        DDWms7VlnMyNEDGAnY5p6STU9+x3ilyaew1pTFmPYjoILHpEpCNpjUIFR4EwQPNdVXKinL
        tbaaRzo4KdifxJjZj0s65R1K/+wB1Sm99z+WW7fwJdN0XWejj4vDSAMoknbGbO91QfgApe
        gCpr/TZ+d4HXG7IzUd8BSRhm2PQMB1HY6u0KgMG5vDs+IMBq/1oM15I1cgGVK9f+cCi9vm
        ZdK+K+FxVz8NaDJl3YB8KByOClU+LfGDT9LFoYygYVeu+3gVBT6mS0PYIPl7gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716758;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Swv217vlI9IVqG7kr0H4qCMk7dhVLdh3BE+GSI6xYk0=;
        b=WXTjdvwxL0YKt2IazXZ3VvZFnGf+o0YwTmztTeQZXLNQQRtcgllawSBB4+Bz0gCEOmKw5n
        eC9uli6v34J14UCw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] perf/x86: Avoid TIF_IA32 when checking 64bit mode
Cc:     Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-2-krisman@collabora.com>
References: <20201004032536.1229030-2-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675782.397.17306753235601581801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     375d4bfda57392f0865dae051e1c4bd2700e8d71
Gitweb:        https://git.kernel.org/tip/375d4bfda57392f0865dae051e1c4bd2700e8d71
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:27 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:46 +01:00

perf/x86: Avoid TIF_IA32 when checking 64bit mode

In preparation to remove TIF_IA32, stop using it in perf events code.

Tested by running perf on 32-bit, 64-bit and x32 applications.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201004032536.1229030-2-krisman@collabora.com

---
 arch/x86/events/core.c      | 2 +-
 arch/x86/events/intel/ds.c  | 2 +-
 arch/x86/events/intel/lbr.c | 2 +-
 arch/x86/kernel/perf_regs.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a88c94d..77b963e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2602,7 +2602,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 	struct stack_frame_ia32 frame;
 	const struct stack_frame_ia32 __user *fp;
 
-	if (!test_thread_flag(TIF_IA32))
+	if (user_64bit_mode(regs))
 		return 0;
 
 	cs_base = get_segment_base(regs->cs);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 404315d..99a59f3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1259,7 +1259,7 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 		old_to = to;
 
 #ifdef CONFIG_X86_64
-		is_64bit = kernel_ip(to) || !test_thread_flag(TIF_IA32);
+		is_64bit = kernel_ip(to) || any_64bit_mode(regs);
 #endif
 		insn_init(&insn, kaddr, size, is_64bit);
 		insn_get_length(&insn);
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8961653..1aadb25 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1221,7 +1221,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 	 * on 64-bit systems running 32-bit apps
 	 */
 #ifdef CONFIG_X86_64
-	is64 = kernel_ip((unsigned long)addr) || !test_thread_flag(TIF_IA32);
+	is64 = kernel_ip((unsigned long)addr) || any_64bit_mode(current_pt_regs());
 #endif
 	insn_init(&insn, addr, bytes_read, is64);
 	insn_get_opcode(&insn);
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index bb7e113..9332c49 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -123,7 +123,7 @@ int perf_reg_validate(u64 mask)
 
 u64 perf_reg_abi(struct task_struct *task)
 {
-	if (test_tsk_thread_flag(task, TIF_IA32))
+	if (!user_64bit_mode(task_pt_regs(task)))
 		return PERF_SAMPLE_REGS_ABI_32;
 	else
 		return PERF_SAMPLE_REGS_ABI_64;
