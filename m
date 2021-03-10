Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5153340F5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Mar 2021 16:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhCJO7n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Mar 2021 09:59:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCJO7e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Mar 2021 09:59:34 -0500
Date:   Wed, 10 Mar 2021 14:59:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615388372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+tQqB0hFDPD6FxUFbCYBS8xG00ReNrcRHM5TG8E5xDQ=;
        b=T9w5xSVyiKMAPa7x9N17WUB3U3EIL6vZ4LKcTTMJuNQIXQiqUxo3hrAMLQpUyqZX2oKLnl
        myIcd2Zt1MHq3k//kTuvO0vwbAhyOKF0kKfZkMJ3oLrIwPaacKjl+W8DDXfOK+iwJxt9vz
        He/sM2QKO4hnutws0wu/QM+s9aU2hLnA4gkTDO48vDIbSQsGTHRZ9TJc+seQ8cnegRgShN
        ul8MIELjy5f366/CtgZqLOr22ELRGHw54LGpmpVkSJSIW0iGS7oUbpExk1v7n4H/5IynGe
        Hrq1ODFtsLrrNqRZhmWwKu5P6bbN10ZcLdox1WTCX2VcGYfq4URPDj6ACvpqHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615388372;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+tQqB0hFDPD6FxUFbCYBS8xG00ReNrcRHM5TG8E5xDQ=;
        b=EN5gbw/ZpEsBmcs07uXuuPvcUr+ESas8EQAd6XVBc8b2OaKtbM2I4iVkPfQm0VekK7hHRj
        PcQbU1xxaSpYqfCA==
From:   "tip-bot2 for Mark Brown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] stacktrace: Move documentation for
 arch_stack_walk_reliable() to header
Cc:     Mark Brown <broonie@kernel.org>, Borislav Petkov <bp@suse.de>,
        Miroslav Benes <mbenes@suse.cz>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210309194125.652-1-broonie@kernel.org>
References: <20210309194125.652-1-broonie@kernel.org>
MIME-Version: 1.0
Message-ID: <161538837182.398.6429429039329083480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     b18adee4ce4443399963826b5d28d9e63d40740c
Gitweb:        https://git.kernel.org/tip/b18adee4ce4443399963826b5d28d9e63d40740c
Author:        Mark Brown <broonie@kernel.org>
AuthorDate:    Tue, 09 Mar 2021 19:41:25 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Mar 2021 15:52:31 +01:00

stacktrace: Move documentation for arch_stack_walk_reliable() to header

Currently arch_stack_walk_reliable() is documented with an identical
comment in both x86 and S/390 implementations which is a bit redundant.
Move this to the header and convert to kerneldoc while we're at it.

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lkml.kernel.org/r/20210309194125.652-1-broonie@kernel.org
---
 arch/s390/kernel/stacktrace.c |  6 ------
 arch/x86/kernel/stacktrace.c  |  6 ------
 include/linux/stacktrace.h    | 19 +++++++++++++++++++
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 7f1266c..101477b 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -24,12 +24,6 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
-/*
- * This function returns an error if it detects any unreliable features of the
- * stack.  Otherwise it guarantees that the stack trace is reliable.
- *
- * If the task is not 'current', the caller *must* ensure the task is inactive.
- */
 int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			     void *cookie, struct task_struct *task)
 {
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 8627fda..15b058e 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -29,12 +29,6 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
-/*
- * This function returns an error if it detects any unreliable features of the
- * stack.  Otherwise it guarantees that the stack trace is reliable.
- *
- * If the task is not 'current', the caller *must* ensure the task is inactive.
- */
 int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			     void *cookie, struct task_struct *task)
 {
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 50e2df3..9edecb4 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -52,8 +52,27 @@ typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr);
  */
 void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs);
+
+/**
+ * arch_stack_walk_reliable - Architecture specific function to walk the
+ *			      stack reliably
+ *
+ * @consume_entry:	Callback which is invoked by the architecture code for
+ *			each entry.
+ * @cookie:		Caller supplied pointer which is handed back to
+ *			@consume_entry
+ * @task:		Pointer to a task struct, can be NULL
+ *
+ * This function returns an error if it detects any unreliable
+ * features of the stack. Otherwise it guarantees that the stack
+ * trace is reliable.
+ *
+ * If the task is not 'current', the caller *must* ensure the task is
+ * inactive and its stack is pinned.
+ */
 int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
 			     struct task_struct *task);
+
 void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			  const struct pt_regs *regs);
 
