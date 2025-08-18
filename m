Return-Path: <linux-tip-commits+bounces-6272-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C1B29F09
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC44D1894D5E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FDA2765D7;
	Mon, 18 Aug 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LtqzezVX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AAoS5JM+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D68258EF7;
	Mon, 18 Aug 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512554; cv=none; b=gYavpXToF5CaVfkglu9g9BBay/xpPFBMXMgVdzHzVeWgtCwT0gWNqJPtTEhNqRQTRg5RnyHg2OvQZYrfCwYCtcamjdqvdcmHrBWbRvRYl/tQkuRBVQAtYfqqipoYs3Q9NvKfW8sNfh+DaF9oD1TKFt7k8O2LWR2AQV8b4Uml0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512554; c=relaxed/simple;
	bh=fcgJULH2ke5gZ8Ygr9a+KfdlC/MYgfL5MYvrSKmOoHo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LHd8Mj1UrKzGWQmWwC3jb3DDCoBwEUQKOLLsBjJUnDXOj9hezhMgCZsAbXc/uhwC0YejH8dP7uKeLieQ4bXVUjGXep4j7yu99xh8MgmOPS1u3uPN80eOTpyBfhF6y0Xm/Xw97+81R5ENh/ZRtoPTBLeU+xvdtqnaHaxxW/xMVDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LtqzezVX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AAoS5JM+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512551;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMa1UK1jUC0vmiQEXmcvMt4U6K8vAE2QqFSNeJYPbqU=;
	b=LtqzezVXgatpdD5Kk+/ouzCSs0O3UT8DQ/+2rMs6XwWcgPp05PZHTK04xSQqJTWC53tUpI
	L94YjGl8h2ZygxRO616tO/iFwTMiKztpFFMZBRV+FfCNF3YqcT25ikKzYSEDzLWRPN+kFM
	LKm6DBuiCTw1q8eO+7RfhHd4e1BmJ3QaJe7g8BZNB7xojWhwdOvunFNj2YlvDZ93jZUNW/
	8kOaiH+8A4xD/z+4fBQtv5+2BUDbSfKoVhDvVqf27AQnKtUk+2+/6K26nqSjbzU8PUQgmA
	XkKU70yIrZqjLB0EZdi+3TaeCayAx1Il5YjfCFHtGoX4LEP32TahH8z+l3uYYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512551;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WMa1UK1jUC0vmiQEXmcvMt4U6K8vAE2QqFSNeJYPbqU=;
	b=AAoS5JM+xOyHt00tVxQ2ZsxAOAwisAq81Cm0DKUIC7GyDoI/d3e2cC/bQPLm2Erej0E6Vq
	euGJ94RH3MBnYbDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Move common code into both rb and aux branches
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104019.016252852@infradead.org>
References: <20250812104019.016252852@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551255060.1420.152065965008487039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4118994b33bb628dd9aeb941c5af6f950f1dea90
Gitweb:        https://git.kernel.org/tip/4118994b33bb628dd9aeb941c5af6f950f1=
dea90
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Aug 2025 12:39:04 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:12:59 +02:00

perf: Move common code into both rb and aux branches

  if (cond) {
    A;
  } else {
    B;
  }
  C;

into

  if (cond) {
    A;
    C;
  } else {
    B;
    C;
  }

Notably C has a success branch and both A and B have two places for
success. For A (rb case), duplicate the success case because later
patches will result in them no longer being identical. For B (aux
case), share using goto (cleaned up later).

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104019.016252852@infradead.org
---
 kernel/events/core.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 085f36f..dfe09b0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7043,6 +7043,8 @@ static int perf_mmap(struct file *file, struct vm_area_=
struct *vma)
 				ret =3D 0;
 				/* We need the rb to map pages. */
 				rb =3D event->rb;
+				perf_mmap_account(vma, user_extra, extra);
+				atomic_inc(&event->mmap_count);
 				goto unlock;
 			}
=20
@@ -7083,6 +7085,9 @@ static int perf_mmap(struct file *file, struct vm_area_=
struct *vma)
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 		ret =3D 0;
+
+		perf_mmap_account(vma, user_extra, extra);
+		atomic_inc(&event->mmap_count);
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages !=3D 0, it's already
@@ -7127,11 +7132,12 @@ static int perf_mmap(struct file *file, struct vm_are=
a_struct *vma)
 		if (rb_has_aux(rb)) {
 			atomic_inc(&rb->aux_mmap_count);
 			ret =3D 0;
-			goto unlock;
+			goto aux_success;
 		}
=20
 		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
 			ret =3D -EPERM;
+			atomic_dec(&rb->mmap_count);
 			goto unlock;
 		}
=20
@@ -7142,20 +7148,19 @@ static int perf_mmap(struct file *file, struct vm_are=
a_struct *vma)
=20
 		ret =3D rb_alloc_aux(rb, event, vma->vm_pgoff, nr_pages,
 				   event->attr.aux_watermark, flags);
-		if (!ret) {
-			atomic_set(&rb->aux_mmap_count, 1);
-			rb->aux_mmap_locked =3D extra;
+		if (ret) {
+			atomic_dec(&rb->mmap_count);
+			goto unlock;
 		}
-	}
=20
-unlock:
-	if (!ret) {
+		atomic_set(&rb->aux_mmap_count, 1);
+		rb->aux_mmap_locked =3D extra;
+aux_success:
 		perf_mmap_account(vma, user_extra, extra);
 		atomic_inc(&event->mmap_count);
-	} else if (rb) {
-		/* AUX allocation failed */
-		atomic_dec(&rb->mmap_count);
 	}
+
+unlock:
 aux_unlock:
 	if (aux_mutex)
 		mutex_unlock(aux_mutex);

