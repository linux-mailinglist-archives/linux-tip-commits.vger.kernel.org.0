Return-Path: <linux-tip-commits+bounces-6273-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70277B29F17
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533FE167780
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C993C2765E9;
	Mon, 18 Aug 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EEWhIwRh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yiw5Tsgm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8352765C5;
	Mon, 18 Aug 2025 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512555; cv=none; b=sxBdHjaIt6kpULC9V7W/5pBvbtYapt5VLZJOWJkp4xPSLsm6AyO/lVWyEL09uvLe/2f/lyUEAOZNAY1QPETvbOnzeiSs8UvyDI/28z5B8J+JhFCCSGnGafsc+Ijd6ZRR64lvwlu9YaOoSeZvTc4Z4L68a/i67V4bnRlb6jfk+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512555; c=relaxed/simple;
	bh=PJJiz8T2ar2VfSy0yiN5R1WELrtDMT7zSqaYnv2NJ+A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rjPCYB3vzcMOJjHEXPUCbIa2wpxzRdZZqdMCS3Sfjh+4EY2qHt0VuTXxubFIWmwZxYr5bdwGU24vrkI39FcV5DjkfssSWME4DjwWXqvqQddRGMSaiGakoORHmHzDQiCjrLJfUBrwwClmwtKDRtj7a6MupJMh1GzZk7bNKRDiQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EEWhIwRh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yiw5Tsgm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512552;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6SLMBFHr/kipwt3ZBqYViLawf8sXOuDTZPgdnjtXWU=;
	b=EEWhIwRhH6LOkxLI+deFtTzRC2L0bY6WAgg6V1gjDbXeGJy2aDo4aZdbjS41BYaxzut7ug
	4cgF/5UmrE9RsGOi0b3F2rJL1VckCpMVmQwXzDaXTV8/kVmSdEkmtfSUgWAa4yeexZ8tWH
	YrklDtvyILvzm2zG+ur4etbXDHeZHgicw+mJaJT1uI4zSftUXiizTXTPzFkyrdJUi7dMEQ
	yp2eMSiZj9L8ykd+/vomdGe2w7WjZvmf7P5UwEMYiczR0gII0/i7vKaefo9y9zeyY6zvhl
	lSw0WqwyfC9k6oelM9BHeygOKEXeUFosPiHUJ61F8JktDZchBmThDfw7omTi4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512552;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6SLMBFHr/kipwt3ZBqYViLawf8sXOuDTZPgdnjtXWU=;
	b=Yiw5TsgmCsKcslUIUIdgsWcUBrDVFU/2EWuUFUNbKaPvA5foS3C6/0Z/rPZmFZogU25/NU
	qXf7VL7nTXTSoGDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Merge consecutive conditionals in perf_mmap()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104018.900078502@infradead.org>
References: <20250812104018.900078502@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551255167.1420.2755792250739594710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3821f258686691cf12bbfc636ab22fa2b049dc86
Gitweb:        https://git.kernel.org/tip/3821f258686691cf12bbfc636ab22fa2b04=
9dc86
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:12:59 +02:00

perf: Merge consecutive conditionals in perf_mmap()

  if (cond) {
    A;
  } else {
    B;
  }

  if (cond) {
    C;
  } else {
    D;
  }

into:

  if (cond) {
    A;
    C;
  } else {
    B;
    D;
  }

Notably the conditions are not identical in form, but are equivalent.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104018.900078502@infradead.org
---
 kernel/events/core.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9f19c61..085f36f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7064,6 +7064,25 @@ static int perf_mmap(struct file *file, struct vm_area=
_struct *vma)
 		if (vma->vm_flags & VM_WRITE)
 			flags |=3D RING_BUFFER_WRITABLE;
=20
+		rb =3D rb_alloc(nr_pages,
+			      event->attr.watermark ? event->attr.wakeup_watermark : 0,
+			      event->cpu, flags);
+
+		if (!rb) {
+			ret =3D -ENOMEM;
+			goto unlock;
+		}
+
+		atomic_set(&rb->mmap_count, 1);
+		rb->mmap_user =3D get_current_user();
+		rb->mmap_locked =3D extra;
+
+		ring_buffer_attach(event, rb);
+
+		perf_event_update_time(event);
+		perf_event_init_userpage(event);
+		perf_event_update_userpage(event);
+		ret =3D 0;
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages !=3D 0, it's already
@@ -7120,29 +7139,7 @@ static int perf_mmap(struct file *file, struct vm_area=
_struct *vma)
=20
 		if (vma->vm_flags & VM_WRITE)
 			flags |=3D RING_BUFFER_WRITABLE;
-	}
=20
-	if (!rb) {
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
-	} else {
 		ret =3D rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 				   event->attr.aux_watermark, flags);
 		if (!ret) {

