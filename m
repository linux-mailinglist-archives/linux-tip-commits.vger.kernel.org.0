Return-Path: <linux-tip-commits+bounces-2757-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4D9BE49A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B56285A56
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA71DE3B3;
	Wed,  6 Nov 2024 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bj6F6EDg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHWy+p6Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E671DB377;
	Wed,  6 Nov 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890066; cv=none; b=rsq5abPGCTh9HkemWtM1W6XXER4cxXXJMKTlj3DRMuuIgxpjh5APp1wb7y6fuRtCIayO5nBprCcJ0zWDKvAZEVCZnG20fiS+A1li6Q/RQxmfdm5KlvxnLZR7YRraH5i2WNYpwCVkNRhrxFjVUO5hppLuFOa5Qha1Ip4ptEuQkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890066; c=relaxed/simple;
	bh=7hi2+xAkKVRRfC3scW7ndditPXfxUeeUDN6YGur9JKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sOdqJQTgxrqKwPd9tKaNYCajTxFFl+EKFKvY8aby5I4Xmavw/b/W8aeoWLkYtVv9ly0bPMFP0l+p2kZYU4Ex5qXDcWtyTJJhwglzfklxhnJu9KYi1gQHJABzJfYtwsjpOgQpzXY90+RFqbX/h++P5Y2V5kyXSRipJYsEsRb+jSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bj6F6EDg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHWy+p6Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:47:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IPTb3ztrjL5v7GpeF6dTs8Y/a12gzeThOdLAswIEV4=;
	b=Bj6F6EDgma6Q/N2Je7NxPk7hGVMsRtilC71tCLRW7FliJ277qnTNGsVSopbgGR9atv1T9e
	cic9gMKOKhggKAwLEk4VmoF++jF4TO/QGy/WuhMhausGwtYEge4wNTDprLuvgzIASIeDaG
	ZHCihTIY6/mC//KBWkKVBBmSbqVlqZRWKeKqtbmihUMglZsx0FRp1ZAl0vEM3YOz1fDlBV
	1i1K/RtKGG3S7TUkPLfFHY4hsx4kKdiiOdmeNWMRtuzA6uh+vn4JlqbZIrWHc8sM8Y6Yz0
	x9NbWYIER2hFBOxEnyxAHNquacSDSmDOBZXbnFGa4BpEq77b6u61HlG1AEj5iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IPTb3ztrjL5v7GpeF6dTs8Y/a12gzeThOdLAswIEV4=;
	b=NHWy+p6Z4zFOPcjhmiianmD0hu+9q6/39RMTlTypsA31fb1QReipKfAqxIkQSR8yX1ZPxt
	Z3u+xcShHRY+5ICg==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock, treewide: Switch to non-raw
 seqcount_latch interface
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104161910.780003-5-elver@google.com>
References: <20241104161910.780003-5-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089006153.32228.6432329729002917398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     93190bc35d6d4364a4d8c38ac8961dabecbff4ed
Gitweb:        https://git.kernel.org/tip/93190bc35d6d4364a4d8c38ac8961dabecbff4ed
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 04 Nov 2024 16:43:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:35 +01:00

seqlock, treewide: Switch to non-raw seqcount_latch interface

Switch all instrumentable users of the seqcount_latch interface over to
the non-raw interface.

Co-developed-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241104161910.780003-5-elver@google.com
---
 arch/x86/kernel/tsc.c        |  5 +++--
 include/linux/rbtree_latch.h | 20 +++++++++++---------
 kernel/printk/printk.c       |  9 +++++----
 kernel/time/sched_clock.c    | 12 +++++++-----
 kernel/time/timekeeping.c    | 12 +++++++-----
 5 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index dfe6847..67aeaba 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -174,10 +174,11 @@ static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long ts
 
 	c2n = per_cpu_ptr(&cyc2ns, cpu);
 
