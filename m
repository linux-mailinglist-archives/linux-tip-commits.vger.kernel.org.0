Return-Path: <linux-tip-commits+bounces-2409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A199F160
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B9B280F6B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270F91B395B;
	Tue, 15 Oct 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAsWLDlQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAw64Lb2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8133BBF6;
	Tue, 15 Oct 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006579; cv=none; b=kccxGrUWO911XxnpSBrMJxw+k2RZ+CFqRjmNKcVoaag/C5+/Lb648kt7RkjmyJoxJ3rmTOtXdcKL34+0YaqQ7oz5/OalTLadFfOhLL0xkUgWxxQH3YuOCq8jdnuoCn9MidSvqMuusv+KgOEfxDEKkUHl/1ofF47UCrGNv/l2y7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006579; c=relaxed/simple;
	bh=AvAFHB0x8cQ9jNlbfBJyyV4v3sNH1zSNrBuVox+lPK4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k6utJYpOEwj50vjFM0IxZdetOW3mfpvj8svs8Xjf024gq7ZFqHCPKmjd9KY/46fa7QpTv0lWa6i6qOkFqnkVYzziD5b+E7vOl4odSvYS5HTCT9ueILNjB3ia18z3tH4R4RRlCYMdfjL5aSbhNSULmIaiLhywl3po2ZnbISx+Cbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TAsWLDlQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAw64Lb2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzBW9/QMg3vRdQ72dLktfRRQQ7t2GkS7TD/qKmfp10=;
	b=TAsWLDlQH/TywGPMYOAYrFDEtItvjEyIma64Pn2bI2s6v4XORFV5b6GkcsZpaZnvBfW6j2
	B89c5Ze6544T+lQJSVxt7R6en9g0w8jATePArKypDNgLBs8yFS7HyinOBeALclY094x8pC
	pZFbO1Cx7UOqnTNvl7e4Q4XliscTWjxmrIY8E0eZnboIMrRpd/cvOnaJsuU7VSCTvaPIt6
	YMvwttxOoZCBan6B9oJmsoyMAS8m+c3Y4+CzWhbNl+eUbLlIN+2k7rMn/Mr1aTSxQ4PGFw
	axi+jmONd3iOYebc0HDmrFKYV6JgzCUmADnXDtkwYrL+2EaaYV+vlvuMR9vLNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrzBW9/QMg3vRdQ72dLktfRRQQ7t2GkS7TD/qKmfp10=;
	b=SAw64Lb23yV8mkE5u5sk9aFlLhN65ak/FVnTrAlCiN+cRs/FUY0vboG9QRl4EjtpLvoig0
	wAtvEsgzxw69m/Cg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Refill per CPU pool more agressively
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164914.439053085@linutronix.de>
References: <20241007164914.439053085@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657540.1442.1413028648085092088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     13f9ca723900ae3ae8e0a1e76ba86e7786e60645
Gitweb:        https://git.kernel.org/tip/13f9ca723900ae3ae8e0a1e76ba86e7786e60645
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:33 +02:00

debugobjects: Refill per CPU pool more agressively

Right now the per CPU pools are only refilled when they become
empty. That's suboptimal especially when there are still non-freed objects
in the to free list.

Check whether an allocation from the per CPU pool emptied a batch and try
to allocate from the free pool if that still has objects available.

   	    kmem_cache_alloc()	kmem_cache_free()
Baseline:   295k		245k
Refill:	    225k		173k

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164914.439053085@linutronix.de

---
 lib/debugobjects.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fc9397d..cc32844 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -255,6 +255,24 @@ static struct debug_obj *pcpu_alloc(void)
 
 		if (likely(obj)) {
 			pcp->cnt--;
+			/*
+			 * If this emptied a batch try to refill from the
+			 * free pool. Don't do that if this was the top-most
+			 * batch as pcpu_free() expects the per CPU pool
+			 * to be less than ODEBUG_POOL_PERCPU_SIZE.
+			 */
+			if (unlikely(pcp->cnt < (ODEBUG_POOL_PERCPU_SIZE - ODEBUG_BATCH_SIZE) &&
+				     !(pcp->cnt % ODEBUG_BATCH_SIZE))) {
+				/*
+				 * Don't try to allocate from the regular pool here
+				 * to not exhaust it prematurely.
+				 */
+				if (pool_count(&pool_to_free)) {
+					guard(raw_spinlock)(&pool_lock);
+					pool_move_batch(pcp, &pool_to_free);
+					pcpu_refill_stats();
+				}
+			}
 			return obj;
 		}
 

