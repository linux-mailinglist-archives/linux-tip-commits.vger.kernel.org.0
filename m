Return-Path: <linux-tip-commits+bounces-5658-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E73ABA96F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A083189FACE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73B9210F65;
	Sat, 17 May 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4MpBxqD7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zyDr3CgR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC2920DD42;
	Sat, 17 May 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476190; cv=none; b=jpReyIhZTzV6L2eKzZVxIpLEwcBroClNkaOwXYcX6CXhRamL8XSARVlxW8s4arbtOEtjEWg/lAwXxPEtGOuKzWI4f2vX2WG/jqgL6v9fPh1/lllL6JeB00itbtx2kJBCf/RlvsIlPRarj6LQqgkOuqecN081zE+RJPh9npeykfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476190; c=relaxed/simple;
	bh=hVT2/H0EBIj24WiPC+Darq3S7pmlDeal6spFyiURsyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mMxm1Dfo4dc8GysM3ugC57iogOXtv3PnGICYBALdvl7tzZtjU6vizJO15DD5Uqc009E7DoRhFtX7Yjfl1KLTSvofKb6qASOQrWPLGpb2ZmUXpuSN6Qdk9WDO5ruGSwL8Si2sRfond2OCIZ4NNdVvfyR3YBC9mn5D6fyQrrygu6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4MpBxqD7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zyDr3CgR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:03:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GL8LSQoOoW41hiADDixLuTcp4jNbWUc8Ak4mp/n6TDo=;
	b=4MpBxqD7TfKQznYFFT2hvZ8Rtyrjj+h9EpAraIfEDwyR+T9O58xpkAcBjcafay9TO0yJY0
	qvUaynqLCPEmyxrMNFuHftE72WgEZwzjNBm6ow3BXmvCWKSBLqAw29ibQUROzFN2yipb+Z
	+z6lpXyriGJcw0Dr5207cYB02hdjdONGZUGB3zdIwwHp5krRbHg6aSX0UY/qroEBIXJVGe
	bs4hegrsSPlnc4Bxd7mfFewmv2M5ZD90nqQzZ/3yuAfuwdQr3E2AixH3+8UFSt+s3MSLox
	vEAUb2tqQHJHELWdFvlX2t3l6SgKI6TBNoYg8051GYI9epKZ3ChmxT9h5N0HlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GL8LSQoOoW41hiADDixLuTcp4jNbWUc8Ak4mp/n6TDo=;
	b=zyDr3CgR9eQHh5cRKosMtVE5Sw68iVMibZqV3ASug/ZObf0zepVdeC88zZu+rtbeOh83DK
	X3prfBBmAih313Dw==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] find: Add find_first_andnot_bit()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-3-james.morse@arm.com>
References: <20250515165855.31452-3-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747618641.406.4541810444223655669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     13f0a02bf4c1c5888c736cedef9ca50de666adb3
Gitweb:        https://git.kernel.org/tip/13f0a02bf4c1c5888c736cedef9ca50de666adb3
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Thu, 15 May 2025 16:58:32 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 15 May 2025 20:24:40 +02:00

find: Add find_first_andnot_bit()

The function helps to implement cpumask_andnot() APIs.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: James Morse <james.morse@arm.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Link: https://lore.kernel.org/20250515165855.31452-3-james.morse@arm.com
---
 include/linux/find.h | 25 +++++++++++++++++++++++++
 lib/find_bit.c       | 11 +++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/find.h b/include/linux/find.h
index 6868571..5a2c267 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -29,6 +29,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsign
 					unsigned long n);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
+unsigned long _find_first_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
+				 unsigned long size);
 unsigned long _find_first_and_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 				      const unsigned long *addr3, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
@@ -348,6 +350,29 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 #endif
 
 /**
+ * find_first_andnot_bit - find the first bit set in 1st memory region and unset in 2nd
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the first set bit
+ * If no bits are set, returns >= @size.
+ */
+static __always_inline
+unsigned long find_first_andnot_bit(const unsigned long *addr1,
+				 const unsigned long *addr2,
+				 unsigned long size)
+{
+	if (small_const_nbits(size)) {
+		unsigned long val = *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+
+		return val ? __ffs(val) : size;
+	}
+
+	return _find_first_andnot_bit(addr1, addr2, size);
+}
+
+/**
  * find_first_and_and_bit - find the first set bit in 3 memory regions
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 0836bb3..06b6342 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -117,6 +117,17 @@ EXPORT_SYMBOL(_find_first_and_bit);
 #endif
 
 /*
+ * Find the first bit set in 1st memory region and unset in 2nd.
+ */
+unsigned long _find_first_andnot_bit(const unsigned long *addr1,
+				  const unsigned long *addr2,
+				  unsigned long size)
+{
+	return FIND_FIRST_BIT(addr1[idx] & ~addr2[idx], /* nop */, size);
+}
+EXPORT_SYMBOL(_find_first_andnot_bit);
+
+/*
  * Find the first set bit in three memory regions.
  */
 unsigned long _find_first_and_and_bit(const unsigned long *addr1,

