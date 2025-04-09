Return-Path: <linux-tip-commits+bounces-4810-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89D4A82FE7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1474E3AA610
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4127F4EB;
	Wed,  9 Apr 2025 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mbJ6csNg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hdIy9kOk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C58F27EC83;
	Wed,  9 Apr 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224879; cv=none; b=ubmN7PcaxPB8k9n2KwDHNgObgDR/LsYntHehLnKEoIlKcGm8nAyg6PNvJ38uAxq2tS7S5d8ItR5CVUf3ngoVk2yEONRv08KiZ6Vr+kwWtC4Qk2/Wu8DQzqm4ojm2z4+g6yJT6+kci6fPe1nObOkABvy+F5te3qwbjo8GUp0XPVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224879; c=relaxed/simple;
	bh=eQEKVexFfG8ek2OmOayQUPn3wLiqrIrZ7iiVGXWK/6M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DHO8aUJwH9+XWSyJ4zVDp/qUTzPlMiiZJSQUR3OIK4LwaHrybSaew0PJtS/rHwp+Lnp/ZHdxKOYe9xkrReuDtnbyRCDco8ZaXNhmy0pQgcauUgL3MdMkBK+PqFeyaEENqi9jbs+cPLWQfTv+4YjWUH7UxC+yntyKCGtTrkKcRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mbJ6csNg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hdIy9kOk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz7ivblj/Lrsf8vbe3gC8wAAfIMffu53UBl3x/KFAOY=;
	b=mbJ6csNgLnBTXcD6xmW2sF+dapD/F2pyf1V29DsGJyiQV+81ih4tYEm1Del+OMYuhb5yul
	qAbhZlpbuNixCnZdHVtHwx2tsdRjxXwbsg0+3OaozDt9EWPr8orT2tNsop5JE4OeFbMhXK
	vDJ888O0M6BIh1gUSoHU161q2YY7uIcT7r+5wqUulWGDOfMC0i2EGmU6mDMdEl4CuxO53o
	OIUNkmwE4+DyUDcasEj4nlYsQ6k/65OM+6xkg0gqGcBn4LxlYWTI2RxU4HrBq5P435IL8y
	bJ8orD2UAGTGTjTj0fJHd99FVIl5m3jZMdiGY9qeaw1bl2yErh2jZIw710jUSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rz7ivblj/Lrsf8vbe3gC8wAAfIMffu53UBl3x/KFAOY=;
	b=hdIy9kOkJoRSfbZITncsdSQOa6rYupxfTU4MbBxMItPntu3wELr0Ym8DS5Ru9RoWrbxlo0
	igTQv5Stf/tr8mCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] cleanup: Provide retain_and_null_ptr()
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
Message-ID: <174422487538.31282.2072241182708817750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     092d00ead733563f6d278295e0b5c5f97558b726
Gitweb:        https://git.kernel.org/tip/092d00ead733563f6d278295e0b5c5f97558b726
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:29 +02:00

cleanup: Provide retain_and_null_ptr()

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

Provide an explicit macro retain_and_null_ptr(), which NULLs the cleanup
pointer. That makes it easy to analyze and reason about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Link: https://lore.kernel.org/all/20250319105506.083538907@linutronix.de
---
 include/linux/cleanup.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 7e57047..7093e1d 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -216,6 +216,25 @@ const volatile void * __must_check_fn(const volatile void *val)
 
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
+ *		retain_and_null_ptr(f);
+ *	return ret;
+ *
+ * After retain_and_null_ptr(f) the variable f is NULL and cannot be
+ * dereferenced anymore.
+ */
+#define retain_and_null_ptr(p)		((void)__get_and_null(p, NULL))
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):

