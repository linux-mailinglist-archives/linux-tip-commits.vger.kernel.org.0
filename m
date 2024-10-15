Return-Path: <linux-tip-commits+bounces-2427-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB4A99F183
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00781C21CED
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB94227B94;
	Tue, 15 Oct 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zM4CH8n2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N6J5Q7yJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C11D5175;
	Tue, 15 Oct 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006590; cv=none; b=kbGAuM/wWY1kBhslRQP/wIWf37UlHiNiR5RKhAlDPoBalZSZ9ljV0tDx81lbiEIKKXE3zpu5MB+RFNqB1U4wHX0lfe09V2mufEv3ukUQ3k2WKMpnGxwddco/tcF9NxhzxS92rS4zYHOmwiKtlrAjree7yp8+U65QZqVX/4X2ZfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006590; c=relaxed/simple;
	bh=DUlgHa/qz05TTo4HpE7oM/aQPxgN9MC5L2ezw7NyqVE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VJgsEmWtpTuJTqmv1MzErxX1ZnjV/V/LShS81ikBlV1aM/OfHFogjydV0Dt3+nS1gzHmB0wzPp0w9ZaovQyGMzvuL1nY4/o14g6jsrdIbpTBp1zDstOYpzoDrHtNagC8Cir63QiyDM+pv0dF8rGs+XQarszFpdBHq42bFGZ9648=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zM4CH8n2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N6J5Q7yJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jmIQslbXR6XmU6raEQDKmFc5oH/WDvo6aJ6l2vhrIM=;
	b=zM4CH8n2pdr9IbXyy3vtAjtTAN38AgvAM3pfJSRPI0xvVOCxaCJJcLAjCSn6v9Eq5jcb3R
	CTMH812JGRW2hAxel81pOQ4HD+mn0Iwsg6OSIOAisE4Pkd0Sas5NbgAQW+v3iPfYkk2RPF
	EZuMDyWVLKt1gp4nKMHV1sr01Z84v7kGyX3h84r+wEgC6TOMAfqj0xc54eCDtuhn+t5lvD
	z8w679Mzg6VoALAqxDWSjJ7EFeXCnKPRu+TlC6hdWI6HTPxypqSUmI5DaYvaATDa+T6O5O
	AU0ELGL6t01/sslc9pVT07zJ9yNONYpzrafjqr8n5ikhcf6HA1XNP2a3RPtEyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jmIQslbXR6XmU6raEQDKmFc5oH/WDvo6aJ6l2vhrIM=;
	b=N6J5Q7yJxCjhlXphZbohsxxtn4bqTrb1M14qrodvaVLT3clw15IgRy4QRp7lRpt0m8/aQ4
	vPuqb3ySVbN/6SDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/debugobjects] debugobjects: Provide and use free_object_list()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164913.453912357@linutronix.de>
References: <20241007164913.453912357@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900658514.1442.15213246812662825568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     49a5cb827d3d625944d48518acec4e4b9d61e1da
Gitweb:        https://git.kernel.org/tip/49a5cb827d3d625944d48518acec4e4b9d61e1da
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:31 +02:00

debugobjects: Provide and use free_object_list()

Move the loop to free a list of objects into a helper function so it can be
reused later.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241007164913.453912357@linutronix.de

---
 lib/debugobjects.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fc54115..6ccdfeb 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -125,6 +125,20 @@ static const char *obj_states[ODEBUG_STATE_MAX] = {
 	[ODEBUG_STATE_NOTAVAILABLE]	= "not available",
 };
 
+static void free_object_list(struct hlist_head *head)
+{
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
+	int cnt = 0;
+
+	hlist_for_each_entry_safe(obj, tmp, head, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+		cnt++;
+	}
+	debug_objects_freed += cnt;
+}
+
 static void fill_pool(void)
 {
 	gfp_t gfp = __GFP_HIGH | __GFP_NOWARN;
@@ -286,7 +300,6 @@ init_obj:
  */
 static void free_obj_work(struct work_struct *work)
 {
-	struct hlist_node *tmp;
 	struct debug_obj *obj;
 	unsigned long flags;
 	HLIST_HEAD(tofree);
@@ -323,15 +336,11 @@ free_objs:
 	 */
 	if (obj_nr_tofree) {
 		hlist_move_list(&obj_to_free, &tofree);
-		debug_objects_freed += obj_nr_tofree;
 		WRITE_ONCE(obj_nr_tofree, 0);
 	}
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
 
-	hlist_for_each_entry_safe(obj, tmp, &tofree, node) {
-		hlist_del(&obj->node);
-		kmem_cache_free(obj_cache, obj);
-	}
+	free_object_list(&tofree);
 }
 
 static void __free_object(struct debug_obj *obj)
@@ -1334,6 +1343,7 @@ static bool __init debug_objects_replace_static_objects(struct kmem_cache *cache
 	}
 	return true;
 free:
+	/* Can't use free_object_list() as the cache is not populated yet */
 	hlist_for_each_entry_safe(obj, tmp, &objects, node) {
 		hlist_del(&obj->node);
 		kmem_cache_free(cache, obj);

