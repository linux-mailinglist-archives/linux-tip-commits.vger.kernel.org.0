Return-Path: <linux-tip-commits+bounces-6266-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4ACB29EF9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7612E7AA6AE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4620831984B;
	Mon, 18 Aug 2025 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NfxA2vG9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Em/+jxV+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6B31812D;
	Mon, 18 Aug 2025 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512548; cv=none; b=H+k4V+ewp6IWr+c91NbMZu7J/RD7veisTrpYxK9qpH6e3ngW0gGyenk9ulkHOtKAmOEWLNW6k2+AGfl1goWC0AiOS0DVd2Q5q/cUUK3owioNmGu5ye0w7alyBoyOkwIuQWCoF4KahCZwEccvRZKAB1tAAHEX3obsZfWsnbbCVig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512548; c=relaxed/simple;
	bh=R6x1o0LExfkrZ8LQwxpyWgd2JSRJ+7pttznl6Ro9BTU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kOyUpm+3Td7lk/v96YG7EDoc3VXc46OSHlQQm/XRMj3cdrCRi4oAakPSNjEFeXH68QghmquBfAyV85jun9JMGwMJpQwE+K8pMaZ5ilUPzxg+9YrlfXUSrY5N0A33v8qkrWbnGknRLuWIRP106Q2B0UGeiO5SKhyjul8IR5P6Y4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NfxA2vG9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Em/+jxV+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7hVqJD6JHe0OaC1Q7fc62WJZIYL9mw0QEhEQe2O/j8=;
	b=NfxA2vG9Mjd0nazCaX1E6F5gep5A4nmd4uXo/ZObs+8XNuuuMB/qDpdXhCiV7JCDCI2srz
	xRZk+nGDJuT+bARMXj29ypEnJMmk9bqIjjtAb+qBf21YoxjgMJIF2e1MhY24XQYMSqyNzE
	8O/EvPabxCL8P9hS9ccEZtDPHznndnDDOGD6QUT9/+Yi5Gv+fPDHj5Pa+O1JC2opBcBAjV
	1OlgvWda5PasNrpMPWMYXS0kMJauzZd0hB3nCIHvnT/BcLJWB5iCHSsOzpoJLwRAGqBymD
	wZfGCdfnxDmF/S7mWXAF1BOLYJ4ig90wOmxDh490E2oFyt4UKKmvVMJmLkpU0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7hVqJD6JHe0OaC1Q7fc62WJZIYL9mw0QEhEQe2O/j8=;
	b=Em/+jxV+/EEzsYjgfeHAI6Hh3OJRtmpf31kxTIP6MnBIRnLyE43tNYgMrKe9BnwHIx0IQd
	1Pb19D23Kv6s8nBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Split out the RB allocation
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104019.722214699@infradead.org>
References: <20250812104019.722214699@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551254349.1420.8246848903167255268.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5d299897f1e36025400ca84fd36c15925a383b03
Gitweb:        https://git.kernel.org/tip/5d299897f1e36025400ca84fd36c15925a3=
83b03
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:13:01 +02:00

perf: Split out the RB allocation

Move the RB buffer allocation branch into its own function.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104019.722214699@infradead.org
---
 kernel/events/core.c | 145 +++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 72 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 875c27b..3a5fd2b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6970,6 +6970,75 @@ static void perf_mmap_account(struct vm_area_struct *v=
ma, long user_extra, long=20
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
=20
+static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
+			unsigned long nr_pages)
+{
+	long extra =3D 0, user_extra =3D nr_pages;
+	struct perf_buffer *rb;
+	int rb_flags =3D 0;
+
+	nr_pages -=3D 1;
+
+	/*
+	 * If we have rb pages ensure they're a power-of-two number, so we
+	 * can do bitmasks instead of modulo.
+	 */
+	if (nr_pages !=3D 0 && !is_power_of_2(nr_pages))
+		return -EINVAL;
+
+	WARN_ON_ONCE(event->ctx->parent_ctx);
+
+	if (event->rb) {
+		if (data_page_nr(event->rb) !=3D nr_pages)
+			return -EINVAL;
+
+		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
+			/*
+			 * Success -- managed to mmap() the same buffer
+			 * multiple times.
+			 */
+			perf_mmap_account(vma, user_extra, extra);
+			atomic_inc(&event->mmap_count);
+			return 0;
+		}
+
+		/*
+		 * Raced against perf_mmap_close()'s
+		 * atomic_dec_and_mutex_lock() remove the
+		 * event and continue as if !event->rb
+		 */
+		ring_buffer_attach(event, NULL);
+	}
+
+	if (!perf_mmap_calc_limits(vma, &user_extra, &extra))
+		return -EPERM;
+
+	if (vma->vm_flags & VM_WRITE)
+		rb_flags |=3D RING_BUFFER_WRITABLE;
+
+	rb =3D rb_alloc(nr_pages,
+		      event->attr.watermark ? event->attr.wakeup_watermark : 0,
+		      event->cpu, rb_flags);
+
+	if (!rb)
+		return -ENOMEM;
+
+	atomic_set(&rb->mmap_count, 1);
+	rb->mmap_user =3D get_current_user();
+	rb->mmap_locked =3D extra;
+
+	ring_buffer_attach(event, rb);
+
+	perf_event_update_time(event);
+	perf_event_init_userpage(event);
+	perf_event_update_userpage(event);
+
+	perf_mmap_account(vma, user_extra, extra);
+	atomic_inc(&event->mmap_count);
+
+	return 0;
+}
+
 static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *even=
