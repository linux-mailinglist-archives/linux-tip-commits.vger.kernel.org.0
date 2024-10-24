Return-Path: <linux-tip-commits+bounces-2535-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7990C9AE0CA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 11:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7101F23334
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B61B6D18;
	Thu, 24 Oct 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3xhg7WMU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lqrE1DXK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03041B6D03;
	Thu, 24 Oct 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762145; cv=none; b=Kl1beueVWNE6rSMvjKAW5dhkaBZbwvbm2yQ9ni4dsZeK955qNB+GoUqa09XlwV/Px8WJeqRogJN+zM34neHqSJeEC87Oa8in+/Tt43ec4+metwgSwAJZqWuPKBrrG83p3sXGCFf7MLCkwGsnPfPMImobxncgTqG9VFnpuPUjB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762145; c=relaxed/simple;
	bh=6LLwMKEQXUk9GBzeogcSMrXtG6dBY+EeooUzkbS59lQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PXZMhLJKfiKumKHA4d23X3KMeZ8sGZCOXg/6ZW2O4iwrbRMfKznvPVtApvTxlI1wpWTL8z4f1m41FtSMJInha9jnkZu4b25HrW6HPYXFEthwbf7Q1Q3c7cm5tI2z+/O1YcDjEGfCVWFpgxjzQ+KOD+7KZSOXelT+gwU3qsnFzY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3xhg7WMU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lqrE1DXK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Oct 2024 09:29:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729762141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NhrCmJObgMxysv3N6jTdVp+yl3UFq7Cg/1kaDD3exw=;
	b=3xhg7WMUfDj3lC1oYQfABpP1Fi9ay1uIfQmqMJ4gsxc4jONfRWGPzaRKSwVQPQNA/bzvTG
	MJkEutj83ja/KROEmHuV5u2x7N9iKZXy7+M4uA7cyrLMY+UlXlyicqommU/LDrajuN4xJE
	8HYVNpo85itHXQPVfB3k2t69Xe8/osirgLPA7AnEk+aFUSd8HIlTzSdD0wXKjZk7XIV7Zg
	uT4MZNKNyOlrNcq4zdOugvfeax6vqFwEat2WMaW/457/hnfQkWaFIrdAHT9EpPBJ9gTFez
	hbZJI9qCHaX/XMvp7eYdYtvM0CajfGEAmgyhEPttPblzqob3OUlORqPI62LedQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729762141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NhrCmJObgMxysv3N6jTdVp+yl3UFq7Cg/1kaDD3exw=;
	b=lqrE1DXKA9j0OkVdn4Own6mfy3TOM0PZK50xoKQ+U7ROIrAgLaHKjBp9qGygZB/1m+/7D5
	3588DRxgYQjjpGBw==
From: "tip-bot2 for Julia Lawall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Replace call_rcu() by kfree_rcu()
 for simple kmem_cache_free() callback
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Thomas Gleixner <tglx@linutronix.de>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241013201704.49576-12-Julia.Lawall@inria.fr>
References: <20241013201704.49576-12-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172976214021.1442.3589271792962891221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     2e529e637cef39057d9cf199a1ecb915d97ffcd9
Gitweb:        https://git.kernel.org/tip/2e529e637cef39057d9cf199a1ecb915d97ffcd9
Author:        Julia Lawall <Julia.Lawall@inria.fr>
AuthorDate:    Sun, 13 Oct 2024 22:16:58 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Oct 2024 11:22:54 +02:00

posix-timers: Replace call_rcu() by kfree_rcu() for simple kmem_cache_free() callback

Since SLOB was removed and since commit 6c6c47b063b5 ("mm, slab: call
kvfree_rcu_barrier() from kmem_cache_destroy()"), it is not longer
necessary to use call_rcu() when the callback only performs
kmem_cache_free(). Use kfree_rcu() directly.

The changes were made using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Link: https://lore.kernel.org/all/20241013201704.49576-12-Julia.Lawall@inria.fr
---
 kernel/time/posix-timers.c |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4576aae..fc40dac 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -413,18 +413,11 @@ static struct k_itimer * alloc_posix_timer(void)
 	return tmr;
 }
 
-static void k_itimer_rcu_free(struct rcu_head *head)
-{
-	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
-
-	kmem_cache_free(posix_timers_cache, tmr);
-}
-
 static void posix_timer_free(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->rcu, k_itimer_rcu_free);
+	kfree_rcu(tmr, rcu);
 }
 
 static void posix_timer_unhash_and_free(struct k_itimer *tmr)

