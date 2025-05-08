Return-Path: <linux-tip-commits+bounces-5474-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C73AAF7F7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E813AA2B4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19862288D2;
	Thu,  8 May 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VVxSuhXM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swBDAZbq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB20225412;
	Thu,  8 May 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700437; cv=none; b=jWegDGr1wm+WfTU+sBUwhF5hoNXUQm60VA0SHl6xom8dUjgwIBChpBIEP4BcTr2IC4yPBp7y8Q15GyNvMEmg6sHnB5++pGygKMVvjDkCRE3rkQ54dJGFRd/9oM4a1m9q11A51Z8b1LNYHvBtVdKN2+U5k9tGdbJ8unrF/8SjpBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700437; c=relaxed/simple;
	bh=4Rrh6CJfdFIX5SacxF8FAratUo7JrQZR6Feov4yN9v4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eJ3sdqozfc92qVIIEeCfGXYlV3xpwmASkngN5o0b6i1KsoxO3G0DD7+YypWlj3LZvs8sOsmXdOUag8Psl+hvF0wi7TMgPn6RcHqCkbbu18e83kfaMn0DpjOx9J7EVTNHKBMVmaOHeR7K+OXgKJoGhBTSzyBaZ9feWJrNB/Vw+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VVxSuhXM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swBDAZbq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+dyh3tuLk/GLTxGWUozfE13xU/QyCv99QBYB21qT9o=;
	b=VVxSuhXMRimLCRGzyn5d3GXqf7ujv5ENxuuOC0VXsD0pj+EQH91ZukCqvo/KhFMt+DAPNO
	HHWaBrF7PxSEqdvwMfwFPGSEP0ISN6nr5dXNLV2A3jLsHX01LaA6/wBZmPxn6cNYnNIsjT
	4CtP31wAa0IzdRuV0MNgU8AgNOE1xrzONdgPTlbGiXso+UvIjBgobTx7t3j/hV3WCM/bR6
	4OhY1wGkdR7xPKm7pRAzwYHmheoo8u81ATYjS9j02CZeadR7CphQQt7iQZCxEFLMemrVK9
	lSYFM86+8MnlAPX14V6qjo37AwDwJnkU34t6kP0lr0fsFqolLvyHf+Kg3PPRBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+dyh3tuLk/GLTxGWUozfE13xU/QyCv99QBYB21qT9o=;
	b=swBDAZbqVcOP0zs71RjFgUPFlU+nLjYHtc5qfekXO4n0axY07yqJ8LUthMF3viNUmKAjiy
	og2ywaBl+mEsrTBQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] futex: Create helper function to initialize a hash slot
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-12-bigeasy@linutronix.de>
References: <20250416162921.513656-12-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043329.406.8420566167058219767.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     9a9bdfdd687395a3dc949d3ae3323494395a93d4
Gitweb:        https://git.kernel.org/tip/9a9bdfdd687395a3dc949d3ae3323494395a93d4
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:07 +02:00

futex: Create helper function to initialize a hash slot

Factor out the futex_hash_bucket initialisation into a helpr function.
The helper function will be used in a follow up patch implementing
process private hash buckets.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-12-bigeasy@linutronix.de
---
 kernel/futex/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1443a98..afc6678 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1160,6 +1160,13 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }
 
+static void futex_hash_bucket_init(struct futex_hash_bucket *fhb)
+{
+	atomic_set(&fhb->waiters, 0);
+	plist_head_init(&fhb->chain);
+	spin_lock_init(&fhb->lock);
+}
+
 static int __init futex_init(void)
 {
 	unsigned long hashsize, i;
@@ -1177,11 +1184,8 @@ static int __init futex_init(void)
 					       hashsize, hashsize);
 	hashsize = 1UL << futex_shift;
 
-	for (i = 0; i < hashsize; i++) {
-		atomic_set(&futex_queues[i].waiters, 0);
-		plist_head_init(&futex_queues[i].chain);
-		spin_lock_init(&futex_queues[i].lock);
-	}
+	for (i = 0; i < hashsize; i++)
+		futex_hash_bucket_init(&futex_queues[i]);
 
 	futex_hashmask = hashsize - 1;
 	return 0;