-	raw_write_seqcount_latch(&c2n->seq);
+	write_seqcount_latch_begin(&c2n->seq);
 	c2n->data[0] = data;
-	raw_write_seqcount_latch(&c2n->seq);
+	write_seqcount_latch(&c2n->seq);
 	c2n->data[1] = data;
+	write_seqcount_latch_end(&c2n->seq);
 }
 
 static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
diff --git a/include/linux/rbtree_latch.h b/include/linux/rbtree_latch.h
index 6a0999c..2f630eb 100644
--- a/include/linux/rbtree_latch.h
+++ b/include/linux/rbtree_latch.h
@@ -14,7 +14,7 @@
  *
  * If we need to allow unconditional lookups (say as required for NMI context
  * usage) we need a more complex setup; this data structure provides this by
- * employing the latch technique -- see @raw_write_seqcount_latch -- to
+ * employing the latch technique -- see @write_seqcount_latch_begin -- to
  * implement a latched RB-tree which does allow for unconditional lookups by
  * virtue of always having (at least) one stable copy of the tree.
  *
@@ -132,7 +132,7 @@ __lt_find(void *key, struct latch_tree_root *ltr, int idx,
  * @ops: operators defining the node order
  *
  * It inserts @node into @root in an ordered fashion such that we can always
- * observe one complete tree. See the comment for raw_write_seqcount_latch().
+ * observe one complete tree. See the comment for write_seqcount_latch_begin().
  *
  * The inserts use rcu_assign_pointer() to publish the element such that the
  * tree structure is stored before we can observe the new @node.
@@ -145,10 +145,11 @@ latch_tree_insert(struct latch_tree_node *node,
 		  struct latch_tree_root *root,
 		  const struct latch_tree_ops *ops)
 {
-	raw_write_seqcount_latch(&root->seq);
+	write_seqcount_latch_begin(&root->seq);
 	__lt_insert(node, root, 0, ops->less);
-	raw_write_seqcount_latch(&root->seq);
+	write_seqcount_latch(&root->seq);
 	__lt_insert(node, root, 1, ops->less);
+	write_seqcount_latch_end(&root->seq);
 }
 
 /**
@@ -159,7 +160,7 @@ latch_tree_insert(struct latch_tree_node *node,
  *
  * Removes @node from the trees @root in an ordered fashion such that we can
  * always observe one complete tree. See the comment for
- * raw_write_seqcount_latch().
+ * write_seqcount_latch_begin().
  *
  * It is assumed that @node will observe one RCU quiescent state before being
  * reused of freed.
@@ -172,10 +173,11 @@ latch_tree_erase(struct latch_tree_node *node,
 		 struct latch_tree_root *root,
 		 const struct latch_tree_ops *ops)
 {
-	raw_write_seqcount_latch(&root->seq);
+	write_seqcount_latch_begin(&root->seq);
 	__lt_erase(node, root, 0);
-	raw_write_seqcount_latch(&root->seq);
+	write_seqcount_latch(&root->seq);
 	__lt_erase(node, root, 1);
+	write_seqcount_latch_end(&root->seq);
 }
 
 /**
@@ -204,9 +206,9 @@ latch_tree_find(void *key, struct latch_tree_root *root,
 	unsigned int seq;
 
 	do {
-		seq = raw_read_seqcount_latch(&root->seq);
+		seq = read_seqcount_latch(&root->seq);
 		node = __lt_find(key, root, seq & 1, ops->comp);
-	} while (raw_read_seqcount_latch_retry(&root->seq, seq));
+	} while (read_seqcount_latch_retry(&root->seq, seq));
 
 	return node;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index beb808f..19911c8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -560,10 +560,11 @@ bool printk_percpu_data_ready(void)
 /* Must be called under syslog_lock. */
 static void latched_seq_write(struct latched_seq *ls, u64 val)
 {
-	raw_write_seqcount_latch(&ls->latch);
+	write_seqcount_latch_begin(&ls->latch);
 	ls->val[0] = val;
-	raw_write_seqcount_latch(&ls->latch);
+	write_seqcount_latch(&ls->latch);
 	ls->val[1] = val;
+	write_seqcount_latch_end(&ls->latch);
 }
 
 /* Can be called from any context. */
@@ -574,10 +575,10 @@ static u64 latched_seq_read_nolock(struct latched_seq *ls)
 	u64 val;
 
 	do {
-		seq = raw_read_seqcount_latch(&ls->latch);
+		seq = read_seqcount_latch(&ls->latch);
 		idx = seq & 0x1;
 		val = ls->val[idx];
-	} while (raw_read_seqcount_latch_retry(&ls->latch, seq));
+	} while (read_seqcount_latch_retry(&ls->latch, seq));
 
 	return val;
 }
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 29bdf30..fcca4e7 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -71,13 +71,13 @@ static __always_inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 
 notrace struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 {
-	*seq = raw_read_seqcount_latch(&cd.seq);
+	*seq = read_seqcount_latch(&cd.seq);
 	return cd.read_data + (*seq & 1);
 }
 
 notrace int sched_clock_read_retry(unsigned int seq)
 {
-	return raw_read_seqcount_latch_retry(&cd.seq, seq);
+	return read_seqcount_latch_retry(&cd.seq, seq);
 }
 
 static __always_inline unsigned long long __sched_clock(void)
