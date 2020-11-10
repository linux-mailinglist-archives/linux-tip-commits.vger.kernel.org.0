Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A442AD69A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgKJMpY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730424AbgKJMpX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA26C0613CF;
        Tue, 10 Nov 2020 04:45:23 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTTa9BU5u6mIGwUGfGr4UpYf65xNZXKnT0JKcO6GeM4=;
        b=J8ebQLeM1AGTtweZS+i36R+K5EXc6P5ZKJsHlF5dnEvgZAuCN+AJ4B48+C5kcxg17NQlSX
        83hXzKhKHZTg4lRDL1VlGtgbQqPYl+Biy63760IelnCbQBozyZD8QXZWO/gS9g4r72x3cN
        ecM7t+87vNwDZd7fMhDKPwPfKcBmARNDwsVXBcC0prrJV1wZdyITdQaoJkt7TIZGxodXMk
        LuOD4I2MJpjILCDgAEk6OsCW8G9dtD8JC0kD5JlbMefo2s7Sp1if6EWXBtIMBgaviGX0wR
        snwEdw2hbfx9yLHjpyy6bBBv3dCuRHv8VY5LZP8gnBocpodT+Qlcu4MS9qyyBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTTa9BU5u6mIGwUGfGr4UpYf65xNZXKnT0JKcO6GeM4=;
        b=iTQ04pt3YYM59xdTtvdSqjPUiQ2Q8VOVonnC1mBJu5fl82EtjgvYjZyNmdsHZW770LaViV
        oGuNhwg3yzQXeHAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/arch: Remove perf_sample_data::regs_user_copy
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201030151955.258178461@infradead.org>
References: <20201030151955.258178461@infradead.org>
MIME-Version: 1.0
Message-ID: <160501232054.11244.2701071518494885717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     76a4efa80900fc40e0fdf243b42aec9fb8c35d24
Gitweb:        https://git.kernel.org/tip/76a4efa80900fc40e0fdf243b42aec9fb8c35d24
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 30 Oct 2020 12:14:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:34 +01:00

perf/arch: Remove perf_sample_data::regs_user_copy

struct perf_sample_data lives on-stack, we should be careful about it's
size. Furthermore, the pt_regs copy in there is only because x86_64 is a
trainwreck, solve it differently.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Steven Rostedt <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20201030151955.258178461@infradead.org
---
 arch/arm/kernel/perf_regs.c   |  3 +--
 arch/arm64/kernel/perf_regs.c |  3 +--
 arch/csky/kernel/perf_regs.c  |  3 +--
 arch/powerpc/perf/perf_regs.c |  3 +--
 arch/riscv/kernel/perf_regs.c |  3 +--
 arch/s390/kernel/perf_regs.c  |  3 +--
 arch/x86/kernel/perf_regs.c   | 15 +++++++++++----
 include/linux/perf_event.h    |  6 ------
 include/linux/perf_regs.h     |  6 ++----
 kernel/events/core.c          |  8 +++-----
 10 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index 05fe92a..0529f90 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -32,8 +32,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 94e8718..f6f58e6 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -73,8 +73,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
index eb32838..09b7f88 100644
--- a/arch/csky/kernel/perf_regs.c
+++ b/arch/csky/kernel/perf_regs.c
@@ -32,8 +32,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 8e53f2f..6f681b1 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -144,8 +144,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
index 04a38fb..fd304a2 100644
--- a/arch/riscv/kernel/perf_regs.c
+++ b/arch/riscv/kernel/perf_regs.c
@@ -36,8 +36,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/s390/kernel/perf_regs.c b/arch/s390/kernel/perf_regs.c
index 4352a50..6e9e5d5 100644
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -53,8 +53,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	/*
 	 * Use the regs from the first interruption and let
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index bb7e113..f9e5352 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -101,8 +101,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
@@ -129,12 +128,20 @@ u64 perf_reg_abi(struct task_struct *task)
 		return PERF_SAMPLE_REGS_ABI_64;
 }
 
+static DEFINE_PER_CPU(struct pt_regs, nmi_user_regs);
+
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
+	struct pt_regs *regs_user_copy = this_cpu_ptr(&nmi_user_regs);
 	struct pt_regs *user_regs = task_pt_regs(current);
 
+	if (!in_nmi()) {
+		regs_user->regs = user_regs;
+		regs_user->abi = perf_reg_abi(current);
+		return;
+	}
+
 	/*
 	 * If we're in an NMI that interrupted task_pt_regs setup, then
 	 * we can't sample user regs at all.  This check isn't really
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index b775ae0..96450f6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1022,13 +1022,7 @@ struct perf_sample_data {
 	struct perf_callchain_entry	*callchain;
 	u64				aux_size;
 
-	/*
-	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
-	 * on arch details.
-	 */
 	struct perf_regs		regs_user;
-	struct pt_regs			regs_user_copy;
-
 	struct perf_regs		regs_intr;
 	u64				stack_user_size;
 
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 2d12e97..f632c57 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -20,8 +20,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx);
 int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy);
+			struct pt_regs *regs);
 #else
 
 #define PERF_REG_EXTENDED_MASK	0
@@ -42,8 +41,7 @@ static inline u64 perf_reg_abi(struct task_struct *task)
 }
 
 static inline void perf_get_regs_user(struct perf_regs *regs_user,
-				      struct pt_regs *regs,
-				      struct pt_regs *regs_user_copy)
+				      struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc681c7..d67c9cb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6374,14 +6374,13 @@ perf_output_sample_regs(struct perf_output_handle *handle,
 }
 
 static void perf_sample_regs_user(struct perf_regs *regs_user,
-				  struct pt_regs *regs,
-				  struct pt_regs *regs_user_copy)
+				  struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
 	} else if (!(current->flags & PF_KTHREAD)) {
-		perf_get_regs_user(regs_user, regs, regs_user_copy);
+		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
 		regs_user->regs = NULL;
@@ -7083,8 +7082,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
-		perf_sample_regs_user(&data->regs_user, regs,
-				      &data->regs_user_copy);
+		perf_sample_regs_user(&data->regs_user, regs);
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
