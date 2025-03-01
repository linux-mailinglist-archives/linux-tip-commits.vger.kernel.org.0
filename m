Return-Path: <linux-tip-commits+bounces-3749-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BB8A4AD9C
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB671170076
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406E51E766E;
	Sat,  1 Mar 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFuN274i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uj5lGpwh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2721C3BE9;
	Sat,  1 Mar 2025 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859654; cv=none; b=lF8xVUAldZGC2TZxVVCaHJBLLlLStVfxsfFjTz80X+2Agaf7Eawdtin3KQD/PfON7uerkErKlJLXVOv+xNs3LmVxM0yuf8Sim2kbhVc6NepQ9w40EIe5le1ODyyr8uWDIBLVeJhul4sRgsJ4SMn0KML7N8iEkhga6QkR4/3B5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859654; c=relaxed/simple;
	bh=tohc06n0Jhqr4Rys0IGQUmfvOF9M3P5Snt6m3SV0C9c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lqJv2lb6lh6tZ66QN3CLdznBN8klqVb0M3GdRb1Bb4U5rFGm+oSAATrxqI59gWorB6glf4ybcnkyMa5q7TqQBifBvIXSQMpBLs6Y2Y6s1FO+TACXgJ3B3BJA7KIOvNJpjTiftYQUKwQmxKQCvH1skLrBXQ6xgsvcEQWphjby2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFuN274i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uj5lGpwh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXfDhS4UHas27gO/oJlWHmFdlA0wZ7z1nOSxRihOwFI=;
	b=cFuN274i5bmNvQUI/5fSA/px3qmzS0Sd2/eAeTDTSGk8gIv48QCNG34iRU2uxzCZ181Hke
	bvpMq4Pgon5SKoVVazsKOxrWrN2vHYiP8LlDKffrcTSoUEAC9JJkxhs5/AVMU5KVtvaCHx
	rOiZVzVnMPwbpVJBbc8fngLxcdN8L0fzY+FWZdQ7kCAWNB3xbKefWLIRYTI0Cu0taAVmFs
	nEspuak62/E57GC0WoqjwKcU8Ebo0Sff+vT6LkYBCbEMyI/PA+3ccJkHYZ6CpWGtTAWUaZ
	T44A6CCPazv6WQNJ8vK9ArOOJGBt8BPTyEN8hiOtQveDaXEtq1k3QFkm6SAXsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXfDhS4UHas27gO/oJlWHmFdlA0wZ7z1nOSxRihOwFI=;
	b=Uj5lGpwh/yuKmxHeLvEtsud0KKalHf8pqT2cubWnXmZL1UMU2lIGsE9V17j1ujHZTa4zIL
	G4f6dRFyp5evgZCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Remove retry loop from perf_mmap()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.463607258@infradead.org>
References: <20241104135519.463607258@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965013.10177.15241731066112284921.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6cbfc06a8590ab4db69f8af9431e816c859e2776
Gitweb:        https://git.kernel.org/tip/6cbfc06a8590ab4db69f8af9431e816c859e2776
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 20:25:57 +01:00

perf/core: Remove retry loop from perf_mmap()

AFAICT there is no actual benefit from the mutex drop on re-try. The
'worst' case scenario is that we instantly re-gain the mutex without
perf_mmap_close() getting it. So might as well make that the normal
case.

Reflow the code to make the ring buffer detach case naturally flow
into the no ring buffer case.

[ mingo: Forward ported it ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241104135519.463607258@infradead.org
---
 kernel/events/core.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4cd3494..ca4c124 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6719,28 +6719,33 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			return -EINVAL;
 
 		WARN_ON_ONCE(event->ctx->parent_ctx);
-again:
 		mutex_lock(&event->mmap_mutex);
+
 		if (event->rb) {
 			if (data_page_nr(event->rb) != nr_pages) {
 				ret = -EINVAL;
 				goto unlock;
 			}
 
-			if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
+			if (atomic_inc_not_zero(&event->rb->mmap_count)) {
 				/*
-				 * Raced against perf_mmap_close(); remove the
-				 * event and try again.
+				 * Success -- managed to mmap() the same buffer
+				 * multiple times.
 				 */
-				ring_buffer_attach(event, NULL);
-				mutex_unlock(&event->mmap_mutex);
-				goto again;
+				ret = 0;
+				/* We need the rb to map pages. */
+				rb = event->rb;
+				goto unlock;
 			}
 
-			/* We need the rb to map pages. */
-			rb = event->rb;
-			goto unlock;
+			/*
+			 * Raced against perf_mmap_close()'s
+			 * atomic_dec_and_mutex_lock() remove the
+			 * event and continue as if !event->rb
+			 */
+			ring_buffer_attach(event, NULL);
 		}
+
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already