@@ -132,16 +132,18 @@ unsigned long long notrace sched_clock(void)
 static void update_clock_read_data(struct clock_read_data *rd)
 {
 	/* steer readers towards the odd copy */
-	raw_write_seqcount_latch(&cd.seq);
+	write_seqcount_latch_begin(&cd.seq);
 
 	/* now its safe for us to update the normal (even) copy */
 	cd.read_data[0] = *rd;
 
 	/* switch readers back to the even copy */
-	raw_write_seqcount_latch(&cd.seq);
+	write_seqcount_latch(&cd.seq);
 
 	/* update the backup (odd) copy with the new data */
 	cd.read_data[1] = *rd;
+
+	write_seqcount_latch_end(&cd.seq);
 }
 
 /*
@@ -279,7 +281,7 @@ void __init generic_sched_clock_init(void)
  */
 static u64 notrace suspended_sched_clock_read(void)
 {
-	unsigned int seq = raw_read_seqcount_latch(&cd.seq);
+	unsigned int seq = read_seqcount_latch(&cd.seq);
 
 	return cd.read_data[seq & 1].epoch_cyc;
 }
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e6f409..1875298 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -411,7 +411,7 @@ static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
  * We want to use this from any context including NMI and tracing /
  * instrumenting the timekeeping code itself.
  *
- * Employ the latch technique; see @raw_write_seqcount_latch.
+ * Employ the latch technique; see @write_seqcount_latch.
  *
  * So if a NMI hits the update of base[0] then it will use base[1]
  * which is still consistent. In the worst case this can result is a
@@ -424,16 +424,18 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 	struct tk_read_base *base = tkf->base;
 
 	/* Force readers off to base[1] */
-	raw_write_seqcount_latch(&tkf->seq);
+	write_seqcount_latch_begin(&tkf->seq);
 
 	/* Update base[0] */
 	memcpy(base, tkr, sizeof(*base));
 
 	/* Force readers back to base[0] */
-	raw_write_seqcount_latch(&tkf->seq);
+	write_seqcount_latch(&tkf->seq);
 
 	/* Update base[1] */
 	memcpy(base + 1, base, sizeof(*base));
+
+	write_seqcount_latch_end(&tkf->seq);
 }
 
 static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
@@ -443,11 +445,11 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 	u64 now;
 
 	do {
-		seq = raw_read_seqcount_latch(&tkf->seq);
+		seq = read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
 		now = ktime_to_ns(tkr->base);
 		now += __timekeeping_get_ns(tkr);
-	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
+	} while (read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
 }

