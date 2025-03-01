Return-Path: <linux-tip-commits+bounces-3752-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD24CA4AD9F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8145C3AD95A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05B71E8346;
	Sat,  1 Mar 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jbZVCXGx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBisPF+Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C091E5204;
	Sat,  1 Mar 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859654; cv=none; b=ZfMtLUTtCxN0zB2vY3DK+2MIXDzmFhGNVryn28H0EZjP0tO74XFms7xKv5GD/64I8oR4yjDp9Ts7MJDI8SbYq7XYG9ZYNBcS+QnjbqY7lANf5F+ojtB1Bbsdn46wHmEjtit+XMxGDF9lAJRnKPPYkMtuNPO06Znvkjjz3r01qXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859654; c=relaxed/simple;
	bh=z1w2N+S/dSY57FKZVKdTTCM6xrEhDOjXyhcd78FJzSs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g0d/HXJD2mwxS7/o0hbREhd9wFIM1lfGK1otaACA4OUL/8pBOwlqTSo+uDx13yAT6+2lhMKKwcrp8AeqvZJDt7/OIFwtuK1hY9Z1ri9feIZX+YUIi2ZVkmwwL7GRNSfz+3HK5Tw52CF47KBMjhQTtPlY2zK6yVtWx/rVNpyW1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jbZVCXGx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBisPF+Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4iMa5kddtPBhwRv/qqdU+DmNu+yenD3oAcB+oHKQ44=;
	b=jbZVCXGxBa8uSR0Vs4C3CDwK7jUvj6FnNy9YpeklGQcPz1Q2G2XDAkPIW6AQfmHQnLs2fF
	dnr+fX28raGSsnnl5sVb8evhNsXYYMWulEGJNSoCKgKdM5TASj+oZl8aZG1SvpRVBySUqg
	z3eYQMy1hVPJVBhgrQfpnAOt5JtuZffXeFPaSHNQH1ooFO+eDmHO74n9qinYZHIUoHNtRe
	pQhhpznicLAKHVuY9JjSX24EmeHTMbXnkF+fNqjGnDLrtjDiKxAn+UnV4ulKuVlnOlIswU
	eWDewcXqGSgU1VKNoSXoOTIujasqaoC2DNEtWY+hYtnKAvdrgoHvQ8P1hqF2jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4iMa5kddtPBhwRv/qqdU+DmNu+yenD3oAcB+oHKQ44=;
	b=xBisPF+YMIqvOFAh3UDzVqb9JOCsbnJQieoxFCy42owIqN5ZSf+PGSgZcbWsAIKg6cSBuD
	pN9ZY/TX6Aa5z2BQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Simplify the perf_mmap() control flow
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.095904637@infradead.org>
References: <20241104135519.095904637@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965114.10177.2668684232181199981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7503c90c0df8d0178be66d53705eacd9e843d762
Gitweb:        https://git.kernel.org/tip/7503c90c0df8d0178be66d53705eacd9e843d762
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 20:12:53 +01:00

perf/core: Simplify the perf_mmap() control flow

Identity-transform:

	if (c) {
		X1;
	} else {
		Y;
		goto l;
	}

	X2;
  l:

into the simpler:

	if (c) {
		X1;
		X2;
	} else {
		Y;
	}

[ mingo: Forward ported it ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241104135519.095904637@infradead.org
---
 kernel/events/core.c | 75 ++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ab4e497..d1b04c8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6701,6 +6701,42 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	if (vma->vm_pgoff == 0) {
 		nr_pages = (vma_size / PAGE_SIZE) - 1;
+
+		/*
+		 * If we have rb pages ensure they're a power-of-two number, so we
+		 * can do bitmasks instead of modulo.
+		 */
+		if (nr_pages != 0 && !is_power_of_2(nr_pages))
+			return -EINVAL;
+
+		if (vma_size != PAGE_SIZE * (1 + nr_pages))
+			return -EINVAL;
+
+		WARN_ON_ONCE(event->ctx->parent_ctx);
+again:
+		mutex_lock(&event->mmap_mutex);
+		if (event->rb) {
+			if (data_page_nr(event->rb) != nr_pages) {
+				ret = -EINVAL;
+				goto unlock;
+			}
+
+			if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
+				/*
+				 * Raced against perf_mmap_close(); remove the
+				 * event and try again.
+				 */
+				ring_buffer_attach(event, NULL);
+				mutex_unlock(&event->mmap_mutex);
+				goto again;
+			}
+
+			/* We need the rb to map pages. */
+			rb = event->rb;
+			goto unlock;
+		}
+
+		user_extra = nr_pages + 1;
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
@@ -6760,47 +6796,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 		atomic_set(&rb->aux_mmap_count, 1);
 		user_extra = nr_pages;
-
-		goto accounting;
-	}
-
-	/*
-	 * If we have rb pages ensure they're a power-of-two number, so we
-	 * can do bitmasks instead of modulo.
-	 */
-	if (nr_pages != 0 && !is_power_of_2(nr_pages))
-		return -EINVAL;
-
-	if (vma_size != PAGE_SIZE * (1 + nr_pages))
-		return -EINVAL;
-
-	WARN_ON_ONCE(event->ctx->parent_ctx);
-again:
-	mutex_lock(&event->mmap_mutex);
-	if (event->rb) {
-		if (data_page_nr(event->rb) != nr_pages) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-
-		if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
-			/*
-			 * Raced against perf_mmap_close(); remove the
-			 * event and try again.
-			 */
-			ring_buffer_attach(event, NULL);
-			mutex_unlock(&event->mmap_mutex);
-			goto again;
-		}
-
-		/* We need the rb to map pages. */
-		rb = event->rb;
-		goto unlock;
 	}
 
-	user_extra = nr_pages + 1;
-
-accounting:
 	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
 
 	/*

