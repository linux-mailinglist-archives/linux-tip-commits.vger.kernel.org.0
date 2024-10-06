Return-Path: <linux-tip-commits+bounces-2350-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC191992088
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Oct 2024 21:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC862815AD
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Oct 2024 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3618A6D9;
	Sun,  6 Oct 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tr2ZDtkW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="adhZdE3N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B78189B99;
	Sun,  6 Oct 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728241482; cv=none; b=lER9TGhEfHhgSu/SBsuByc5Ct1nG3cAnKUsqrqktYX/c6ka57Ny9ei3HmHGex6XbSuDEp8HrcdFA8wDZiYGhJ59BFJhzDb96taM9UrIeAX1k+S1xi8mUqHcvcRH920e+1LY4h/lSmyk7GA5GY7DjYJ8p3E9JwP6D6Kzkjfqu7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728241482; c=relaxed/simple;
	bh=y2evRvgTcLm4jdBKhMEuyS/dFGD5Tkty43wfen90liw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FuiMghZ7tp/CnNdgxkUHZlEGE+d85bgfSN2VNgeezHSNMJ54IpQ+wafDxtuFD4DAfL+eUZUVQA9FXDSH/gEsUqCDn4Gwcnkp0v8pCyFV/NxPcpPqTr5zvt3ldsApr128wXLsU8wXWif1bTsWk8H/JpEu/rzZWAR4wWUmsX+hZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tr2ZDtkW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=adhZdE3N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Oct 2024 19:04:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728241473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtvzSsWwpA0ujRD19XNtOzPMwZwqRcxWEU8kXOFREcg=;
	b=tr2ZDtkW6knGowUve8K4CtWQ5Zen6YjlIXhn+3RNgfVx56m7ZoHHBz7qdUVTEZn4qkgql1
	bbmtrT8D/e/UAnP/o7GpnUMxO8cbc54LfKZGJ25Ixuyy6EfBkNVJm7rqDieN4tCuvie3S1
	uJ9eBPHe845NqcX/1x7XILZHb4+9Bfbtk/Va2ZsTbbY1UTXuQOSNMgu+0LlE6H0/mMwptv
	LjlPscpILBgV6AjXxwIVSMkSkASSdvU8/5sKy82Wg2tYEIRYoszWRcp6f6iziaMnC6C5Co
	Fn7I2sdDw9i2oJGgmeV5p2F/YOfsx+eA913gT5DAcy0QIoh3HUHmcsHgPJT0wA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728241473;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtvzSsWwpA0ujRD19XNtOzPMwZwqRcxWEU8kXOFREcg=;
	b=adhZdE3NY3vhq394A3+XJpK02MCJSnlka+UvP5UDvHpc9uYmvFRKisA7AgHgt7XJgBoStY
	NASrXe9qdx+OLeAw==
From: "tip-bot2 for Jeff Layton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Add interfaces for handling
 timestamps with a floor value
Cc: Jeff Layton <jlayton@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Randy Dunlap <rdunlap@infradead.org>, John Stultz <jstultz@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241002-mgtime-v10-1-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-1-d1c4717f5284@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172824147241.1442.11329305614933060441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     70c8fd00a9bd0509bbf7bccd9baea8bbd5ddc756
Gitweb:        https://git.kernel.org/tip/70c8fd00a9bd0509bbf7bccd9baea8bbd5ddc756
Author:        Jeff Layton <jlayton@kernel.org>
AuthorDate:    Wed, 02 Oct 2024 17:27:16 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 06 Oct 2024 20:56:07 +02:00

timekeeping: Add interfaces for handling timestamps with a floor value

Multigrain timestamps allow the kernel to use fine-grained timestamps when
an inode's attributes is being actively observed via ->getattr().  With
this support, it's possible for a file to get a fine-grained timestamp, and
another modified after it to get a coarse-grained stamp that is earlier
than the fine-grained time.  If this happens then the files can appear to
have been modified in reverse order, which breaks VFS ordering guarantees
[1].

To prevent this, maintain a floor value for multigrain timestamps.
Whenever a fine-grained timestamp is handed out, record it, and when later
coarse-grained stamps are handed out, ensure they are not earlier than that
value. If the coarse-grained timestamp is earlier than the fine-grained
floor, return the floor value instead.

Add a static singleton atomic64_t into timekeeper.c that is used to keep
track of the latest fine-grained time ever handed out. This is tracked as a
monotonic ktime_t value to ensure that it isn't affected by clock
jumps. Because it is updated at different times than the rest of the
timekeeper object, the floor value is managed independently of the
timekeeper via a cmpxchg() operation, and sits on its own cacheline.

Add two new public interfaces:

- ktime_get_coarse_real_ts64_mg() fills a timespec64 with the later of the
  coarse-grained clock and the floor time

- ktime_get_real_ts64_mg() gets the fine-grained clock value, and tries
  to swap it into the floor. A timespec64 is filled with the result.

The floor value is global and updated via a single try_cmpxchg(). If
that fails then the operation raced with a concurrent update. Any
concurrent update must be later than the existing floor value, so any
racing tasks can accept any resulting floor value without retrying.

