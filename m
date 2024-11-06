Return-Path: <linux-tip-commits+bounces-2758-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9C9BE49C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB531C23507
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BBE1DE3DE;
	Wed,  6 Nov 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="thyoI3xe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9aH2Rxx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487741DE2B9;
	Wed,  6 Nov 2024 10:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890067; cv=none; b=tge9FqF5C3GL7EG0S1rSxS9P9lyZKfzpneBIs+bQ7PBJacXgxkM2JcAYqFVddVLlHx+NlXVW6MupLqgVEnv3pneOcB932JMEGKCylLLpp55h+PPufnSHFr542Dtezg9KlhgaWitvxPKDSu62EzMuIwVzAEM47znuxWPsU6BBWFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890067; c=relaxed/simple;
	bh=z1xPywGHhRzXe0ViPLeZGn4SZ6mX7uOA3sLQw3iigrI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=raHyppUofRALQ9DdqrNPe1PEhlgX7d7rxOs0aviSjrS4lsg+sQwlKaivkqNCnmRvaYxYok1tuVvTtdqw4BXJWxKFoo7UMklT57yGtP9ePeAc+hTECP7F2y/NW3bnaWX8Htb7T8+1Taw26UZssdgxwm+smBxd2wKIf8jWUv1d8s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=thyoI3xe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9aH2Rxx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:47:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETMmO1s534qzwfCSNAEUHumjaNxecjywZrqs3yjs2bE=;
	b=thyoI3xeOZcJ7QLAeF37DXnbpWfOiOuKjZNDLNe84J+wwWKrLxuxjQMy/yVxMy63eFcAHf
	/32SJz1Jn/Us3hzM1NRxwIrRIqM7jH2yaVGp2S8shFrTeZ2LnbKJeXS2AmuZJqy2vFJ8FO
	RXcD6V3nwx0/6TgMvSQCNL28f0CuW3dTKnUGyxAUzlO+Cbrioc/uprz1nIh2Gk7yge86eM
	ovr8RvKq8+bEinS79YUALh4DJyCCOrNPXG1n2ZIM1vhx5M+25vvZCwILUyh86L7t0wiIOP
	HwEAkA6M1cJybyH4/rEyjw+Ri1mVtyIjsbu3P1v+VgP1+S8pJTE6Z6DWfF9DBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ETMmO1s534qzwfCSNAEUHumjaNxecjywZrqs3yjs2bE=;
	b=L9aH2RxxVQekVSdlFYP5PjK2vpbY9IRlAX1j3uRaGoI0CaetfYUNRFkBNzBJ9Y3FLgUFHj
	KhRuFypEw7v8npAQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan, seqlock: Support seqcount_latch_t
Cc: Alexander Potapenko <glider@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104161910.780003-4-elver@google.com>
References: <20241104161910.780003-4-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089006242.32228.5162533643457006719.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5c1806c41ce0a0110db5dd4c483cf2dc28b3ddf0
Gitweb:        https://git.kernel.org/tip/5c1806c41ce0a0110db5dd4c483cf2dc28b3ddf0
Author:        Marco Elver <elver@google.com>
AuthorDate:    Mon, 04 Nov 2024 16:43:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:35 +01:00

kcsan, seqlock: Support seqcount_latch_t

While fuzzing an arm64 kernel, Alexander Potapenko reported:

| BUG: KCSAN: data-race in ktime_get_mono_fast_ns / timekeeping_update
|
| write to 0xffffffc082e74248 of 56 bytes by interrupt on cpu 0:
|  update_fast_timekeeper kernel/time/timekeeping.c:430 [inline]
|  timekeeping_update+0x1d8/0x2d8 kernel/time/timekeeping.c:768
|  timekeeping_advance+0x9e8/0xb78 kernel/time/timekeeping.c:2344
|  update_wall_time+0x18/0x38 kernel/time/timekeeping.c:2360
|  [...]
|
| read to 0xffffffc082e74258 of 8 bytes by task 5260 on cpu 1:
|  __ktime_get_fast_ns kernel/time/timekeeping.c:372 [inline]
|  ktime_get_mono_fast_ns+0x88/0x174 kernel/time/timekeeping.c:489
|  init_srcu_struct_fields+0x40c/0x530 kernel/rcu/srcutree.c:263
|  init_srcu_struct+0x14/0x20 kernel/rcu/srcutree.c:311
|  [...]
|
| value changed: 0x000002f875d33266 -> 0x000002f877416866
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 1 UID: 0 PID: 5260 Comm: syz.2.7483 Not tainted 6.12.0-rc3-dirty #78

This is a false positive data race between a seqcount latch writer and a reader
accessing stale data. Since its introduction, KCSAN has never understood the
seqcount_latch interface (due to being unannotated).

Unlike the regular seqlock interface, the seqcount_latch interface for latch
writers never has had a well-defined critical section, making it difficult to
teach tooling where the critical section starts and ends.

