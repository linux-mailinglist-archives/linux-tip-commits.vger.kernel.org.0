Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEFF2D494A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbgLISmM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:42:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48312 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgLISjb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:31 -0500
Date:   Wed, 09 Dec 2020 18:38:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6amLPYhulIcC8MH0lDtd1dgFefYZ+jQhQU9WZUwKSXk=;
        b=SORboJduNpuawz+4fYoXj8I7dBRtjodQJt7xH93v7FlS8FU49XpBHbZud4nPaXEm46l7jw
        worTqrEdITqs0IVMjgUHfIjpyjtAKeUxVfyvdAIJDGgBXimqFXm23o+NUaC02oz/wctK4N
        SQhUmYf84kiY5/jiHfo3GYkkOnatSqW+El3eOZ1WYqhnyHqskjodF8P5/NwDDwqlcPcpP+
        /ExdJd5X3RG01KpYYW+N/ul32tWOskgfckOwruyyNOXKIiOX7audVuF5P3ckoZZEpWn9N0
        htiSW0qdq92STEsWGlBy5pn1bG1bFRIE06CVpe4JX8RaruVXqqEY69fcOlcp2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6amLPYhulIcC8MH0lDtd1dgFefYZ+jQhQU9WZUwKSXk=;
        b=x54Hjd7Lq+bAfMIhCDqSorGJEDK/421DHA16VLSxWOsJBSA75FX5Ld6XHZwfr33fcFMXNE
        incbKdiC22HYr4Dg==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Prefix internal seqcount_t-only macros
 with a "do_"
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com>
References: <CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <160753912666.3364.821233138673064897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     66bcfcdf89d00f2409f4b5da0f8c20c08318dc72
Gitweb:        https://git.kernel.org/tip/66bcfcdf89d00f2409f4b5da0f8c20c08318dc72
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 17:21:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:49 +01:00

seqlock: Prefix internal seqcount_t-only macros with a "do_"

When the seqcount_LOCKNAME_t group of data types were introduced, two
classes of seqlock.h sequence counter macros were added:

  - An external public API which can either take a plain seqcount_t or
    any of the seqcount_LOCKNAME_t variants.

  - An internal API which takes only a plain seqcount_t.

To distinguish between the two groups, the "*_seqcount_t_*" pattern was
used for the latter. This confused a number of mm/ call-site developers,
and Linus also commented that it was not a standard practice for marking
seqlock.h internal APIs.

Distinguish the latter group of macros by prefixing a "do_".

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com
---
 include/linux/seqlock.h | 66 ++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index d89134c..235cbc6 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -425,9 +425,9 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	__read_seqcount_t_retry(seqprop_ptr(s), start)
+	do___read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	kcsan_atomic_next(0);
 	return unlikely(READ_ONCE(s->sequence) != start);
@@ -445,12 +445,12 @@ static inline int __read_seqcount_t_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	read_seqcount_t_retry(seqprop_ptr(s), start)
+	do_read_seqcount_retry(seqprop_ptr(s), start)
 
-static inline int read_seqcount_t_retry(const seqcount_t *s, unsigned start)
+static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
 	smp_rmb();
