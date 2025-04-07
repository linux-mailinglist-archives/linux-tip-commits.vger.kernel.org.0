Return-Path: <linux-tip-commits+bounces-4739-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E09A7E26B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30EC1898B73
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B735B1FDA9D;
	Mon,  7 Apr 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K5Qa+7Lo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MqD8IM9q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98C1FCFF9;
	Mon,  7 Apr 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036316; cv=none; b=H8USt83SN7NktxsB/dXqhLhCKKvSf7pZgQ/wMJ0x9ZS+DrzVYg6VDr3F6QNaltR8x67HCQy9HN2cEP+698UXusURsPuAU/mQrLn/h6Jf/t/kD18BnRAFvI2OPUFDFOyT5PpShr5oaTIP/ITaElhgsA2hQhqyszDNPOwvVcixeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036316; c=relaxed/simple;
	bh=IcmNTyRF7mNxqxfZGrer4fub6LBqC+AYcewV7jJwrto=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NnjI2a6VUC9rZ2UrRCzAdhROHyqvTGggDqG5YRe6LHmIEAOc3EVlo3Zs/Gg748pHBYOfGkSrs/OYRDuV8h0f1vfM01hS85WsjNEJgxfaSapQhv8rIqxilGU/rmDUFKFN6jzQ7PQgjmvWpM39PyEpTu67CWY0O+RcBuG24UHuHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K5Qa+7Lo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MqD8IM9q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036313;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdAx4MYyWqMyN7iu/s3wQCafefi3Xdhsp+l8pHQpqHM=;
	b=K5Qa+7LokglyzCZtyEpW9PxfmR/vEchStazcsqTrB22M0vmL7EOSUfZoFkfxw5uxg2o6LW
	ANCeliQFy7cZq8wuK6yDIoh1SRY5UV228Kjf7USgyfisCF+EEWS4FwH5pgYKoaS4R/Wh0w
	Mzcv5UeMBCFrQ2lREhs3EP3EUglydzfI706ewGNBemNX7r3uj6p77pPwNttGPJjK8Pqet4
	jgPkGbu5rpRDatFcRX791vnN2fOBlSfq5UjzkJTgYJ+3G5LfISE5b8DOD8Vzpc+Zpai2Ry
	V88Dm9414Ri2D7mbhbEk1rCyEOWTXeY+ZlxK1tf/ajKylaK1vjF8cc40Y0XosA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036313;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdAx4MYyWqMyN7iu/s3wQCafefi3Xdhsp+l8pHQpqHM=;
	b=MqD8IM9qZQR+wiOnyugggiCZGke4NdFT9pFJ9uy5kvIEpW1QGyu/W0cIKARcHnlMk9oouO
	5/0gh9Di/vJcO7Dg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] cleanup: Provide retain_ptr()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.083538907@linutronix.de>
References: <20250319105506.083538907@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403631219.31282.15932130919927326104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     47d482d3dd6e9469f650b34667c4f0faf9f268d0
Gitweb:        https://git.kernel.org/tip/47d482d3dd6e9469f650b34667c4f0faf9f268d0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:55 +02:00

cleanup: Provide retain_ptr()

In cases where an allocation is consumed by another function, the
allocation needs to be retained on success or freed on failure. The code
pattern is usually:

	struct foo *f = kzalloc(sizeof(*f), GFP_KERNEL);
	struct bar *b;

	,,,
	// Initialize f
	...
	if (ret)
		goto free;
        ...
	bar = bar_create(f);
	if (!bar) {
		ret = -ENOMEM;
	   	goto free;
	}
	...
	return 0;
free:
	kfree(f);
	return ret;

This prevents using __free(kfree) on @f because there is no canonical way
to tell the cleanup code that the allocation should not be freed.

Abusing no_free_ptr() by force ignoring the return value is not really a
sensible option either.

Provide an explicit macro retain_ptr(), which NULLs the cleanup
pointer. That makes it easy to analyze and reason about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Link: https://lore.kernel.org/all/20250319105506.083538907@linutronix.de

---
 include/linux/cleanup.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7e57047..be4a53a 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -216,6 +216,22 @@ const volatile void * __must_check_fn(const volatile void *val)
 
 #define return_ptr(p)	return no_free_ptr(p)
 
+/*
+ * Only for situations where an allocation is handed in to another function
+ * and consumed by that function on success.
+ *
+ *	struct foo *f __free(kfree) = kzalloc(sizeof(*f), GFP_KERNEL);
+ *
+ *	setup(f);
+ *	if (some_condition)
+ *		return -EINVAL;
+ *	....
+ *	ret = bar(f);
+ *	if (!ret)
+ *		retain_ptr(f);
+ *	return ret;
+ */
+#define retain_ptr(p)		((void)__get_and_null(p, NULL))
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):

