Return-Path: <linux-tip-commits+bounces-4593-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A9A76420
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 12:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979B8188A399
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 10:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFD01DF98E;
	Mon, 31 Mar 2025 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cdVvRblp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbhRkG1j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66381DF244;
	Mon, 31 Mar 2025 10:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416765; cv=none; b=oxOr06oI/r0K4kzwtFe1IxnY949g6VdzNZnEh7GwcdPhxaUO/KlPBAtzo1BIHcbJDQr3algpoamN5Jwax6054t+p20mYZZkHNinIPnKxrzMJKDFaByx1vpUtqmxCF/I4HyOmpnIXWG2Gg2tpnsixLnzw8PZ4quoSAQUHwty+nRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416765; c=relaxed/simple;
	bh=c16dqShJxQB3VocMYGe/7aAk4BoN7ZQyDyI2Zl97W/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KQgkPgbTIKjs2LwbTZXVDD/t6qbx83xTmrm6toWZ/Apm601XAX+oTnt/fD2olSFb4WNCQzhKOJL6TXnfdL2gC4ii6czNur3nF9I+XPbi1hrun0yivBcWob+5oIWCma6kctVKiamsbyCgw1hhHTroFRKyoz5DkpQ8AtgvTzCx568=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cdVvRblp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbhRkG1j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 31 Mar 2025 10:26:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743416762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVi3FDQGaxtCNFzhWSTaDnAFdlKmhk1bVzF4oqPWca4=;
	b=cdVvRblpV+J2SUPwQP34u0POIe/V7wi8EogW0hVQugiexbjbjhxmaPCYOiOAoMUmjvoA2e
	fvVUKRGXjEguvajnzj6C2E5jDPZRT9/cRXzHguIhyNdHnH7EWcnrANVGNAWhniFpkcXl8h
	y5RXOtyJqlc3YCJbXS2sd+Bt+zqqIzyMc8113uEUMPQBAAsnOJG2SLsBldfyMsRfFZbSBA
	pCwZ1N0cHIFtgkXx1GjIRZkbea8uTpURQs2/9x7WQ6Y5IB94caGawPZEzPZkD/gr/vJV2f
	jXS/jj83WEaw31+UevGHBKTuAsHQ83KxFxV52gdjAlWdRX2Szo2pqZ39Se2E7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743416762;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVi3FDQGaxtCNFzhWSTaDnAFdlKmhk1bVzF4oqPWca4=;
	b=UbhRkG1j+hkmswaLCc6EEaAHhFbyXNLAl0AI3QPomcLBRo1RGpxG3+HGiy65HFSiCGVTfp
	IPWsRSz4D0j8FABQ==
From: "tip-bot2 for Baoquan He" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove the arch-specific pgd_leaf() definition
Cc: Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250331081327.256412-6-bhe@redhat.com>
References: <20250331081327.256412-6-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174341676141.14745.5074765444501347523.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     65525a3787ff082575fe29381d4dc8fd535634f2
Gitweb:        https://git.kernel.org/tip/65525a3787ff082575fe29381d4dc8fd535634f2
Author:        Baoquan He <bhe@redhat.com>
AuthorDate:    Mon, 31 Mar 2025 16:13:25 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 31 Mar 2025 12:08:17 +02:00

x86/mm: Remove the arch-specific pgd_leaf() definition

PGD huge pages are not supported yet, let's use the generic definition
in <linux/pgtable.h>.

[ mingo: Cleaned up the changelog. ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250331081327.256412-6-bhe@redhat.com
---
 arch/x86/include/asm/pgtable.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7bd6bd6..5f4fcc0 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1472,9 +1472,6 @@ static inline bool pgdp_maps_userspace(void *__ptr)
 	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
 }
 
-#define pgd_leaf	pgd_leaf
-static inline bool pgd_leaf(pgd_t pgd) { return false; }
-
 #ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
 /*
  * All top-level MITIGATION_PAGE_TABLE_ISOLATION page tables are order-1 pages

