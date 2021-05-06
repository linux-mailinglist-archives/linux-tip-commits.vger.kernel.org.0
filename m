Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464AA37550D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhEFNtQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 09:49:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40440 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbhEFNtQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 09:49:16 -0400
Date:   Thu, 06 May 2021 13:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620308897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+H8MYZgxThC6BOGKn3tgQs+IICBpGBPAa6SRxKU/Cq8=;
        b=TSf9fwj+E53EQCnkfshiX5BEAoIgUTu+I2WzHhRmQd6u7ddg0PEWI/hRXEDhS8Tts5+Yh6
        YIIyktYHfiRrqRSgqCO3mY4Jak1Ahajzuc8Nd4ig+lYIMgeyDyTjz1AViuV59oKE1f3jQv
        C0tuL/Ej5mve9I1+42b97sQfHXrquFGGRImNKVZH7r3+vA20Ti98uLc0eARp4oBcXARHNQ
        RYcj6MtZpeEAGa4KSYFhF/48KDCBVw6qj65hPsIyLa9pNGmKFqNEDdDWie/EFN3Vvolk6H
        1BNm+5BwHS1lPbeGY/GrCTmP7ppJ0GCFmYE6lJYsbpyMRrFwpXJLbKZNcbNwWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620308897;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+H8MYZgxThC6BOGKn3tgQs+IICBpGBPAa6SRxKU/Cq8=;
        b=A89n36N2fT1TC3R66qsQmZgRcUE5Q3JvwOWeWmIjd83vxu37v3eL9aKqS1b85BaXLiopSe
        NSI27HTxLzdGRQAQ==
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] smp: Fix smp_call_function_single_async prototype
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505211300.3174456-1-arnd@kernel.org>
References: <20210505211300.3174456-1-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <162030889655.29796.14817964445442674284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     1139aeb1c521eb4a050920ce6c64c36c4f2a3ab7
Gitweb:        https://git.kernel.org/tip/1139aeb1c521eb4a050920ce6c64c36c4f2a3ab7
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 05 May 2021 23:12:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 May 2021 15:33:49 +02:00

smp: Fix smp_call_function_single_async prototype

As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
call_single_data"), the smp code prefers 32-byte aligned call_single_data
objects for performance reasons, but the block layer includes an instance
of this structure in the main 'struct request' that is more senstive
to size than to performance here, see 4ccafe032005 ("block: unalign
call_single_data in struct request").

The result is a violation of the calling conventions that clang correctly
points out:

block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to 32-byte aligned parameter 2 of 'smp_call_function_single_async' may result in an unaligned pointer access [-Walign-mismatch]
                smp_call_function_single_async(cpu, &rq->csd);

It does seem that the usage of the call_single_data without cache line
alignment should still be allowed by the smp code, so just change the
function prototype so it accepts both, but leave the default alignment
unchanged for the other users. This seems better to me than adding
a local hack to shut up an otherwise correct warning in the caller.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Jens Axboe <axboe@kernel.dk>
Link: https://lkml.kernel.org/r/20210505211300.3174456-1-arnd@kernel.org
---
 include/linux/smp.h |  2 +-
 kernel/smp.c        | 26 +++++++++++++-------------
 kernel/up.c         |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 84a0b48..f0d3ef6 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
 
 /*
  * Call a function on all processors
diff --git a/kernel/smp.c b/kernel/smp.c
index e210749..52bf159 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -211,7 +211,7 @@ static u64 cfd_seq_inc(unsigned int src, unsigned int dst, unsigned int type)
 	} while (0)
 
 /* Record current CSD work for current CPU, NULL to erase. */
-static void __csd_lock_record(call_single_data_t *csd)
+static void __csd_lock_record(struct __call_single_data *csd)
 {
 	if (!csd) {
 		smp_mb(); /* NULL cur_csd after unlock. */
@@ -226,13 +226,13 @@ static void __csd_lock_record(call_single_data_t *csd)
 		  /* Or before unlock, as the case may be. */
 }
 
-static __always_inline void csd_lock_record(call_single_data_t *csd)
+static __always_inline void csd_lock_record(struct __call_single_data *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled))
 		__csd_lock_record(csd);
 }
 
-static int csd_lock_wait_getcpu(call_single_data_t *csd)
+static int csd_lock_wait_getcpu(struct __call_single_data *csd)
 {
 	unsigned int csd_type;
 
@@ -282,7 +282,7 @@ static const char *csd_lock_get_type(unsigned int type)
 	return (type >= ARRAY_SIZE(seq_type)) ? "?" : seq_type[type];
 }
 
-static void csd_lock_print_extended(call_single_data_t *csd, int cpu)
+static void csd_lock_print_extended(struct __call_single_data *csd, int cpu)
 {
 	struct cfd_seq_local *seq = &per_cpu(cfd_seq_local, cpu);
 	unsigned int srccpu = csd->node.src;
@@ -321,7 +321,7 @@ static void csd_lock_print_extended(call_single_data_t *csd, int cpu)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *ts1, int *bug_id)
 {
 	int cpu = -1;
 	int cpux;
@@ -387,7 +387,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static void __csd_lock_wait(call_single_data_t *csd)
+static void __csd_lock_wait(struct __call_single_data *csd)
 {
 	int bug_id = 0;
 	u64 ts0, ts1;
@@ -401,7 +401,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
 	smp_acquire__after_ctrl_dep();
 }
 
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled)) {
 		__csd_lock_wait(csd);
@@ -431,17 +431,17 @@ static void __smp_call_single_queue_debug(int cpu, struct llist_node *node)
 #else
 #define cfd_seq_store(var, src, dst, type)
 
-static void csd_lock_record(call_single_data_t *csd)
+static void csd_lock_record(struct __call_single_data *csd)
 {
 }
 
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 {
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #endif
 
-static __always_inline void csd_lock(call_single_data_t *csd)
+static __always_inline void csd_lock(struct __call_single_data *csd)
 {
 	csd_lock_wait(csd);
 	csd->node.u_flags |= CSD_FLAG_LOCK;
@@ -454,7 +454,7 @@ static __always_inline void csd_lock(call_single_data_t *csd)
 	smp_wmb();
 }
 
-static __always_inline void csd_unlock(call_single_data_t *csd)
+static __always_inline void csd_unlock(struct __call_single_data *csd)
 {
 	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
 
@@ -501,7 +501,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, call_single_data_t *csd)
+static int generic_exec_single(int cpu, struct __call_single_data *csd)
 {
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
@@ -784,7 +784,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  * NOTE: Be careful, there is unfortunately no current debugging facility to
  * validate the correctness of this serialization.
  */
-int smp_call_function_single_async(int cpu, call_single_data_t *csd)
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
 	int err = 0;
 
diff --git a/kernel/up.c b/kernel/up.c
index bf20b4a..c732130 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-int smp_call_function_single_async(int cpu, call_single_data_t *csd)
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
 	unsigned long flags;
 
