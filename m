Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D68F3B0391
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 14:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhFVMFz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 08:05:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56754 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhFVMFy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 08:05:54 -0400
Date:   Tue, 22 Jun 2021 12:03:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624363418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fgm8a0x8TCGg2DDg63XJ9btnZRlxOFIICSQMr28Rj2k=;
        b=zWcnxhZp1kJugBEzADo87CUfTPHTxl6j/sVJS/zXMM7SnfgsBxdS+pEwNG1g+cEGO34bOz
        EISz6syRXmQpQdUtC/WpGT3byOh8qL53GgrpIGuT6ZsBL7q/Z2sp+kSlstkbxg778Fr7I4
        Dr6vCLyiaALlVdMTt1qiDlCSKIoHmrN6A5a9h9Zl9NA4wGzQ5xcysGABGEiFGbqVI88OT6
        4qF8R8bcXy5+NAFU810NJBCDDfexEovk/f1g8uDOPMSb4dDIVHuvcPY+9UzM+LzU7GX7LN
        Hdj/5p8NJZtJZRPlaDgSnoHvLiKdR43kQtNpNhdXZwDRC4LD/cv3ut3q2UfsGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624363418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fgm8a0x8TCGg2DDg63XJ9btnZRlxOFIICSQMr28Rj2k=;
        b=asvci3BM876MBGAtAtMc3xpDPJUS2NTT+13evrGrrZ0FNwGttiNN3cZUTsy/77hy3+x278
        2Bb0yFDLQvSVyMAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] locking/lockdep: Improve noinstr vs errors
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210621120120.784404944@infradead.org>
References: <20210621120120.784404944@infradead.org>
MIME-Version: 1.0
Message-ID: <162436341730.395.6717706594403277990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     49faa77759b211fff344898edc23bb780707fff5
Gitweb:        https://git.kernel.org/tip/49faa77759b211fff344898edc23bb780707fff5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Jun 2021 13:12:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Jun 2021 13:56:43 +02:00

locking/lockdep: Improve noinstr vs errors

Better handle the failure paths.

  vmlinux.o: warning: objtool: debug_locks_off()+0x23: call to console_verbose() leaves .noinstr.text section
  vmlinux.o: warning: objtool: debug_locks_off()+0x19: call to __kasan_check_write() leaves .noinstr.text section

  debug_locks_off+0x19/0x40:
  instrument_atomic_write at include/linux/instrumented.h:86
  (inlined by) __debug_locks_off at include/linux/debug_locks.h:17
  (inlined by) debug_locks_off at lib/debug_locks.c:41

Fixes: 6eebad1ad303 ("lockdep: __always_inline more for noinstr")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210621120120.784404944@infradead.org
---
 include/linux/debug_locks.h | 2 ++
 kernel/locking/lockdep.c    | 4 +++-
 lib/debug_locks.c           | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 2915f56..edb5c18 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -27,8 +27,10 @@ extern int debug_locks_off(void);
 	int __ret = 0;							\
 									\
 	if (!oops_in_progress && unlikely(c)) {				\
+		instrumentation_begin();				\
 		if (debug_locks_off() && !debug_locks_silent)		\
 			WARN(1, "DEBUG_LOCKS_WARN_ON(%s)", #c);		\
+		instrumentation_end();					\
 		__ret = 1;						\
 	}								\
 	__ret;								\
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7641bd4..e323130 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -843,7 +843,7 @@ static int count_matching_names(struct lock_class *new_class)
 }
 
 /* used from NMI context -- must be lockless */
-static __always_inline struct lock_class *
+static noinstr struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
 	struct lockdep_subclass_key *key;
@@ -851,12 +851,14 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	struct lock_class *class;
 
 	if (unlikely(subclass >= MAX_LOCKDEP_SUBCLASSES)) {
+		instrumentation_begin();
 		debug_locks_off();
 		printk(KERN_ERR
 			"BUG: looking up invalid subclass: %u\n", subclass);
 		printk(KERN_ERR
 			"turning off the locking correctness validator.\n");
 		dump_stack();
+		instrumentation_end();
 		return NULL;
 	}
 
diff --git a/lib/debug_locks.c b/lib/debug_locks.c
index 06d3135..a75ee30 100644
--- a/lib/debug_locks.c
+++ b/lib/debug_locks.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
 /*
  * Generic 'turn off all lock debugging' function:
  */
-noinstr int debug_locks_off(void)
+int debug_locks_off(void)
 {
 	if (debug_locks && __debug_locks_off()) {
 		if (!debug_locks_silent) {