Introduce an instrumentable (non-raw) seqcount_latch interface, with
which we can clearly denote writer critical sections. This both helps
readability and tooling like KCSAN to understand when the writer is done
updating all latch copies.

Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
Reported-by: Alexander Potapenko <glider@google.com>
Co-developed-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241104161910.780003-4-elver@google.com
---
 Documentation/locking/seqlock.rst |  2 +-
 include/linux/seqlock.h           | 86 ++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index bfda1a5..ec6411d 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -153,7 +153,7 @@ Use seqcount_latch_t when the write side sections cannot be protected
 from interruption by readers. This is typically the case when the read
 side can be invoked from NMI handlers.
 
-Check `raw_write_seqcount_latch()` for more information.
+Check `write_seqcount_latch()` for more information.
 
 
 .. _seqlock_t:
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index fffeb75..45eee0e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -622,6 +622,23 @@ static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *
 }
 
 /**
+ * read_seqcount_latch() - pick even/odd latch data copy
+ * @s: Pointer to seqcount_latch_t
+ *
+ * See write_seqcount_latch() for details and a full reader/writer usage
+ * example.
+ *
+ * Return: sequence counter raw value. Use the lowest bit as an index for
+ * picking which data copy to read. The full counter must then be checked
+ * with read_seqcount_latch_retry().
+ */
+static __always_inline unsigned read_seqcount_latch(const seqcount_latch_t *s)
+{
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
+	return raw_read_seqcount_latch(s);
+}
+
+/**
  * raw_read_seqcount_latch_retry() - end a seqcount_latch_t read section
  * @s:		Pointer to seqcount_latch_t
  * @start:	count, from raw_read_seqcount_latch()
@@ -636,8 +653,33 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
 }
 
 /**
+ * read_seqcount_latch_retry() - end a seqcount_latch_t read section
+ * @s:		Pointer to seqcount_latch_t
+ * @start:	count, from read_seqcount_latch()
+ *
+ * Return: true if a read section retry is required, else false
+ */
+static __always_inline int
+read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
+{
+	kcsan_atomic_next(0);
+	return raw_read_seqcount_latch_retry(s, start);
+}
+
+/**
  * raw_write_seqcount_latch() - redirect latch readers to even/odd copy
  * @s: Pointer to seqcount_latch_t
+ */
+static __always_inline void raw_write_seqcount_latch(seqcount_latch_t *s)
+{
+	smp_wmb();	/* prior stores before incrementing "sequence" */
+	s->seqcount.sequence++;
+	smp_wmb();      /* increment "sequence" before following stores */
+}
+
+/**
+ * write_seqcount_latch_begin() - redirect latch readers to odd copy
+ * @s: Pointer to seqcount_latch_t
  *
  * The latch technique is a multiversion concurrency control method that allows
  * queries during non-atomic modifications. If you can guarantee queries never
@@ -665,17 +707,11 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
  *
  *	void latch_modify(struct latch_struct *latch, ...)
  *	{
- *		smp_wmb();	// Ensure that the last data[1] update is visible
- *		latch->seq.sequence++;
- *		smp_wmb();	// Ensure that the seqcount update is visible
- *
+ *		write_seqcount_latch_begin(&latch->seq);
  *		modify(latch->data[0], ...);
- *
- *		smp_wmb();	// Ensure that the data[0] update is visible
- *		latch->seq.sequence++;
- *		smp_wmb();	// Ensure that the seqcount update is visible
- *
+ *		write_seqcount_latch(&latch->seq);
  *		modify(latch->data[1], ...);
+ *		write_seqcount_latch_end(&latch->seq);
  *	}
  *
  * The query will have a form like::
@@ -686,13 +722,13 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
  *		unsigned seq, idx;
  *
  *		do {
- *			seq = raw_read_seqcount_latch(&latch->seq);
+ *			seq = read_seqcount_latch(&latch->seq);
  *
  *			idx = seq & 0x01;
  *			entry = data_query(latch->data[idx], ...);
  *
  *		// This includes needed smp_rmb()
- *		} while (raw_read_seqcount_latch_retry(&latch->seq, seq));
+ *		} while (read_seqcount_latch_retry(&latch->seq, seq));
  *
  *		return entry;
  *	}
@@ -716,11 +752,31 @@ raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
  *	When data is a dynamic data structure; one should use regular RCU
  *	patterns to manage the lifetimes of the objects within.
  */
-static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
+static __always_inline void write_seqcount_latch_begin(seqcount_latch_t *s)
 {
-	smp_wmb();	/* prior stores before incrementing "sequence" */
-	s->seqcount.sequence++;
-	smp_wmb();      /* increment "sequence" before following stores */
+	kcsan_nestable_atomic_begin();
+	raw_write_seqcount_latch(s);
+}
+
+/**
+ * write_seqcount_latch() - redirect latch readers to even copy
+ * @s: Pointer to seqcount_latch_t
+ */
+static __always_inline void write_seqcount_latch(seqcount_latch_t *s)
+{
+	raw_write_seqcount_latch(s);
+}
+
+/**
+ * write_seqcount_latch_end() - end a seqcount_latch_t write section
+ * @s:		Pointer to seqcount_latch_t
+ *
+ * Marks the end of a seqcount_latch_t writer section, after all copies of the
+ * latch-protected data have been updated.
+ */
+static __always_inline void write_seqcount_latch_end(seqcount_latch_t *s)
+{
+	kcsan_nestable_atomic_end();
 }
 
 #define __SEQLOCK_UNLOCKED(lockname)					\

