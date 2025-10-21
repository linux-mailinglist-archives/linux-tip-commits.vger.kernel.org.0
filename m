Return-Path: <linux-tip-commits+bounces-6971-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C21EBF5CB1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5DF3AD94A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621132BF4C;
	Tue, 21 Oct 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1eNiwKY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mYSSXcN5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED8B2F12B0;
	Tue, 21 Oct 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042928; cv=none; b=O1jxaott/KwkAQUReVHetXab5Q/YCKJ9J3gD6GJKZ3Xo4rrzFBDZp/wzKzAAa2wZzyORjVsAvz13emnoLynXsEE/IkaBxpVMcWIGjl5PLrN2dGU2qmrewzjSQVQsAmCbHyLiU1v5RL/DMyW+sM792QlgaU3Y8U+V6RgXAWPIdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042928; c=relaxed/simple;
	bh=pL8gcT5l9fXVIS8rNwAAW72k0dZ4zGlQkOuRq2xdz2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eSdjzuZjSJ9fU1qBY/y+xDXmlbZ/qIbsPLmqw35Tt4vN1p8QujWbEkaK9yN+YQxeNYNxmK19UvacXCFlareBDAQ6clPyHZPivY/8bIrrMzBlFZvFYouL1YnFgiMFhOkNOKzNGfEpkQbVlfOdCvSkuHE96fTX9tNWTCcCdBtnbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1eNiwKY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mYSSXcN5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DoP/99MODyzMKPHeaTtdVmgYBj2jwPCPPtSBSo1xhUs=;
	b=n1eNiwKY2ZOO/bq85Z1bhYa9gXyrZQf4vOz263Y7LyhQut2q3dlhuqzz3ha7gA0dSZuJrP
	y6B526ADDg/uhljzh0QaY5JV0Ow0dpBHiRRzjEHlxuzI5wstQlxQqofovGTts2nDuHvLWf
	Nf0KBbgrCp9RsR3h2jlmQ78R7nhTuAZ3fWkpXhS04zjM4dLT99VxemIl+k+ThHecsyKphe
	R41SJxUwd99FaIPBlSQ1K2nMyVadDcFmSUfuMA/rZlK1Ho1jdGKpsaZ0aMnIMaNTMB4Z1w
	Nzc9BX4/qdSf+xXVqTzikzMD1WdYJzvk/dcfHZ4ye0WdJFwgEsZq0e8JWSr3Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042925;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DoP/99MODyzMKPHeaTtdVmgYBj2jwPCPPtSBSo1xhUs=;
	b=mYSSXcN5HExLlhVNFpLfoVUzrvvxfsBuz0q9dU7r44of3YgKXjQtozv0vf3t3EuKtp5Di8
	1jFfH9JXBIDj45Bg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: Introduce scoped_seqlock_read()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
References: <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104292373.2601451.8226215165137128444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cc39f3872c0865bef992b713338df369554fa9e0
Gitweb:        https://git.kernel.org/tip/cc39f3872c0865bef992b713338df369554=
fa9e0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 09 Oct 2025 22:11:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:57 +02:00

seqlock: Introduce scoped_seqlock_read()

The read_seqbegin/need_seqretry/done_seqretry API is cumbersome and
error prone. With the new helper the "typical" code like

	int seq, nextseq;
	unsigned long flags;

	nextseq =3D 0;
	do {
		seq =3D nextseq;
		flags =3D read_seqbegin_or_lock_irqsave(&seqlock, &seq);

		// read-side critical section

		nextseq =3D 1;
	} while (need_seqretry(&seqlock, seq));
	done_seqretry_irqrestore(&seqlock, seq, flags);

can be rewritten as

	scoped_seqlock_read (&seqlock, ss_lock_irqsave) {
		// read-side critical section
	}

Original idea by Oleg Nesterov; with contributions from Linus.

Originally-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/seqlock.h | 111 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48ea..b7bcc41 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1209,4 +1209,115 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, un=
signed long flags)
 	if (seq & 1)
 		read_sequnlock_excl_irqrestore(lock, flags);
 }
+
+enum ss_state {
+	ss_done =3D 0,
+	ss_lock,
+	ss_lock_irqsave,
+	ss_lockless,
+};
+
+struct ss_tmp {
+	enum ss_state	state;
+	unsigned long	data;
+	spinlock_t	*lock;
+	spinlock_t	*lock_irqsave;
+};
+
+static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
+{
+	if (sst->lock)
+		spin_unlock(sst->lock);
+	if (sst->lock_irqsave)
+		spin_unlock_irqrestore(sst->lock_irqsave, sst->data);
+}
+
+extern void __scoped_seqlock_invalid_target(void);
+
+#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 90000
+/*
+ * For some reason some GCC-8 architectures (nios2, alpha) have trouble
+ * determining that the ss_done state is impossible in __scoped_seqlock_next=
()
+ * below.
+ */
+static inline void __scoped_seqlock_bug(void) { }
+#else
+/*
+ * Canary for compiler optimization -- if the compiler doesn't realize this =
is
+ * an impossible state, it very likely generates sub-optimal code here.
+ */
+extern void __scoped_seqlock_bug(void);
+#endif
+
+static inline void
+__scoped_seqlock_next(struct ss_tmp *sst, seqlock_t *lock, enum ss_state tar=
get)
+{
+	switch (sst->state) {
+	case ss_done:
+		__scoped_seqlock_bug();
+		return;
+
+	case ss_lock:
+	case ss_lock_irqsave:
+		sst->state =3D ss_done;
+		return;
+
+	case ss_lockless:
+		if (!read_seqretry(lock, sst->data)) {
+			sst->state =3D ss_done;
+			return;
+		}
+		break;
+	}
+
+	switch (target) {
+	case ss_done:
+		__scoped_seqlock_invalid_target();
+		return;
+
+	case ss_lock:
+		sst->lock =3D &lock->lock;
+		spin_lock(sst->lock);
+		sst->state =3D ss_lock;
+		return;
+
+	case ss_lock_irqsave:
+		sst->lock_irqsave =3D &lock->lock;
+		spin_lock_irqsave(sst->lock_irqsave, sst->data);
+		sst->state =3D ss_lock_irqsave;
+		return;
+
+	case ss_lockless:
+		sst->data =3D read_seqbegin(lock);
+		return;
+	}
+}
+
+#define __scoped_seqlock_read(_seqlock, _target, _s)			\
+	for (struct ss_tmp _s __cleanup(__scoped_seqlock_cleanup) =3D	\
+	     { .state =3D ss_lockless, .data =3D read_seqbegin(_seqlock) };	\
+	     _s.state !=3D ss_done;					\
+	     __scoped_seqlock_next(&_s, _seqlock, _target))
+
+/**
+ * scoped_seqlock_read (lock, ss_state) - execute the read side critical
+ *                                        section without manual sequence
+ *                                        counter handling or calls to other
+ *                                        helpers
+ * @lock: pointer to seqlock_t protecting the data
+ * @ss_state: one of {ss_lock, ss_lock_irqsave, ss_lockless} indicating
+ *            the type of critical read section
+ *
+ * Example:
+ *
+ *     scoped_seqlock_read (&lock, ss_lock) {
+ *         // read-side critical section
+ *     }
+ *
+ * Starts with a lockess pass first. If it fails, restarts the critical
+ * section with the lock held.
+ */
+#define scoped_seqlock_read(_seqlock, _target)				\
+	__scoped_seqlock_read(_seqlock, _target, __UNIQUE_ID(seqlock))
+
 #endif /* __LINUX_SEQLOCK_H */

