Return-Path: <linux-tip-commits+bounces-2426-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302EB99F182
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96BA1F266ED
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7738227B80;
	Tue, 15 Oct 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3TX8JqV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UeweWVXi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB951FAF19;
	Tue, 15 Oct 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006589; cv=none; b=cfiInL7iW4nQSH76Ca9DK1xXvqu/U5TQkXWkzmVh0bwmsvROCw9IpzrC/K7eDrsON15YCYcgsLZwKDNvn/U/JLwSBJGx0f19GOAjhi3sfkO58pGxAb6oC+2DzP6zNNGhDVFxbKpjXR3FqwLgjGPitOVLWJLquTeiuZolDjNvRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006589; c=relaxed/simple;
	bh=5CwtC8RZSb6xBotN1V8Oe8lvP8YXu3or4ybgvV7yt8E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T4/HaMi5a1rsapOBsyCz5RlNYkjDunhZAOSLVEGfBmgEnlNqeHUc22IN35fmlAfyDAnAKoj8XjCjRyxGnZ+vhFajoOw26eiesj9lmQvyOcghLXZBJc1qHCiyth/EFFrkDWzFE4VP2JHgAY3pE+r+/2JeOSmY0whxStghJWUbClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3TX8JqV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UeweWVXi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VEqWivMD6scraqwegD0BkASRLlidtXe+8/echmtgU8=;
	b=Q3TX8JqVx96TWB8i3u4h3caLKXvo5mfJNoRO4izmx7iXQwQl9zKhacIPMyJbazcV1SwDHT
	6bMhcb7x2145MEBsRoTdT2Rg7ahMCbBCKs3lirnQYJghHLkYDTxkcTK89L2JiTnh/+GlBb
	EDK/U2eS7d6zn3eD8DIZuNE71VKo4eKf0vlDZxP00EdQYyl5EluvztF0rEaL5cH7WE66YY
	nErUOOdQ9Trh8nvDIoT6EE+v2DBy2HQjNISCSzMEtwUJjW+W9v4GHSHca+OpDDawHC7rm6
	vRBXXLLLzRMcoPE0Kz0VddQwkAWBLoUoHC61QNes/MvvGT2jXpeAqaQYVbRu1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7VEqWivMD6scraqwegD0BkASRLlidtXe+8/echmtgU8=;
	b=UeweWVXiIh52Rs0NDh6lgbfsT3gx4tSB8lGNOWguNb7+RGJ2uf2n4f1gBp7e4xtX1veQEw
	a2jBLMSonMkyNPDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Remove pointless debug printk
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.390511021@linutronix.de>
References: <20241007164913.390511021@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658571.1442.2088504399428158571.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     241463f4fdcc845fa4a174e63a23940305cb6691
Gitweb:        https://git.kernel.org/tip/241463f4fdcc845fa4a174e63a23940305cb6691
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:49:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:31 +02:00

debugobjects: Remove pointless debug printk

It has zero value.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164913.390511021@linutronix.de

---
 lib/debugobjects.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 2c866d0..fc54115 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1303,7 +1303,7 @@ static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache
 	struct debug_obj *obj, *new;
 	struct hlist_node *tmp;
 	HLIST_HEAD(objects);
-	int i, cnt = 0;
+	int i;
 
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++) {
 		obj = kmem_cache_zalloc(cache, GFP_KERNEL);
@@ -1330,11 +1330,8 @@ static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache
 			/* copy object data */
 			*new = *obj;
 			hlist_add_head(&new->node, &db->list);
-			cnt++;
 		}
 	}
-
-	pr_debug("%d of %d active objects replaced\n", cnt, obj_pool_used);
 	return true;
 free:
 	hlist_for_each_entry_safe(obj, tmp, &objects, node) {

