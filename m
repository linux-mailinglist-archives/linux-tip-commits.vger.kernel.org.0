Return-Path: <linux-tip-commits+bounces-6276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF905B29F1B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3E617A1B6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5269D258EC5;
	Mon, 18 Aug 2025 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CKDcelTq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8GFGlsaA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E4258EC2;
	Mon, 18 Aug 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512606; cv=none; b=W94KJvv+H7XqOYWHnPhzqQX0e53qKMSjmss1wJ1kH48MJrH6KwoqtwpEeMUgw+6cZ6bFcQj3fxdOyMMaOo+8F7bR1oh2lT3R3d0/JwD+Q4dFZy60swvQ+Pphaw4XX3Y0UR31sQbHQpJjSqi/Gi9UhtkphmFVKM73xzXf3HqegOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512606; c=relaxed/simple;
	bh=iwq7xfVKmXNZ6vmO13Crnqc/DcK+UMp/M84NBhPW1zo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gINRpo1ZIShL9PqlO+P3IXP5N8KGootPTpZBKaLwrKRhXkYDn0f8QM2A1dYcew5bJoLW7/x4KgUBVulfRO5G5CUjlj8+jykMP/XlsxMkMCW+SP4u6saSkUnq2z6YePtrJeLzeobw9MCxbXR8a7GsP174T0BxQwBscTltJMTySzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CKDcelTq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8GFGlsaA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpBhaowErr9gwukZs04zMAzGRt5+vaOWTx2c4Pu+bNU=;
	b=CKDcelTq+jmk8TGzQWhI45l4M3oe+DbrcVXlt5QQkZCVTS09H1Zq8WytzRAJXt6uo+hn0U
	YIUR0RZxcsV05j+oVPp7wPI89Lepfef6ZG1VT2+N2Dhyz/SSxkn7N1VD0rqbAREyf7rGoE
	oHxCRrsWCZTwjZ37veaqu+SYdeUHJdI0yCbij/xAr+W1FSK51sitH4Nmnq7jSaToSJcfAt
	ErnK5LMcvIHzrneoU5lojtige9e5Lj8kqikaxZlvudq5dQC+tUX3QKfaxRviI7d13egKxG
	SV8XH4acxOVgQrzxU2NMFZhrVAaj+srKSl7RkWpk/2hi5ojbUoD3NMDVrt/c3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xpBhaowErr9gwukZs04zMAzGRt5+vaOWTx2c4Pu+bNU=;
	b=8GFGlsaAHOsnr/wnLrVCymhE1bMpYm1sDXvC1LYaADs8EWPJKNS8DgLFMnjbeV6UBPYl57
	IX3NdleO6BtzerCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Split out mlock limit handling
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104018.541975109@infradead.org>
References: <20250812104018.541975109@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551255507.1420.5370344802361337547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     81e026ca47b386e4213c1beff069038a3ba8bb76
Gitweb:        https://git.kernel.org/tip/81e026ca47b386e4213c1beff069038a3ba=
8bb76
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 12:39:00 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:12:58 +02:00

perf: Split out mlock limit handling

To prepare for splitting the buffer allocation out into separate functions
for the ring buffer and the AUX buffer, split out mlock limit handling into
a helper function, which can be called from both.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104018.541975109@infradead.org
---
 kernel/events/core.c | 75 +++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index eea3a7d..f629901 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6927,17 +6927,49 @@ static int map_range(struct perf_buffer *rb, struct v=
m_area_struct *vma)
 	return err;
 }
=20
+static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_ext=
ra, long *extra)
+{
+	unsigned long user_locked, user_lock_limit, locked, lock_limit;
+	struct user_struct *user =3D current_user();
+
+	user_lock_limit =3D sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
+	/* Increase the limit linearly with more CPUs */
+	user_lock_limit *=3D num_online_cpus();
+
+	user_locked =3D atomic_long_read(&user->locked_vm);
+
+	/*
+	 * sysctl_perf_event_mlock may have changed, so that
+	 *     user->locked_vm > user_lock_limit
+	 */
+	if (user_locked > user_lock_limit)
+		user_locked =3D user_lock_limit;
+	user_locked +=3D *user_extra;
+
+	if (user_locked > user_lock_limit) {
+		/*
+		 * charge locked_vm until it hits user_lock_limit;
+		 * charge the rest from pinned_vm
+		 */
+		*extra =3D user_locked - user_lock_limit;
+		*user_extra -=3D *extra;
+	}
+
+	lock_limit =3D rlimit(RLIMIT_MEMLOCK);
+	lock_limit >>=3D PAGE_SHIFT;
+	locked =3D atomic64_read(&vma->vm_mm->pinned_vm) + *extra;
+
+	return locked <=3D lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOC=
K);
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event =3D file->private_data;
-	unsigned long user_locked, user_lock_limit;
 	struct user_struct *user =3D current_user();
+	unsigned long vma_size, nr_pages;
+	long user_extra =3D 0, extra =3D 0;
 	struct mutex *aux_mutex =3D NULL;
 	struct perf_buffer *rb =3D NULL;
-	unsigned long locked, lock_limit;
-	unsigned long vma_size;
-	unsigned long nr_pages;
-	long user_extra =3D 0, extra =3D 0;
 	int ret, flags =3D 0;
 	mapped_f mapped;
=20
@@ -7063,38 +7095,7 @@ static int perf_mmap(struct file *file, struct vm_area=
_struct *vma)
 		}
 	}
=20
-	user_lock_limit =3D sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
-
-	/*
-	 * Increase the limit linearly with more CPUs:
-	 */
-	user_lock_limit *=3D num_online_cpus();
-
-	user_locked =3D atomic_long_read(&user->locked_vm);
-
-	/*
-	 * sysctl_perf_event_mlock may have changed, so that
-	 *     user->locked_vm > user_lock_limit
-	 */
-	if (user_locked > user_lock_limit)
-		user_locked =3D user_lock_limit;
-	user_locked +=3D user_extra;
-
-	if (user_locked > user_lock_limit) {
-		/*
-		 * charge locked_vm until it hits user_lock_limit;
-		 * charge the rest from pinned_vm
-		 */
-		extra =3D user_locked - user_lock_limit;
-		user_extra -=3D extra;
-	}
-
-	lock_limit =3D rlimit(RLIMIT_MEMLOCK);
-	lock_limit >>=3D PAGE_SHIFT;
-	locked =3D atomic64_read(&vma->vm_mm->pinned_vm) + extra;
-
-	if ((locked > lock_limit) && perf_is_paranoid() &&
-		!capable(CAP_IPC_LOCK)) {
+	if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
 		ret =3D -EPERM;
 		goto unlock;
 	}

