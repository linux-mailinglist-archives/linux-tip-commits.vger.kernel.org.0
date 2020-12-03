Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C12CD3C7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Dec 2020 11:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbgLCKga (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 05:36:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgLCKg1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:27 -0500
Date:   Thu, 03 Dec 2020 10:35:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvTXcw8zmG8BmeUT5Jo+Y87ukrERvGhrbfkyLPGyxYc=;
        b=fp6NDQmaGFwbUmmxql3mhZqKTRq+vu2ktWUvVYmSEYK2YyzThWTqb5GgJlBUkDF9Y5wyTh
        xJ9TYqIamYBGfHso/ynYGEtiuQMpJv0eebQoIYQoLv5FzU/MZFZUzbZ1WuxNtRL+kyHqBi
        lmcZkJ1Pzo//4W86hUtNfIvL6QK0xaXzb8Im99CpSQEfDOeH0geslIbZYgq8PIME+LyTOT
        D4/8gT7t3z5aYfqWeFCUVA0HY4x6JxlzLeOcvXrvye1aQA/MlhMctpCZf1L9kWf8FmVgrx
        Uk0SEe4q4dFRsjBCJXSSTLPgj82ywcvU7VciM1Q3/ux6jty42aDTetaBBB12tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606991744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gvTXcw8zmG8BmeUT5Jo+Y87ukrERvGhrbfkyLPGyxYc=;
        b=/SJbfHH6/GV3+/DJeEJrMQgTmjeCQGo8m44EXFOmI9J57inRPFpLdCbILqGAOnPwfs8dVT
        5aoc30jN7Vp1RnDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Rename __seqprop() users
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201110115358.GE2594@hirez.programming.kicks-ass.net>
References: <20201110115358.GE2594@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160699174442.3364.5902068863671967661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ab440b2c604b60fe90885270fcfeb5c3dd5d6fae
Gitweb:        https://git.kernel.org/tip/ab440b2c604b60fe90885270fcfeb5c3dd5d6fae
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 Nov 2020 13:44:17 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Dec 2020 11:20:51 +01:00

seqlock: Rename __seqprop() users

More consistent naming should make it easier to untangle the _Generic
token pasting maze called __seqprop().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201110115358.GE2594@hirez.programming.kicks-ass.net
---
 include/linux/seqlock.h | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 8d85524..d89134c 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -307,10 +307,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__seqprop_case((s),	mutex,		prop),			\
 	__seqprop_case((s),	ww_mutex,	prop))
 
-#define __seqcount_ptr(s)		__seqprop(s, ptr)
-#define __seqcount_sequence(s)		__seqprop(s, sequence)
-#define __seqcount_lock_preemptible(s)	__seqprop(s, preemptible)
-#define __seqcount_assert_lock_held(s)	__seqprop(s, assert)
+#define seqprop_ptr(s)			__seqprop(s, ptr)
+#define seqprop_sequence(s)		__seqprop(s, sequence)
+#define seqprop_preemptible(s)		__seqprop(s, preemptible)
+#define seqprop_assert(s)		__seqprop(s, assert)
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
@@ -330,7 +330,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 ({									\
 	unsigned __seq;							\
 									\
-	while ((__seq = __seqcount_sequence(s)) & 1)			\
+	while ((__seq = seqprop_sequence(s)) & 1)			\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
@@ -359,7 +359,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define read_seqcount_begin(s)						\
 ({									\
-	seqcount_lockdep_reader_access(__seqcount_ptr(s));		\
+	seqcount_lockdep_reader_access(seqprop_ptr(s));			\
 	raw_read_seqcount_begin(s);					\
 })
 
@@ -376,7 +376,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned __seq = __seqcount_sequence(s);			\
+	unsigned __seq = seqprop_sequence(s);				\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
@@ -425,7 +425,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(__seqcount_ptr(s), start)
+	__read_seqcount_t_retry(seqprop_ptr(s), start)
 
 static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
@@ -445,7 +445,7 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(__seqcount_ptr(s), start)
+	read_seqcount_t_retry(seqprop_ptr(s), start)
 
 static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
 {
@@ -459,10 +459,10 @@ static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(__seqcount_ptr(s));			\
+	raw_write_seqcount_t_begin(seqprop_ptr(s));			\
 } while (0)
 
 static inline void raw_write_seqcount_t_begin(seqcount_t *s)
@@ -478,9 +478,9 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(__seqcount_ptr(s));			\
+	raw_write_seqcount_t_end(seqprop_ptr(s));			\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
@@ -501,12 +501,12 @@ static inline void raw_write_seqcount_t_end(seqcount_t *s)
  */
 #define write_seqcount_begin_nested(s, subclass)			\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(__seqcount_ptr(s), subclass);	\
+	write_seqcount_t_begin_nested(seqprop_ptr(s), subclass);	\
 } while (0)
 
 static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
@@ -528,12 +528,12 @@ static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
  */
 #define write_seqcount_begin(s)						\
 do {									\
-	__seqcount_assert_lock_held(s);					\
+	seqprop_assert(s);						\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(__seqcount_ptr(s));			\
+	write_seqcount_t_begin(seqprop_ptr(s));				\
 } while (0)
 
 static inline void write_seqcount_t_begin(seqcount_t *s)
@@ -549,9 +549,9 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(__seqcount_ptr(s));			\
+	write_seqcount_t_end(seqprop_ptr(s));				\
 									\
-	if (__seqcount_lock_preemptible(s))				\
+	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
@@ -603,7 +603,7 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(__seqcount_ptr(s))
+	raw_write_seqcount_t_barrier(seqprop_ptr(s))
 
 static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
 {
@@ -623,7 +623,7 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(__seqcount_ptr(s))
+	write_seqcount_t_invalidate(seqprop_ptr(s))
 
 static inline void write_seqcount_t_invalidate(seqcount_t *s)
 {
