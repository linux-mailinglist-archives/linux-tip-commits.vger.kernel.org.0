Return-Path: <linux-tip-commits+bounces-2432-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D0799F18D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86EB1F277E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46D2296D8;
	Tue, 15 Oct 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBCNYsw+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jfsbJHFG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B9B229100;
	Tue, 15 Oct 2024 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006593; cv=none; b=KgB5NCdEGGs5gMwDmTQ+zQDpbjl30c6PONI7eSq1pwfdSLTFkPpqlnUTJyWux8K696vxZcNLw/fEVo8txVs7Kjm2x/Pr0dZZl8+yJ9yoEhMvCzXFU0Awue/la+2Alygx0/ZFWgm8pInV4lCFEu+ZIh5C3Q9/da0i9Dxs0UF2Vkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006593; c=relaxed/simple;
	bh=5ilWmU6QGdb8pRlzBmOiK47lXmrgVX2dWENCr3pKsJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B8MWrq88jQY2eQsESYF2roacG83uU7gMonlaCk3LuBf4dSRM8l1fmSf8PweU/fo2smhrgaVrAqHtcdb6MFnp6i0Q1mqlbNIc4LB81rjBwYNtKKBXBPECbGqgxiIspGpWYt0i3YmXym9SdX9nuu0nVh8F2ZA2l6ji1ZHhymyUMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBCNYsw+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jfsbJHFG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/PYTNEWDCKXaCITJ617xOz1vePm6ZFdOuDT7rcxk2U=;
	b=GBCNYsw+udKvQBELuBRBRaO20pRCnnjb40c9SvN9xME8Qs6Q2mXqVSX2m0LPvkgY/MpWS1
	MOUyn//hxuGEpzmwL4EPMscTcwWNeI4PnhaKwQMiBeLxq0qLlnJpTmw2V0762eD6yMh+D2
	HZFlOR7v4Vra5wuELCaoVaX+6Yl/PMuWAbCEGtg5YdAJ/hOhi7TcV+ab/oRLAksncorFdz
	w2QjYXVE1jxjYZhGUzNIjLI6kyWleVoU44tvMpa1rcVlY1aaYhHSOYyg1LiOju8zBnELAK
	NukJeRbhAraI4aHcA0fFwRr+wUiSdoJ7BlCntFRkmRy3tnWhx3hkBOpNjWqCiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/PYTNEWDCKXaCITJ617xOz1vePm6ZFdOuDT7rcxk2U=;
	b=jfsbJHFGPDX/hyY6p3ueNsvmIp9P5Nx+ewgCX1GascAje+c7RXY7iwBjUlwBE+vGiJtIWL
	kpQI352sjtzZiJBg==
From: "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Collect newly allocated
 objects in a list to reduce lock contention
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240911083521.2257-3-thunder.leizhen@huawei.com>
References: <20240911083521.2257-3-thunder.leizhen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658871.1442.11609364192319845357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     813fd07858cfb410bc9574c05b7922185f65989b
Gitweb:        https://git.kernel.org/tip/813fd07858cfb410bc9574c05b7922185f65989b
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Mon, 07 Oct 2024 18:49:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:30 +02:00

debugobjects: Collect newly allocated objects in a list to reduce lock contention

Collect the newly allocated debug objects in a list outside the lock, so
that the lock held time and the potential lock contention is reduced.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240911083521.2257-3-thunder.leizhen@huawei.com
Link: https://lore.kernel.org/all/20241007164913.073653668@linutronix.de


---
 lib/debugobjects.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index df48acc..798ce5a 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -161,23 +161,25 @@ static void fill_pool(void)
 		return;
 
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
-		struct debug_obj *new[ODEBUG_BATCH_SIZE];
+		struct debug_obj *new, *last = NULL;
+		HLIST_HEAD(head);
 		int cnt;
 
 		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
-			if (!new[cnt])
+			new = kmem_cache_zalloc(obj_cache, gfp);
+			if (!new)
 				break;
+			hlist_add_head(&new->node, &head);
+			if (!last)
+				last = new;
 		}
 		if (!cnt)
 			return;
 
 		raw_spin_lock_irqsave(&pool_lock, flags);
-		while (cnt) {
-			hlist_add_head(&new[--cnt]->node, &obj_pool);
-			debug_objects_allocated++;
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
+		hlist_splice_init(&head, &last->node, &obj_pool);
+		debug_objects_allocated += cnt;
+		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 }

