Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2A52D493E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbgLISmM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:42:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgLISja (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:30 -0500
Date:   Wed, 09 Dec 2020 18:38:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h58TKYvNHpzV3AhfDSJuV1aUN0jkFKSx4mzxkZx/Wa4=;
        b=NOMRyrkvfSEuq97xZl0ytwPiTp1oC/15nw55oqH/bi6Pzcxeq1co6vkxb+M0MGOVluh95J
        5oGOfaDSZmmq2blWpDvI3svuCHr6HUCWYf2nFDx34+belBS8l2J6ggmJQnnmwdmq097WgL
        h2lw/yKAtXn82R/jQi+T41zlrCXPVdYhyBDKURTv0riweLQOIV/fypq2jdzlyGSjCaPpPR
        ZA/S1GVadFbxe40lbbf577B195y3e/bp5jqTaKd6af4N6mMStBuP5gdAMkoaWaCDGK1j5I
        SSeDegTvNXrVj1ORla9M3OruhOmwhHTgBd91fDs2djxbk/grmDO7q4J9XCuRxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h58TKYvNHpzV3AhfDSJuV1aUN0jkFKSx4mzxkZx/Wa4=;
        b=pIgOrgth4yWrPsPFu3uR22I8kbQK85aikx1/uiTtXpoEN9aMXzpLgGUPs/BXkpjS9HPhcp
        3hySZdhJIscLImBA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: kernel-doc: Specify when preemption is
 automatically altered
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com>
References: <CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <160753912635.3364.4993279338737835663.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cb262935a166bdef0ccfe6e2adffa00c0f2d038a
Gitweb:        https://git.kernel.org/tip/cb262935a166bdef0ccfe6e2adffa00c0f2d038a
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 17:21:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:49 +01:00

seqlock: kernel-doc: Specify when preemption is automatically altered

The kernel-doc annotations for sequence counters write side functions
are incomplete: they do not specify when preemption is automatically
disabled and re-enabled.

This has confused a number of call-site developers. Fix it.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com
---
 include/linux/seqlock.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 235cbc6..2f7bb92 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -456,6 +456,8 @@ static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Context: check write_seqcount_begin()
  */
 #define raw_write_seqcount_begin(s)					\
 do {									\
@@ -475,6 +477,8 @@ static inline void do_raw_write_seqcount_begin(seqcount_t *s)
 /**
  * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ *
+ * Context: check write_seqcount_end()
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
@@ -498,6 +502,7 @@ static inline void do_raw_write_seqcount_end(seqcount_t *s)
  * @subclass: lockdep nesting level
  *
  * See Documentation/locking/lockdep-design.rst
+ * Context: check write_seqcount_begin()
  */
 #define write_seqcount_begin_nested(s, subclass)			\
 do {									\
@@ -519,11 +524,10 @@ static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
  * write_seqcount_begin() - start a seqcount_t write side critical section
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
- * write_seqcount_begin opens a write side critical section of the given
- * seqcount_t.
- *
- * Context: seqcount_t write side critical sections must be serialized and
- * non-preemptible. If readers can be invoked from hardirq or softirq
+ * Context: sequence counter write side sections must be serialized and
+ * non-preemptible. Preemption will be automatically disabled if and
+ * only if the seqcount write serialization lock is associated, and
+ * preemptible.  If readers can be invoked from hardirq or softirq
  * context, interrupts or bottom halves must be respectively disabled.
  */
 #define write_seqcount_begin(s)						\
@@ -545,7 +549,8 @@ static inline void do_write_seqcount_begin(seqcount_t *s)
  * write_seqcount_end() - end a seqcount_t write side critical section
  * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
  *
- * The write section must've been opened with write_seqcount_begin().
+ * Context: Preemption will be automatically re-enabled if and only if
+ * the seqcount write serialization lock is associated, and preemptible.
  */
 #define write_seqcount_end(s)						\
 do {									\
