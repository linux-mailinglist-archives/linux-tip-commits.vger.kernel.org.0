Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E807041F066
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354840AbhJAPH2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58008 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354815AbhJAPHV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:21 -0400
Date:   Fri, 01 Oct 2021 15:05:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6wMnNegYjk+pH/1SsOEUamVwoHjFUVnaqoZy+oFWmw=;
        b=sO1i9W8sQMu7GRBOpXrLD1gyGw2wKV25YlrJkYqwo99SvqHeZfrW7ZnnWs8YBYaEzLPtPU
        /fc2FsPRcsttDycw6dB/LCZWnx7E7ZHfRxKLgVt3YuoYTZvegDb2LUmvi/WovCKp7xojXX
        gM5t92eivrZk2H2kOrEXD/9FvLISg5/1hoXmV2V7Gdt4q8fENJyqUT0rBaVVDtYhUFB6mv
        ScbdD+Ilk0/tQnkEzVLwfnw2+nflLXZbKRD3jX299DWYRrbfGDGKv/8PaPyT5CNEC3pE06
        i00x71hRwi3rRa57Fc9NtDBzgYfrG/hzKJHYIcSfRa12Ah7M9bg+0oO5wDoeeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6wMnNegYjk+pH/1SsOEUamVwoHjFUVnaqoZy+oFWmw=;
        b=8RsSOLD15OtIlYsRakSMbsAgP9LPEj28e7Q7M+XPtfIkcH3tmrF/uRUn9thUyDYJqEiJVh
        4qO0BFaPeYzFcYCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Remove preempt_offset argument from
 __might_sleep()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923165358.054321586@linutronix.de>
References: <20210923165358.054321586@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310073178.25758.17978045334715755117.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     42a387566c567603bafa1ec0c5b71c35cba83e86
Gitweb:        https://git.kernel.org/tip/42a387566c567603bafa1ec0c5b71c35cba83e86
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Sep 2021 18:54:38 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:50 +02:00

sched: Remove preempt_offset argument from __might_sleep()

All callers hand in 0 and never will hand in anything else.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210923165358.054321586@linutronix.de
---
 include/linux/kernel.h | 7 +++----
 kernel/sched/core.c    | 4 ++--
 mm/memory.c            | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5e4ae54..f95ee78 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -112,7 +112,7 @@ static __always_inline void might_resched(void)
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void __might_resched(const char *file, int line, int preempt_offset);
-extern void __might_sleep(const char *file, int line, int preempt_offset);
+extern void __might_sleep(const char *file, int line);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
 
@@ -129,7 +129,7 @@ extern void __cant_migrate(const char *file, int line);
  * supposed to.
  */
 # define might_sleep() \
-	do { __might_sleep(__FILE__, __LINE__, 0); might_resched(); } while (0)
+	do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
 /**
  * cant_sleep - annotation for functions that cannot sleep
  *
@@ -170,8 +170,7 @@ extern void __cant_migrate(const char *file, int line);
 #else
   static inline void __might_resched(const char *file, int line,
 				     int preempt_offset) { }
-  static inline void __might_sleep(const char *file, int line,
-				   int preempt_offset) { }
+static inline void __might_sleep(const char *file, int line) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
 # define cant_migrate()		do { } while (0)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c3943aa..2d790df 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9475,7 +9475,7 @@ static inline int preempt_count_equals(int preempt_offset)
 	return (nested == preempt_offset);
 }
 
-void __might_sleep(const char *file, int line, int preempt_offset)
+void __might_sleep(const char *file, int line)
 {
 	unsigned int state = get_current_state();
 	/*
@@ -9489,7 +9489,7 @@ void __might_sleep(const char *file, int line, int preempt_offset)
 			(void *)current->task_state_change,
 			(void *)current->task_state_change);
 
-	__might_resched(file, line, preempt_offset);
+	__might_resched(file, line, 0);
 }
 EXPORT_SYMBOL(__might_sleep);
 
diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e..1cd1792 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5255,7 +5255,7 @@ void __might_fault(const char *file, int line)
 		return;
 	if (pagefault_disabled())
 		return;
-	__might_sleep(file, line, 0);
+	__might_sleep(file, line);
 #if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
 		might_lock_read(&current->mm->mmap_lock);
