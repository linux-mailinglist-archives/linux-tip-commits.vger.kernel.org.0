Return-Path: <linux-tip-commits+bounces-3862-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB78A4D744
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29852189BDDC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7921FCFF5;
	Tue,  4 Mar 2025 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tbAtU9Ne";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwVBIsco"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB21FCF5B;
	Tue,  4 Mar 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078623; cv=none; b=B5Dcn3loDUR62jYk4F6LYpIcgUHvTqpkzv5ue0h/BR0nnAfAYM4i2m7OpD2o7nCPNNqmkZ9rTgDEkHFHBLvzLPxeC5XRQeAHHDghcMV9hF+eP7f9s/Eh4jn44QHTP4Qh6Qp5hz7W+uuUuE7gXzxtTVIOYUpnvO2DifSHwlGucZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078623; c=relaxed/simple;
	bh=XHZ2aRFVvYNQUUK0G2letHjPFyIZKZGlOfx4rEiKPVk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OTmda+VIjfitCLFLevDoW8z0Ugh9QKXf654SBIcVxuDFyf5UmXUHGsM710fmrEWFsglguz3PEVxclW+LTUbgAe9qkdnHhzqOM0NvJFwWz1lruJAOiK3of4aAlONtQ5UrQeha5cdvXZ4tvPAMWK4vzlds2WEuWbtjCmIu0CkuNfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tbAtU9Ne; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwVBIsco; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:56:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+XVGs1eCfoMKgOOQc6UEoUjR7kBhVkIFMC6iDPfrDE=;
	b=tbAtU9NeMhNLOglQg8NZ1E4ybXoWGVSBXr5Qkjy2xyGGuqTLWdBPGymHzGYsGNS4td+7Cx
	MyUH7YB9lJSb9a1YwZ4f2aszYZ71T1lhXD3csYoa5vdNr6G2GMiJcKc3W3sMQZv4t8XQGd
	EZ3mseufO68G3RcGgl+gv5ITGHjjsyjVd/vAI/uTKClTGX9+CtLagdCyn8pDfL7KT3PCZF
	tNGfltALshiT0vEllAx2m4Yi0YrAC7LR2ZGiTzR6t4EwQxRNZjGzVunT4mDsai7TEr/xTc
	pBoCilT4jBrEFo40wv/UoY0cJVY+MFLWhQGzT19C1UtGj6A6CeP6rjuvh9Mj/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+XVGs1eCfoMKgOOQc6UEoUjR7kBhVkIFMC6iDPfrDE=;
	b=AwVBIscoeDjci7Pw5QxwX3+FaE7DYjxglZ/LRHHXSf/fRG7GwRm7SU83Uswv3/quyeXvfg
	IG9Z21O1a9Xr4ZCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Remove retry loop from perf_mmap()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.463607258@infradead.org>
References: <20241104135519.463607258@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107861938.14745.9528941861018615208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8eaec7bb723c9a0addfc0457e2f28e41735607af
Gitweb:        https://git.kernel.org/tip/8eaec7bb723c9a0addfc0457e2f28e41735607af
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:43:15 +01:00

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
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
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

