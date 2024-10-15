Return-Path: <linux-tip-commits+bounces-2413-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7699F168
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82591F245AA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6B1F6671;
	Tue, 15 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dr7JQ+yR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZIRcZF2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2081DD0FF;
	Tue, 15 Oct 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006582; cv=none; b=TVd3WAvtkOTqiBF5wOl3esxpnF8w2SGQykUClaUSV7doxk1VeCmpzH3i+1eNjaZBNhwNzuXsJg4xPrwAs/Anl34Y+pscJpllYty2hgvAv6ZDPZYdawCcs7pyXjeHy//61rnDze725SRRfUCUBxS9QRQdzm5XBeRthuNkzwCPfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006582; c=relaxed/simple;
	bh=MwrQTQJiDVuTov9rG29tvk973EHbkoWlxkA596/nl0Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SE6uRs5VCY7D1Q0JAnWsSWH+Hbzu4r+IwVBBBNrzusQ5gma+Xga3Fxir25atZQXRHjKUI1M2570fTn4cKfJCN1hx3WELSSVmBJFiI1n2P9SpN0kg4kX3y0rTO3buc2J3ohkGZ33SUqxT2wSr2l5xe9a2Trzk6Mv533GZvnbB7es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dr7JQ+yR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZIRcZF2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Oct 2024 15:36:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGii3Fox/QspOdS4WzLturssJ7cKe2tOuh5fBOCCCgM=;
	b=dr7JQ+yRhIvjfgM6I/OEB9z5oOyI78NK/9/QiGcVr2npoZLW61VQF/89nYy17cbpGHP6C1
	cJUeT5GOiF8jJkeT+py8Vwa3QkRK+FmZXvz0FN4EQ1REZb0ImdfxlMD5gEfanNYpU2Jsg6
	Bwc+R+sl77EBWedjyZu78GcsQwEiLWiPVqcP2nGb/PRlS1jktW0CdQqsRjB1yOrQcxBv9m
	rCZKajbNin6xhXZlNw5O11H5LqXq1lWSUCOGJRea6dgGCBXNmz+8GFRvvzkau1K8tGtbot
	GiPovq5oirvLy3UeL7DC7QDd6gOf+nq8yP5ih/uT9mW6ScxpUrlALC2A9uIf4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGii3Fox/QspOdS4WzLturssJ7cKe2tOuh5fBOCCCgM=;
	b=OZIRcZF2YDq9Q5O2x5ToOcPA2RIPCuo3OYvNxWqG7Kxbg6kOyL28cGirFbTnDzODCOlaga
	BYeD0rJGc5ekglDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Prepare for batching
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Zhen Lei <thunder.leizhen@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241007164914.139204961@linutronix.de>
References: <20241007164914.139204961@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172900657834.1442.1085292605110155401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     74fe1ad4132234f04fcc75e16600449496a67b5b
Gitweb:        https://git.kernel.org/tip/74fe1ad4132234f04fcc75e16600449496a67b5b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 07 Oct 2024 18:50:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 15 Oct 2024 17:30:32 +02:00

debugobjects: Prepare for batching

Move the debug_obj::object pointer into a union and add a pointer to the
last node in a batch. That allows to implement batch processing efficiently
by utilizing the stack property of hlist:

When the first object of a batch is added to the list, then the batch
pointer is set to the hlist node of the object itself. Any subsequent add
retrieves the pointer to the last node from the first object in the list
and uses that for storing the last node pointer in the newly added object.

Add the pointer to the data structure and ensure that all relevant pool
sizes are strictly batch sized. The actual batching implementation follows
in subsequent changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
Link: https://lore.kernel.org/all/20241007164914.139204961@linutronix.de

---
 include/linux/debugobjects.h | 12 ++++++++----
 lib/debugobjects.c           | 10 +++++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index 3244468..8b95545 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -23,13 +23,17 @@ struct debug_obj_descr;
  * @state:	tracked object state
  * @astate:	current active state
  * @object:	pointer to the real object
+ * @batch_last:	pointer to the last hlist node in a batch
  * @descr:	pointer to an object type specific debug description structure
  */
 struct debug_obj {
-	struct hlist_node	node;
-	enum debug_obj_state	state;
-	unsigned int		astate;
-	void			*object;
+	struct hlist_node		node;
+	enum debug_obj_state		state;
+	unsigned int			astate;
+	union {
+		void			*object;
+		struct hlist_node	*batch_last;
+	};
 	const struct debug_obj_descr *descr;
 };
 
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 65cce4c..2fed7b8 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -21,11 +21,15 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
-#define ODEBUG_POOL_SIZE	1024
-#define ODEBUG_POOL_MIN_LEVEL	256
-#define ODEBUG_POOL_PERCPU_SIZE	64
+/* Must be power of two */
 #define ODEBUG_BATCH_SIZE	16
 
+/* Initial values. Must all be a multiple of batch size */
+#define ODEBUG_POOL_SIZE	(64 * ODEBUG_BATCH_SIZE)
+#define ODEBUG_POOL_MIN_LEVEL	(ODEBUG_POOL_SIZE / 4)
+
+#define ODEBUG_POOL_PERCPU_SIZE	(4 * ODEBUG_BATCH_SIZE)
+
 #define ODEBUG_CHUNK_SHIFT	PAGE_SHIFT
 #define ODEBUG_CHUNK_SIZE	(1 << ODEBUG_CHUNK_SHIFT)
 #define ODEBUG_CHUNK_MASK	(~(ODEBUG_CHUNK_SIZE - 1))

