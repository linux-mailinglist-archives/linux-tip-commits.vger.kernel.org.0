Return-Path: <linux-tip-commits+bounces-7793-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB8BCF48E1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C49E830B78C8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE933F37F;
	Mon,  5 Jan 2026 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwcLsqoS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SmUpGUWj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE833BBD8;
	Mon,  5 Jan 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628463; cv=none; b=oaseYf3nkhCvBuIlys19dCkRgunIehM6Big8n/yzihW88r3EzwP76zQAzf2f5UVrPneaN800/grmjbHnpKegReC0M90pASf15Ir2ANffcfLSg3CtwIOtQE1oP1+Dhu8Lh4b+0PHng35Wj33d4hJmiQlguyzDxXSowutTcVQxdlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628463; c=relaxed/simple;
	bh=2W+F19iaD2xBbeDQ0H9XZqsj+qTd5YB0ei5zzMqvUcU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p9APRa0ji+MqUbpQpQmBIblW6lXZFOxv9k9TCxe9ux/AudjuHnN0XY5wb13vbeuLmj5rCPdWARPAbtQKqC2xU+EDqmq/5vC6hEe8VNg1c06pNuA/yNkNdNhhx75UiALrBgeaS+oU9hJfxpJ7b42VJPBvZwZupqiP950pL/3ZArg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwcLsqoS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SmUpGUWj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygUlTOKzEXF+yQpqn9AvwHEo+31zxOCLSQHYKPsBzCI=;
	b=AwcLsqoSdq2yuCZ/wPz97nJYw1zMk0H1qUIGt71rU3cdHRBsfTh1ytzu614uHrF3DOIeXq
	okQDRm0oddDmYQMI+VwIEFsbFFwpzjPVLxZa4R1lKht21fl2pfwdVwwAUAtaUxySkTApvh
	5wdwqRtb5vQVU/GSViot8VMuWQnA9N4GS8KN2U1VFv1/Q3kO5DZ7qyofo7oYOdFJw27mRK
	85euV5IsxnotFzQYatnAoDT+wc0w4EVg8QFHZp+uXRRo34fRW5Z9M/1ySAgowi0M5ef2mO
	GxUGT98OM+8CekDWk2ZA82tdShpyAlFSAe2G7tw1gy6gHqqewwqEkfSjyqtT0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygUlTOKzEXF+yQpqn9AvwHEo+31zxOCLSQHYKPsBzCI=;
	b=SmUpGUWj8Vs40jP/3lePxGhYWdsSJhSxZGqPevaAX994NziRRWprD4q+ovQfr1Z06UqfH9
	x2QFeMQ8E+4UkNCQ==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcov: Enable context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-30-elver@google.com>
References: <20251219154418.3592607-30-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762845749.510.12886787854662087499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6556fde265a7bd408ad8ff15ec08970f99f6201c
Gitweb:        https://git.kernel.org/tip/6556fde265a7bd408ad8ff15ec08970f99f=
6201c
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:34 +01:00

kcov: Enable context analysis

Enable context analysis for the KCOV subsystem.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-30-elver@google.com
---
 kernel/Makefile |  2 ++
 kernel/kcov.c   | 36 +++++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index e836698..6785982 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -43,6 +43,8 @@ KASAN_SANITIZE_kcov.o :=3D n
 KCSAN_SANITIZE_kcov.o :=3D n
 UBSAN_SANITIZE_kcov.o :=3D n
 KMSAN_SANITIZE_kcov.o :=3D n
+
+CONTEXT_ANALYSIS_kcov.o :=3D y
 CFLAGS_kcov.o :=3D $(call cc-option, -fno-conserve-stack) -fno-stack-protect=
or
=20
 obj-y +=3D sched/
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 6563141..6cbc6e2 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -55,13 +55,13 @@ struct kcov {
 	refcount_t		refcount;
 	/* The lock protects mode, size, area and t. */
 	spinlock_t		lock;
-	enum kcov_mode		mode;
+	enum kcov_mode		mode __guarded_by(&lock);
 	/* Size of arena (in long's). */
-	unsigned int		size;
+	unsigned int		size __guarded_by(&lock);
 	/* Coverage buffer shared with user space. */
-	void			*area;
+	void			*area __guarded_by(&lock);
 	/* Task for which we collect coverage, or NULL. */
-	struct task_struct	*t;
+	struct task_struct	*t __guarded_by(&lock);
 	/* Collecting coverage from remote (background) threads. */
 	bool			remote;
 	/* Size of remote area (in long's). */
@@ -391,6 +391,7 @@ void kcov_task_init(struct task_struct *t)
 }
=20
 static void kcov_reset(struct kcov *kcov)
+	__must_hold(&kcov->lock)
 {
 	kcov->t =3D NULL;
 	kcov->mode =3D KCOV_MODE_INIT;
@@ -400,6 +401,7 @@ static void kcov_reset(struct kcov *kcov)
 }
