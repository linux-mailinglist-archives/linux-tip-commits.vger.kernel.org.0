Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F58A3AC9BF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jun 2021 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhFRL0N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Jun 2021 07:26:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhFRL0N (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Jun 2021 07:26:13 -0400
Date:   Fri, 18 Jun 2021 11:24:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624015442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPLZ2KZ9EEqcuTn9Ap2WMPYRrkD/DqnR0b5dZDvam6k=;
        b=FJ4Mt3tFzwuvIaZqmqGf/bpaeptMCEeXcq+6/xelDT7zQO5o0LxwYlyhr46An1VfWFGRR1
        8rvOEaXurzqAv6fxAhcbL9vPjP/WA83ydfeADw+67EAeDeom5tThw3OcMkRsacuIl2V9zL
        ImI78BJfly8s2qKTCApJg5NoCjFky9zIPj5/W5n0U3KMjtHL2GLn5sIKGw/IaC5dO7lhJV
        JZ1bUayPjk4mi+cCiLlP610Nc2qiUfZsFu0+nUT84c+pU2SU37Ba1JE/rR+trEe8q/0kXK
        9mZLXlAV8NvcjSgQA0P4G7yuW3WiH93rIirAS6cemjcgoz3PS5K0cbKToeRADw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624015442;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPLZ2KZ9EEqcuTn9Ap2WMPYRrkD/DqnR0b5dZDvam6k=;
        b=KtmQ4t6YblY1nCFrPibCdEebwxSWh17dCc+sSbJFhJTwj/dtVBQNryrppbJPaUE1WHJ4CU
        j8SNzZP1cW4KwpAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,arch: Remove unused TASK_STATE offsets
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210611082838.472811363@infradead.org>
References: <20210611082838.472811363@infradead.org>
MIME-Version: 1.0
Message-ID: <162401544225.19906.15094500140160379605.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7c3edd6d9cb4d8ea8db5b167dc2eee94d7e4667b
Gitweb:        https://git.kernel.org/tip/7c3edd6d9cb4d8ea8db5b167dc2eee94d7e4667b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 11 Jun 2021 10:28:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 18 Jun 2021 11:43:09 +02:00

sched,arch: Remove unused TASK_STATE offsets

All 6 architectures define TASK_STATE in asm-offsets, but then never
actually use it. Remove the definitions to make sure they never will.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210611082838.472811363@infradead.org
---
 arch/csky/kernel/asm-offsets.c       | 1 -
 arch/h8300/kernel/asm-offsets.c      | 1 -
 arch/microblaze/kernel/asm-offsets.c | 1 -
 arch/mips/kernel/asm-offsets.c       | 1 -
 arch/openrisc/kernel/asm-offsets.c   | 1 -
 arch/parisc/kernel/asm-offsets.c     | 1 -
 6 files changed, 6 deletions(-)

diff --git a/arch/csky/kernel/asm-offsets.c b/arch/csky/kernel/asm-offsets.c
index 1747986..1cbcba4 100644
--- a/arch/csky/kernel/asm-offsets.c
+++ b/arch/csky/kernel/asm-offsets.c
@@ -9,7 +9,6 @@
 int main(void)
 {
 	/* offsets into the task struct */
-	DEFINE(TASK_STATE,        offsetof(struct task_struct, state));
 	DEFINE(TASK_THREAD_INFO,  offsetof(struct task_struct, stack));
 	DEFINE(TASK_FLAGS,        offsetof(struct task_struct, flags));
 	DEFINE(TASK_PTRACE,       offsetof(struct task_struct, ptrace));
diff --git a/arch/h8300/kernel/asm-offsets.c b/arch/h8300/kernel/asm-offsets.c
index d4b53af..65571ee 100644
--- a/arch/h8300/kernel/asm-offsets.c
+++ b/arch/h8300/kernel/asm-offsets.c
@@ -21,7 +21,6 @@
 int main(void)
 {
 	/* offsets into the task struct */
-	OFFSET(TASK_STATE, task_struct, state);
 	OFFSET(TASK_FLAGS, task_struct, flags);
 	OFFSET(TASK_PTRACE, task_struct, ptrace);
 	OFFSET(TASK_BLOCKED, task_struct, blocked);
diff --git a/arch/microblaze/kernel/asm-offsets.c b/arch/microblaze/kernel/asm-offsets.c
index 6c69ce7..b77dd18 100644
--- a/arch/microblaze/kernel/asm-offsets.c
+++ b/arch/microblaze/kernel/asm-offsets.c
@@ -70,7 +70,6 @@ int main(int argc, char *argv[])
 
 	/* struct task_struct */
 	DEFINE(TS_THREAD_INFO, offsetof(struct task_struct, stack));
-	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
 	DEFINE(TASK_BLOCKED, offsetof(struct task_struct, blocked));
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 5735b2c..04ca752 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -78,7 +78,6 @@ void output_ptreg_defines(void)
 void output_task_defines(void)
 {
 	COMMENT("MIPS task_struct offsets.");
-	OFFSET(TASK_STATE, task_struct, state);
 	OFFSET(TASK_THREAD_INFO, task_struct, stack);
 	OFFSET(TASK_FLAGS, task_struct, flags);
 	OFFSET(TASK_MM, task_struct, mm);
diff --git a/arch/openrisc/kernel/asm-offsets.c b/arch/openrisc/kernel/asm-offsets.c
index 18c703d..710651d 100644
--- a/arch/openrisc/kernel/asm-offsets.c
+++ b/arch/openrisc/kernel/asm-offsets.c
@@ -37,7 +37,6 @@
 int main(void)
 {
 	/* offsets into the task_struct */
-	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
 	DEFINE(TASK_THREAD, offsetof(struct task_struct, thread));
diff --git a/arch/parisc/kernel/asm-offsets.c b/arch/parisc/kernel/asm-offsets.c
index cd2cc1b..33113ba 100644
--- a/arch/parisc/kernel/asm-offsets.c
+++ b/arch/parisc/kernel/asm-offsets.c
@@ -42,7 +42,6 @@
 int main(void)
 {
 	DEFINE(TASK_THREAD_INFO, offsetof(struct task_struct, stack));
-	DEFINE(TASK_STATE, offsetof(struct task_struct, state));
 	DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
 	DEFINE(TASK_SIGPENDING, offsetof(struct task_struct, pending));
 	DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
