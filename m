Return-Path: <linux-tip-commits+bounces-3605-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B80DA40F7D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Feb 2025 16:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AC23B7BE0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Feb 2025 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2320766A;
	Sun, 23 Feb 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1bisBn+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fw1OHCpV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672FE206F22;
	Sun, 23 Feb 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325201; cv=none; b=XHtbcNb3CE3Xw8G1JfgDah1BqKa0mlc3CjBB6tjTd5KHc2E1cZihOqNjexccevgMfTRAZBjXwhKcEtya9KtsN1zlbsokZuPhh2Z9uw8cgadNkE1sIiuULYC9jLH8rgabwLxXxxhdQcLJNt4izEMf5oXpHnCHj63u2v+j+nOEgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325201; c=relaxed/simple;
	bh=o1KAnzyr/r8zygz0CfuqfjBWWpnHmJ+6FyBZSYP5l8k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qQrb3roiuAu86JZF/ipOQWhGc2J81d1O77qFSBOYQGlADKp55rCteKuRzDD3zrEdyvOvmAlZROTzCrHjqsZk1E0eQ6a2nVrk1DiM5haC95xHv+jfM78bNbXMrAILblZqTSVSkORG26qaOhoSmjkReFBndnl1+jIOYwi93q2eKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1bisBn+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fw1OHCpV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Feb 2025 15:39:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740325190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95z+XIIsekQNPOf30IF1xYSNUZIumS/XKig5mUGkkak=;
	b=O1bisBn+3u821WYHGp5O5Xuh2ItDL14qtav2GgabY7pnJrwLsQ6bMLDWO2X42dq21vlFI0
	i5/bq7WWwpeL03cF5LmlA5EMCkZtbwQKcE+NTxgreTP4ucNSzrKaeXshmtchma4wG+YnHv
	9ZmP6djyLmrngHuzdHN3z3j9XN3BavAbAH4nujYmEBo491PvXKYNrpo73YMzwdRjmwktze
	kO4LV/8i92UZ2LklY0upU+Xqkxd5bAcjcl0z74mZAcAeCedTzpwtd/7+4Qatvrb2B/S/jv
	y2ICio63zPUE/Eexhva/+7xFvb3PUacajnFpTHHZGu5CGXeVPH0ZNyzoOLU+Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740325190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=95z+XIIsekQNPOf30IF1xYSNUZIumS/XKig5mUGkkak=;
	b=fw1OHCpVz332UiCuD55Qucmj16JJEGD9/mhB3w/4seRagrgTjnj1CDsfnpkzyDzOZZg/H8
	LD4kc/w0OSsC01BA==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/usercopy: Fix kernel-doc func param name in
 clean_cache_range()'s description
Cc: Randy Dunlap <rdunlap@infradead.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250111063333.911084-1-rdunlap@infradead.org>
References: <20250111063333.911084-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174032518667.10177.8688571407789662677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     51184c3c96a19b5143710ef91426e311f4364bac
Gitweb:        https://git.kernel.org/tip/51184c3c96a19b5143710ef91426e311f4364bac
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 10 Jan 2025 22:33:33 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 23 Feb 2025 11:52:48 +01:00

x86/usercopy: Fix kernel-doc func param name in clean_cache_range()'s description

Use @addr instead of @vaddr in the kernel-doc comment for
clean_cache_range() to eliminate warnings:

  arch/x86/lib/usercopy_64.c:29: warning: Function parameter or struct member 'addr' not described in 'clean_cache_range'
  arch/x86/lib/usercopy_64.c:29: warning: Excess function parameter 'vaddr' description in 'clean_cache_range'

Fixes: 0aed55af8834 ("x86, uaccess: introduce copy_from_iter_flushcache for pmem / cache-bypass operations")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250111063333.911084-1-rdunlap@infradead.org
---
 arch/x86/lib/usercopy_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
index e9251b8..654280a 100644
--- a/arch/x86/lib/usercopy_64.c
+++ b/arch/x86/lib/usercopy_64.c
@@ -18,7 +18,7 @@
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 /**
  * clean_cache_range - write back a cache range with CLWB
- * @vaddr:	virtual start address
+ * @addr:	virtual start address
  * @size:	number of bytes to write back
  *
  * Write back a cache range using the CLWB (cache line write back)

