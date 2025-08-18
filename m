Return-Path: <linux-tip-commits+bounces-6263-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA223B29F08
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD82173227
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE24A7082D;
	Mon, 18 Aug 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KAZ6vrpf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dM80Vd7D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6A221FB1;
	Mon, 18 Aug 2025 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512543; cv=none; b=ssG3f7RZInv0HhyLrQ6wVf+etPmOmdYMzyNtu+3PAfai3L+DxMAY5odtgAh037tPjNvBcLXocvCcJ2d7fbhGVoiikuEhRWGM4jRyszK+cmxPf5qSvDHjvfKaKp88R3RIdrrp9Do9c3bYjawGuGBaYSs8DfRXeyRHNK582ly8ekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512543; c=relaxed/simple;
	bh=SntFiS6QPbsyOc9DuQf4H9sz4IJMWyq1A+aJnFxqZ7c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qzT5OxLf3J/pp/+aUWDDoi3E2QOQLRFrY1JKrXmJzrECvo2Wze53Uf23wm9dsdDeAAYs6FSvfZE3VC7FWt6vTajPS6CxLGb0l7Z4V/w+PXCo5mTC+18ZuCbKwrLc4m7tItpT6F3GdxTh0vM2Z6/nj/vdzDaYhF30lRPYkhltdMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KAZ6vrpf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dM80Vd7D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9SbA5AxHGint46uJamt4GI+6c4xK6Wc3a08pPmPtyY=;
	b=KAZ6vrpf/Iu74Q1nsmEKSezkar9jDMSzfNSTRUwUEdgUuSgRvy0SiAc0pqdGZqF6YGX6wm
	jkIqAHXzraTgiRKVWGYYGTecEKaYMuplKlf99b+lZflYvxQXK2RFT3nv/vJ3EO18oTDV6G
	y8SGS10fVneWh1JLfCRJYRvEweYmSktSg+kjhlakb3cARNu7YedghuIAS03ZRksFnVsVQw
	Qeq0+91dr0G+ky7f6DYpCkoglJEB/0JP5SPJygJXu9XErdVe9oYljCz+UWAYdczaesSLJY
	SJio7jvfD2rogD++DOaqmUs/lJESHOnr9SawbpqwEbTW7UAOSXh+ZGt6NUPXtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9SbA5AxHGint46uJamt4GI+6c4xK6Wc3a08pPmPtyY=;
	b=dM80Vd7DYxUidQmMB4l1veBUSNNmKzcQ4rFksMLAGj73j0kaYUtYxiChtpMEQRN3AaPkqW
	8wILmi4OsqyWNKAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Convert mmap() refcounts to refcount_t
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104020.071507932@infradead.org>
References: <20250812104020.071507932@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551253808.1420.16338000329829393080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     448f97fba9013ffa13f5dd82febd18836b189499
Gitweb:        https://git.kernel.org/tip/448f97fba9013ffa13f5dd82febd18836b1=
89499
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 12:39:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:13:02 +02:00

perf: Convert mmap() refcounts to refcount_t

The recently fixed reference count leaks could have been detected by using
refcount_t and refcount_t would have mitigated the potential overflow at
least.