-	return __read_seqcount_t_retry(s, start);
+	return do___read_seqcount_retry(s, start);
 }
 
 /**
@@ -462,10 +462,10 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	raw_write_seqcount_t_begin(seqprop_ptr(s));			\
+	do_raw_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void raw_write_seqcount_t_begin(seqcount_t *s)
+static inline void do_raw_write_seqcount_begin(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -478,13 +478,13 @@ static inline void raw_write_seqcount_t_begin(seqcount_t *s)
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	raw_write_seqcount_t_end(seqprop_ptr(s));			\
+	do_raw_write_seqcount_end(seqprop_ptr(s));			\
 									\
 	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void raw_write_seqcount_t_end(seqcount_t *s)
+static inline void do_raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
@@ -506,12 +506,12 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin_nested(seqprop_ptr(s), subclass);	\
+	do_write_seqcount_begin_nested(seqprop_ptr(s), subclass);	\
 } while (0)
 
-static inline void write_seqcount_t_begin_nested(seqcount_t *s, int subclass)
+static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	raw_write_seqcount_t_begin(s);
+	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
@@ -533,12 +533,12 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	write_seqcount_t_begin(seqprop_ptr(s));				\
+	do_write_seqcount_begin(seqprop_ptr(s));			\
 } while (0)
 
-static inline void write_seqcount_t_begin(seqcount_t *s)
+static inline void do_write_seqcount_begin(seqcount_t *s)
 {
-	write_seqcount_t_begin_nested(s, 0);
+	do_write_seqcount_begin_nested(s, 0);
 }
 
 /**
@@ -549,16 +549,16 @@ static inline void write_seqcount_t_begin(seqcount_t *s)
  */
 #define write_seqcount_end(s)						\
 do {									\
-	write_seqcount_t_end(seqprop_ptr(s));				\
+	do_write_seqcount_end(seqprop_ptr(s));				\
 									\
 	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void write_seqcount_t_end(seqcount_t *s)
+static inline void do_write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
-	raw_write_seqcount_t_end(s);
+	do_raw_write_seqcount_end(s);
 }
 
 /**
@@ -603,9 +603,9 @@ static inline void write_seqcount_t_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	raw_write_seqcount_t_barrier(seqprop_ptr(s))
+	do_raw_write_seqcount_barrier(seqprop_ptr(s))
 
-static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
+static inline void do_raw_write_seqcount_barrier(seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
 	s->sequence++;
@@ -623,9 +623,9 @@ static inline void raw_write_seqcount_t_barrier(seqcount_t *s)
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	write_seqcount_t_invalidate(seqprop_ptr(s))
+	do_write_seqcount_invalidate(seqprop_ptr(s))
 
-static inline void write_seqcount_t_invalidate(seqcount_t *s)
+static inline void do_write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
 	kcsan_nestable_atomic_begin();
@@ -865,9 +865,9 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use write_seqcount_*t*_begin()
- * instead of the generic write_seqcount_begin(). This way, no redundant
- * lockdep_assert_held() checks are added.
+ * For all seqlock_t write side functions, use the the internal
+ * do_write_seqcount_begin() instead of generic write_seqcount_begin().
+ * This way, no redundant lockdep_assert_held() checks are added.
  */
 
 /**
@@ -886,7 +886,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -898,7 +898,7 @@ static inline void write_seqlock(seqlock_t *sl)
  */
 static inline void write_sequnlock(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock(&sl->lock);
 }
 
@@ -912,7 +912,7 @@ static inline void write_sequnlock(seqlock_t *sl)
 static inline void write_seqlock_bh(seqlock_t *sl)
 {
 	spin_lock_bh(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -925,7 +925,7 @@ static inline void write_seqlock_bh(seqlock_t *sl)
  */
 static inline void write_sequnlock_bh(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_bh(&sl->lock);
 }
 
@@ -939,7 +939,7 @@ static inline void write_sequnlock_bh(seqlock_t *sl)
 static inline void write_seqlock_irq(seqlock_t *sl)
 {
 	spin_lock_irq(&sl->lock);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 }
 
 /**
@@ -951,7 +951,7 @@ static inline void write_seqlock_irq(seqlock_t *sl)
  */
 static inline void write_sequnlock_irq(seqlock_t *sl)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irq(&sl->lock);
 }
 
@@ -960,7 +960,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 	unsigned long flags;
 
 	spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_t_begin(&sl->seqcount.seqcount);
+	do_write_seqcount_begin(&sl->seqcount.seqcount);
 	return flags;
 }
 
@@ -989,7 +989,7 @@ static inline unsigned long __write_seqlock_irqsave(seqlock_t *sl)
 static inline void
 write_sequnlock_irqrestore(seqlock_t *sl, unsigned long flags)
 {
-	write_seqcount_t_end(&sl->seqcount.seqcount);
+	do_write_seqcount_end(&sl->seqcount.seqcount);
 	spin_unlock_irqrestore(&sl->lock, flags);
 }
 