=20
 static void kcov_remote_reset(struct kcov *kcov)
+	__must_hold(&kcov->lock)
 {
 	int bkt;
 	struct kcov_remote *remote;
@@ -419,6 +421,7 @@ static void kcov_remote_reset(struct kcov *kcov)
 }
=20
 static void kcov_disable(struct task_struct *t, struct kcov *kcov)
+	__must_hold(&kcov->lock)
 {
 	kcov_task_reset(t);
 	if (kcov->remote)
@@ -435,8 +438,11 @@ static void kcov_get(struct kcov *kcov)
 static void kcov_put(struct kcov *kcov)
 {
 	if (refcount_dec_and_test(&kcov->refcount)) {
-		kcov_remote_reset(kcov);
-		vfree(kcov->area);
+		/* Context-safety: no references left, object being destroyed. */
+		context_unsafe(
+			kcov_remote_reset(kcov);
+			vfree(kcov->area);
+		);
 		kfree(kcov);
 	}
 }
@@ -491,6 +497,7 @@ static int kcov_mmap(struct file *filep, struct vm_area_s=
truct *vma)
 	unsigned long size, off;
 	struct page *page;
 	unsigned long flags;
+	void *area;
=20
 	spin_lock_irqsave(&kcov->lock, flags);
 	size =3D kcov->size * sizeof(unsigned long);
@@ -499,10 +506,11 @@ static int kcov_mmap(struct file *filep, struct vm_area=
_struct *vma)
 		res =3D -EINVAL;
 		goto exit;
 	}
+	area =3D kcov->area;
 	spin_unlock_irqrestore(&kcov->lock, flags);
 	vm_flags_set(vma, VM_DONTEXPAND);
 	for (off =3D 0; off < size; off +=3D PAGE_SIZE) {
-		page =3D vmalloc_to_page(kcov->area + off);
+		page =3D vmalloc_to_page(area + off);
 		res =3D vm_insert_page(vma, vma->vm_start + off, page);
 		if (res) {
 			pr_warn_once("kcov: vm_insert_page() failed\n");
@@ -522,10 +530,10 @@ static int kcov_open(struct inode *inode, struct file *=
filep)
 	kcov =3D kzalloc(sizeof(*kcov), GFP_KERNEL);
 	if (!kcov)
 		return -ENOMEM;
+	spin_lock_init(&kcov->lock);
 	kcov->mode =3D KCOV_MODE_DISABLED;
 	kcov->sequence =3D 1;
 	refcount_set(&kcov->refcount, 1);
-	spin_lock_init(&kcov->lock);
 	filep->private_data =3D kcov;
 	return nonseekable_open(inode, filep);
 }
@@ -556,6 +564,7 @@ static int kcov_get_mode(unsigned long arg)
  * vmalloc fault handling path is instrumented.
  */
 static void kcov_fault_in_area(struct kcov *kcov)
+	__must_hold(&kcov->lock)
 {
 	unsigned long stride =3D PAGE_SIZE / sizeof(unsigned long);
 	unsigned long *area =3D kcov->area;
@@ -584,6 +593,7 @@ static inline bool kcov_check_handle(u64 handle, bool com=
mon_valid,
=20
 static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			     unsigned long arg)
+	__must_hold(&kcov->lock)
 {
 	struct task_struct *t;
 	unsigned long flags, unused;
@@ -814,6 +824,7 @@ static inline bool kcov_mode_enabled(unsigned int mode)
 }
=20
 static void kcov_remote_softirq_start(struct task_struct *t)
+	__must_hold(&kcov_percpu_data.lock)
 {
 	struct kcov_percpu_data *data =3D this_cpu_ptr(&kcov_percpu_data);
 	unsigned int mode;
@@ -831,6 +842,7 @@ static void kcov_remote_softirq_start(struct task_struct =
*t)
 }
=20
 static void kcov_remote_softirq_stop(struct task_struct *t)
+	__must_hold(&kcov_percpu_data.lock)
 {
 	struct kcov_percpu_data *data =3D this_cpu_ptr(&kcov_percpu_data);
=20
@@ -896,10 +908,12 @@ void kcov_remote_start(u64 handle)
 	/* Put in kcov_remote_stop(). */
 	kcov_get(kcov);
 	/*
-	 * Read kcov fields before unlock to prevent races with
-	 * KCOV_DISABLE / kcov_remote_reset().
+	 * Read kcov fields before unlocking kcov_remote_lock to prevent races
+	 * with KCOV_DISABLE and kcov_remote_reset(); cannot acquire kcov->lock
+	 * here, because it might lead to deadlock given kcov_remote_lock is
+	 * acquired _after_ kcov->lock elsewhere.
 	 */
-	mode =3D kcov->mode;
+	mode =3D context_unsafe(kcov->mode);
 	sequence =3D kcov->sequence;
 	if (in_task()) {
 		size =3D kcov->remote_size;