Now that the code is properly structured, convert the mmap() related
mmap_count variants over to refcount_t.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104020.071507932@infradead.org
---
 include/linux/perf_event.h  |  2 +-
 kernel/events/core.c        | 40 ++++++++++++++++++------------------
 kernel/events/internal.h    |  4 ++--
 kernel/events/ring_buffer.c |  2 +-
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ec9d960..bfbf9ea 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -859,7 +859,7 @@ struct perf_event {
=20
 	/* mmap bits */
 	struct mutex			mmap_mutex;
-	atomic_t			mmap_count;
+	refcount_t			mmap_count;
=20
 	struct perf_buffer		*rb;
 	struct list_head		rb_entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f6211ab..ea35704 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3968,7 +3968,7 @@ static noinline int visit_groups_merge(struct perf_even=
t_context *ctx,
  */
 static inline bool event_update_userpage(struct perf_event *event)
 {
-	if (likely(!atomic_read(&event->mmap_count)))
+	if (likely(!refcount_read(&event->mmap_count)))
 		return false;
=20
 	perf_event_update_time(event);
@@ -6704,11 +6704,11 @@ static void perf_mmap_open(struct vm_area_struct *vma)
 	struct perf_event *event =3D vma->vm_file->private_data;
 	mapped_f mapped =3D get_mapped(event, event_mapped);
=20
-	atomic_inc(&event->mmap_count);
-	atomic_inc(&event->rb->mmap_count);
+	refcount_inc(&event->mmap_count);
+	refcount_inc(&event->rb->mmap_count);
=20
 	if (vma->vm_pgoff)
-		atomic_inc(&event->rb->aux_mmap_count);
+		refcount_inc(&event->rb->aux_mmap_count);
=20
 	if (mapped)
 		mapped(event, vma->vm_mm);
@@ -6743,7 +6743,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 * to avoid complications.
 	 */
 	if (rb_has_aux(rb) && vma->vm_pgoff =3D=3D rb->aux_pgoff &&
-	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
+	    refcount_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
 		/*
 		 * Stop all AUX events that are writing to this buffer,
 		 * so that we can free its AUX pages and corresponding PMU
@@ -6763,10 +6763,10 @@ static void perf_mmap_close(struct vm_area_struct *vm=
a)
 		mutex_unlock(&rb->aux_mutex);
 	}
=20
-	if (atomic_dec_and_test(&rb->mmap_count))
+	if (refcount_dec_and_test(&rb->mmap_count))
 		detach_rest =3D true;
=20
-	if (!atomic_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
+	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
 		goto out_put;
=20
 	ring_buffer_attach(event, NULL);
@@ -6992,19 +6992,19 @@ static int perf_mmap_rb(struct vm_area_struct *vma, s=
truct perf_event *event,
 		if (data_page_nr(event->rb) !=3D nr_pages)
 			return -EINVAL;
=20
-		if (atomic_inc_not_zero(&event->rb->mmap_count)) {
+		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
 			/*
 			 * Success -- managed to mmap() the same buffer
 			 * multiple times.
 			 */
 			perf_mmap_account(vma, user_extra, extra);
-			atomic_inc(&event->mmap_count);
+			refcount_inc(&event->mmap_count);
 			return 0;
 		}
=20
 		/*
 		 * Raced against perf_mmap_close()'s
-		 * atomic_dec_and_mutex_lock() remove the
+		 * refcount_dec_and_mutex_lock() remove the
 		 * event and continue as if !event->rb
 		 */
 		ring_buffer_attach(event, NULL);
@@ -7023,7 +7023,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, str=
uct perf_event *event,
 	if (!rb)
 		return -ENOMEM;
=20
-	atomic_set(&rb->mmap_count, 1);
+	refcount_set(&rb->mmap_count, 1);
 	rb->mmap_user =3D get_current_user();
 	rb->mmap_locked =3D extra;
=20
@@ -7034,7 +7034,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, str=
uct perf_event *event,
 	perf_event_update_userpage(event);
=20
 	perf_mmap_account(vma, user_extra, extra);
-	atomic_set(&event->mmap_count, 1);
+	refcount_set(&event->mmap_count, 1);
=20
 	return 0;
 }
@@ -7081,15 +7081,15 @@ static int perf_mmap_aux(struct vm_area_struct *vma, =
struct perf_event *event,
 	if (!is_power_of_2(nr_pages))
 		return -EINVAL;
=20
-	if (!atomic_inc_not_zero(&rb->mmap_count))
+	if (!refcount_inc_not_zero(&rb->mmap_count))
 		return -EINVAL;
=20
 	if (rb_has_aux(rb)) {
-		atomic_inc(&rb->aux_mmap_count);
+		refcount_inc(&rb->aux_mmap_count);
=20
 	} else {
 		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
-			atomic_dec(&rb->mmap_count);
+			refcount_dec(&rb->mmap_count);
 			return -EPERM;
 		}
=20
@@ -7101,16 +7101,16 @@ static int perf_mmap_aux(struct vm_area_struct *vma, =
struct perf_event *event,
 		ret =3D rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 				   event->attr.aux_watermark, rb_flags);
 		if (ret) {
-			atomic_dec(&rb->mmap_count);
+			refcount_dec(&rb->mmap_count);
 			return ret;
 		}
=20
-		atomic_set(&rb->aux_mmap_count, 1);
+		refcount_set(&rb->aux_mmap_count, 1);
 		rb->aux_mmap_locked =3D extra;
 	}
=20
 	perf_mmap_account(vma, user_extra, extra);
-	atomic_inc(&event->mmap_count);
+	refcount_inc(&event->mmap_count);
=20
 	return 0;
 }
@@ -13254,7 +13254,7 @@ perf_event_set_output(struct perf_event *event, struc=
t perf_event *output_event)
 	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
 set:
 	/* Can't redirect output if we've got an active mmap() */
-	if (atomic_read(&event->mmap_count))
+	if (refcount_read(&event->mmap_count))
 		goto unlock;
=20
 	if (output_event) {
@@ -13267,7 +13267,7 @@ set:
 			goto unlock;
=20
 		/* did we race against perf_mmap_close() */
-		if (!atomic_read(&rb->mmap_count)) {
+		if (!refcount_read(&rb->mmap_count)) {
 			ring_buffer_put(rb);
 			goto unlock;
 		}
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 249288d..d9cc570 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -35,7 +35,7 @@ struct perf_buffer {
 	spinlock_t			event_lock;
 	struct list_head		event_list;
=20
-	atomic_t			mmap_count;
+	refcount_t			mmap_count;
 	unsigned long			mmap_locked;
 	struct user_struct		*mmap_user;
=20
@@ -47,7 +47,7 @@ struct perf_buffer {
 	unsigned long			aux_pgoff;
 	int				aux_nr_pages;
 	int				aux_overwrite;
-	atomic_t			aux_mmap_count;
+	refcount_t			aux_mmap_count;
 	unsigned long			aux_mmap_locked;
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index aa9a759..20a9050 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -400,7 +400,7 @@ void *perf_aux_output_begin(struct perf_output_handle *ha=
ndle,
 	 * the same order, see perf_mmap_close. Otherwise we end up freeing
 	 * aux pages in this path, which is a bug, because in_atomic().
 	 */
-	if (!atomic_read(&rb->aux_mmap_count))
+	if (!refcount_read(&rb->aux_mmap_count))
 		goto err;
=20
 	if (!refcount_inc_not_zero(&rb->aux_refcount))