t,
 			 unsigned long nr_pages)
 {
@@ -7050,10 +7119,8 @@ static int perf_mmap(struct file *file, struct vm_area=
_struct *vma)
 {
 	struct perf_event *event =3D file->private_data;
 	unsigned long vma_size, nr_pages;
-	long user_extra =3D 0, extra =3D 0;
-	struct perf_buffer *rb =3D NULL;
-	int ret, flags =3D 0;
 	mapped_f mapped;
+	int ret;
=20
 	/*
 	 * Don't allow mmap() of inherited per-task counters. This would
@@ -7079,8 +7146,6 @@ static int perf_mmap(struct file *file, struct vm_area_=
struct *vma)
 	if (vma_size !=3D PAGE_SIZE * nr_pages)
 		return -EINVAL;
=20
-	user_extra =3D nr_pages;
-
 	mutex_lock(&event->mmap_mutex);
 	ret =3D -EINVAL;
=20
@@ -7094,74 +7159,10 @@ static int perf_mmap(struct file *file, struct vm_are=
a_struct *vma)
 		goto unlock;
 	}
=20
-	if (vma->vm_pgoff =3D=3D 0) {
-		nr_pages -=3D 1;
-
-		/*
-		 * If we have rb pages ensure they're a power-of-two number, so we
-		 * can do bitmasks instead of modulo.
-		 */
-		if (nr_pages !=3D 0 && !is_power_of_2(nr_pages))
-			goto unlock;
-
-		WARN_ON_ONCE(event->ctx->parent_ctx);
-
-		if (event->rb) {
-			if (data_page_nr(event->rb) !=3D nr_pages)
-				goto unlock;
-
-			if (atomic_inc_not_zero(&event->rb->mmap_count)) {
-				/*
-				 * Success -- managed to mmap() the same buffer
-				 * multiple times.
-				 */
-				ret =3D 0;
-				perf_mmap_account(vma, user_extra, extra);
-				atomic_inc(&event->mmap_count);
-				goto unlock;
-			}
-
-			/*
-			 * Raced against perf_mmap_close()'s
-			 * atomic_dec_and_mutex_lock() remove the
-			 * event and continue as if !event->rb
-			 */
-			ring_buffer_attach(event, NULL);
-		}
-
-		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-			ret =3D -EPERM;
-			goto unlock;
-		}
-
-		if (vma->vm_flags & VM_WRITE)
-			flags |=3D RING_BUFFER_WRITABLE;
-
-		rb =3D rb_alloc(nr_pages,
-			      event->attr.watermark ? event->attr.wakeup_watermark : 0,
-			      event->cpu, flags);
-
-		if (!rb) {
-			ret =3D -ENOMEM;
-			goto unlock;
-		}
-
-		atomic_set(&rb->mmap_count, 1);
-		rb->mmap_user =3D get_current_user();
-		rb->mmap_locked =3D extra;
-
-		ring_buffer_attach(event, rb);
-
-		perf_event_update_time(event);
-		perf_event_init_userpage(event);
-		perf_event_update_userpage(event);
-		ret =3D 0;
-
-		perf_mmap_account(vma, user_extra, extra);
-		atomic_inc(&event->mmap_count);
-	} else {
+	if (vma->vm_pgoff =3D=3D 0)
+		ret =3D perf_mmap_rb(vma, event, nr_pages);
+	else
 		ret =3D perf_mmap_aux(vma, event, nr_pages);
-	}
=20
 unlock:
 	mutex_unlock(&event->mmap_mutex);