[1]: POSIX requires that files be stamped with realtime clock values, and
     makes no provision for dealing with backward clock jumps. If a backward
     realtime clock jump occurs, then files can appear to have been modified
     in reverse order.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Acked-by: John Stultz <jstultz@google.com>
Link: https://lore.kernel.org/all/20241002-mgtime-v10-1-d1c4717f5284@kernel.org
---
 include/linux/timekeeping.h |   4 +-
 kernel/time/timekeeping.c   | 104 +++++++++++++++++++++++++++++++++++-
 2 files changed, 108 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fc12a9b..7aa8524 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -45,6 +45,10 @@ extern void ktime_get_real_ts64(struct timespec64 *tv);
 extern void ktime_get_coarse_ts64(struct timespec64 *ts);
 extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
 
+/* Multigrain timestamp interfaces */
+extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
+extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
+
 void getboottime64(struct timespec64 *ts);
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7e6f409..441792c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -114,6 +114,23 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.base[1] = FAST_TK_INIT,
 };
 
+/*
+ * Multigrain timestamps require tracking the latest fine-grained timestamp
+ * that has been issued, and never returning a coarse-grained timestamp that is
+ * earlier than that value.
+ *
+ * mg_floor represents the latest fine-grained time that has been handed out as
+ * a file timestamp on the system. This is tracked as a monotonic ktime_t, and
+ * converted to a realtime clock value on an as-needed basis.
+ *
+ * Maintaining mg_floor ensures the multigrain interfaces never issue a
+ * timestamp earlier than one that has been previously issued.
+ *
+ * The exception to this rule is when there is a backward realtime clock jump. If
+ * such an event occurs, a timestamp can appear to be earlier than a previous one.
+ */
+static __cacheline_aligned_in_smp atomic64_t mg_floor;
+
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
@@ -2394,6 +2411,93 @@ void ktime_get_coarse_real_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
 
+/**
+ * ktime_get_coarse_real_ts64_mg - return latter of coarse grained time or floor
+ * @ts:		timespec64 to be filled
+ *
+ * Fetch the global mg_floor value, convert it to realtime and compare it
+ * to the current coarse-grained time. Fill @ts with whichever is
+ * latest. Note that this is a filesystem-specific interface and should be
+ * avoided outside of that context.
+ */
+void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	u64 floor = atomic64_read(&mg_floor);
+	ktime_t f_real, offset, coarse;
+	unsigned int seq;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		*ts = tk_xtime(tk);
+		offset = tk_core.timekeeper.offs_real;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	coarse = timespec64_to_ktime(*ts);
+	f_real = ktime_add(floor, offset);
+	if (ktime_after(f_real, coarse))
+		*ts = ktime_to_timespec64(f_real);
+}
+
+/**
+ * ktime_get_real_ts64_mg - attempt to update floor value and return result
+ * @ts:		pointer to the timespec to be set
+ *
+ * Get a monotonic fine-grained time value and attempt to swap it into
+ * mg_floor. If that succeeds then accept the new floor value. If it fails
+ * then another task raced in during the interim time and updated the
+ * floor.  Since any update to the floor must be later than the previous
+ * floor, either outcome is acceptable.
+ *
+ * Typically this will be called after calling ktime_get_coarse_real_ts64_mg(),
+ * and determining that the resulting coarse-grained timestamp did not effect
+ * a change in ctime. Any more recent floor value would effect a change to
+ * ctime, so there is no need to retry the atomic64_try_cmpxchg() on failure.
+ *
+ * @ts will be filled with the latest floor value, regardless of the outcome of
+ * the cmpxchg. Note that this is a filesystem specific interface and should be
+ * avoided outside of that context.
+ */
+void ktime_get_real_ts64_mg(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	ktime_t old = atomic64_read(&mg_floor);
+	ktime_t offset, mono;
+	unsigned int seq;
+	u64 nsecs;
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+
+		ts->tv_sec = tk->xtime_sec;
+		mono = tk->tkr_mono.base;
+		nsecs = timekeeping_get_ns(&tk->tkr_mono);
+		offset = tk_core.timekeeper.offs_real;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	mono = ktime_add_ns(mono, nsecs);
+
+	/*
+	 * Attempt to update the floor with the new time value. As any
+	 * update must be later then the existing floor, and would effect
+	 * a change to ctime from the perspective of the current task,
+	 * accept the resulting floor value regardless of the outcome of
+	 * the swap.
+	 */
+	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
+		ts->tv_nsec = 0;
+		timespec64_add_ns(ts, nsecs);
+	} else {
+		/*
+		 * Another task changed mg_floor since "old" was fetched.
+		 * "old" has been updated with the latest value of "mg_floor".
+		 * That value is newer than the previous floor value, which
+		 * is enough to effect a change to ctime. Accept it.
+		 */
+		*ts = ktime_to_timespec64(ktime_add(old, offset));
+	}
+}
+
 void ktime_get_coarse_ts64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;

