Return-Path: <linux-tip-commits+bounces-2170-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D8096D2FB
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB7E280FB0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Sep 2024 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61B19538A;
	Thu,  5 Sep 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3z7lEREb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vRLT97zD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104D2372;
	Thu,  5 Sep 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528047; cv=none; b=le6QtcoL5o88Fb9TpLuVjxWnComZwlwuRdw9urNsBevo0SofjJ1SdSlwNkV7zKZ1CWzSEpfSo/K1mcV13TB5/yz+frgcgq2NdepVJ+KMOvPDGiAggZY/pxYaTJAWmuWf+m96MNY52vxhJmr/RzmdmUKjXC/YFHhXcWxJ6hHxYQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528047; c=relaxed/simple;
	bh=bOrckqfkqXsth1pQp/PZxkNCv/WZaHe5LNGhOdQL1bI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=knHFzc8vfxCfO8wIIHVJkIQfgpNGofqf4afDAXfrBNYhuUU7voTj9eZCG22m8r9010g/actcVqNPRkGdClf4gdLEXXuHYvYUg9xKVJ3rcbscN6Pz81zwgD3I8Dt9YO4B05qdDPWOjmuTKv70+2yMHiOCUiAbfwXQr2sgP7S1iuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3z7lEREb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vRLT97zD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 05 Sep 2024 09:20:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725528044;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jP8Ry+WX1sQFKnrFEu0KyowyMF1MKzGDlgqXDlwNQ7s=;
	b=3z7lEREbxZ8LcAGtWaz1yZq0HRdQIPkAYKRaSVBzxRsqo7thxrbaUZ6uQHM7xYqi4M62hN
	Px0Y7Tqutdp0wer8gDzOfKKDQnnO6b15qrsiB9/NokWWLh5DSQmsoy+toktmWAf7eVOeKJ
	zQJdJkVwEKCYzUH2tfvpZ5EF0rFd3GYGcTLI6DOU1llE6qncMNunSUCMsBy+Sh9lOvP7sM
	i36W4qGrgCAwCori8IfyP8VQcBj8VPbXqGcuDlB21U24I7QtZchkYHzTi38ChzNhT6buF8
	u1qpA1OfgRyxdrjKW+v63vp5NZES89fXmHSxb9d1fwVwXdvD6KfgREh2CNd7Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725528044;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jP8Ry+WX1sQFKnrFEu0KyowyMF1MKzGDlgqXDlwNQ7s=;
	b=vRLT97zD9w2PlWfHoeGGHSCcEI1PgEPINyvxO/d4tiBEsPOfoBsHu22oW41TrJXaofGBl5
	Q036HXCD+3ubhLCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/aux: Fix AUX buffer serialization
Cc: Ole <ole@binarygecko.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172552804341.2215.8678570323683465419.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     2ab9d830262c132ab5db2f571003d80850d56b2a
Gitweb:        https://git.kernel.org/tip/2ab9d830262c132ab5db2f571003d80850d56b2a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 02 Sep 2024 10:14:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 04 Sep 2024 18:22:56 +02:00

perf/aux: Fix AUX buffer serialization

Ole reported that event->mmap_mutex is strictly insufficient to
serialize the AUX buffer, add a per RB mutex to fully serialize it.

Note that in the lock order comment the perf_event::mmap_mutex order
was already wrong, that is, it nesting under mmap_lock is not new with
this patch.

Fixes: 45bfb2e50471 ("perf: Add AUX area to ring buffer for raw data streams")
Reported-by: Ole <ole@binarygecko.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c        | 18 ++++++++++++------
 kernel/events/internal.h    |  1 +
 kernel/events/ring_buffer.c |  2 ++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c973e3c..8a6c6bb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1255,8 +1255,9 @@ static void put_ctx(struct perf_event_context *ctx)
  *	  perf_event_context::mutex
  *	    perf_event::child_mutex;
  *	      perf_event_context::lock
- *	    perf_event::mmap_mutex
  *	    mmap_lock
+ *	      perf_event::mmap_mutex
+ *	        perf_buffer::aux_mutex
  *	      perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
@@ -6373,12 +6374,11 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		event->pmu->event_unmapped(event, vma->vm_mm);
 
 	/*
-	 * rb->aux_mmap_count will always drop before rb->mmap_count and
-	 * event->mmap_count, so it is ok to use event->mmap_mutex to
-	 * serialize with perf_mmap here.
+	 * The AUX buffer is strictly a sub-buffer, serialize using aux_mutex
+	 * to avoid complications.
 	 */
 	if (rb_has_aux(rb) && vma->vm_pgoff == rb->aux_pgoff &&
-	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &event->mmap_mutex)) {
+	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
 		/*
 		 * Stop all AUX events that are writing to this buffer,
 		 * so that we can free its AUX pages and corresponding PMU
@@ -6395,7 +6395,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		rb_free_aux(rb);
 		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
 
-		mutex_unlock(&event->mmap_mutex);
+		mutex_unlock(&rb->aux_mutex);
 	}
 
 	if (atomic_dec_and_test(&rb->mmap_count))
@@ -6483,6 +6483,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	struct perf_event *event = file->private_data;
 	unsigned long user_locked, user_lock_limit;
 	struct user_struct *user = current_user();
+	struct mutex *aux_mutex = NULL;
 	struct perf_buffer *rb = NULL;
 	unsigned long locked, lock_limit;
 	unsigned long vma_size;
@@ -6531,6 +6532,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		if (!rb)
 			goto aux_unlock;
 
+		aux_mutex = &rb->aux_mutex;
+		mutex_lock(aux_mutex);
+
 		aux_offset = READ_ONCE(rb->user_page->aux_offset);
 		aux_size = READ_ONCE(rb->user_page->aux_size);
 
@@ -6681,6 +6685,8 @@ unlock:
 		atomic_dec(&rb->mmap_count);
 	}
 aux_unlock:
+	if (aux_mutex)
+		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
 
 	/*
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 4515144..e072d99 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -40,6 +40,7 @@ struct perf_buffer {
 	struct user_struct		*mmap_user;
 
 	/* AUX area */
+	struct mutex			aux_mutex;
 	long				aux_head;
 	unsigned int			aux_nest;
 	long				aux_wakeup;	/* last aux_watermark boundary crossed by aux_head */
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 8cadf97..4f46f68 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -337,6 +337,8 @@ ring_buffer_init(struct perf_buffer *rb, long watermark, int flags)
 	 */
 	if (!rb->nr_pages)
 		rb->paused = 1;
+
+	mutex_init(&rb->aux_mutex);
 }
 
 void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)

