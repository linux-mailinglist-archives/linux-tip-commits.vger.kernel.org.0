Return-Path: <linux-tip-commits+bounces-2497-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F379A218D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1828281B24
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Oct 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547751DC759;
	Thu, 17 Oct 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JPdtA44";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVcKxJBc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37EA1DA113;
	Thu, 17 Oct 2024 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166193; cv=none; b=Ide7EPlVcTagNvQpsjdt3BFGcgEERhpYZPMwhbV8U/v91mjzcG9kDRRDmM4SXYFJ+yYHlhqbYvzdvYYtT4wYU9DtmZKDXEN2KLiwTDz9mSu3l1D7rK82Q91V1xEynmK9SEnmA57IGp2Aoc4mDza+h0elF5Y/apxQ56qIwSA8vpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166193; c=relaxed/simple;
	bh=c9O/YOhzIkVtUNYhOSdeZzmx5cuRJpR9pD5GXzwW+gw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=StTht2homVbngUttUagj2sfNG4R9rqS3SW2IJ3SJ8PieFZY0uNiYO27uFH58q7/7Xh+s6p6Z/buOXp3s3HFcCm8OT6SWfOzhX+cFr1A+YFkNVpP7ky7ayLOXfgOLVanSW+ux8C5wSdhWLl4QVfWqxkUmMLNu0q1haaK3oWQjDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JPdtA44; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVcKxJBc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Oct 2024 11:56:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729166190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9dey+2bqOoU7BO8SGQ6aIp4bk/xyB0YLwrZe2xEonk=;
	b=1JPdtA444rXiIXPNIkS3rVDdlUl7U0FG7affRX3RmpFZPhDB5jc+4qGcvMzCMX6bR5Cmf/
	nleU5QQylKswjhgJeSYe2Ov25lfl3DsA5e3wp0fEX73dJh+nfWH/hnsAwWoWi4mj05Xn6d
	9cmQA713qLOOoq15rrXK1s6K9rfZ69ib5/M8h0y4WkWwH71OqVgNEnK8q5QfRYCQGGtDIP
	eIWSBf84zefecpIuK4ueEEah1hoXRjX9JmNOm68xD5LAyN9A2HA1ADkOQ7y0DuDsDeR4xQ
	4GKI02RgCibci4dqhc9wdEpfcXIYHF1lAUUSBTrO5gENPiA4ML88Y1NU5Ixh7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729166190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9dey+2bqOoU7BO8SGQ6aIp4bk/xyB0YLwrZe2xEonk=;
	b=bVcKxJBc1gqLOHf4cQQsWbdCfcu4uKzS2oNkP4aUCyaDM8ZRjvyTLQ63Ez4QS2SoEYgm8B
	wkwNyv0hNrCNhyBg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Handle failures from snp_init()
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241009092850.197575-3-nikunj@amd.com>
References: <20241009092850.197575-3-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172916618942.1442.9008780255161663558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     f75ff17fb48b1991d7a2822de5acc12bba240dc1
Gitweb:        https://git.kernel.org/tip/f75ff17fb48b1991d7a2822de5acc12bba240dc1
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Wed, 09 Oct 2024 14:58:33 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 16 Oct 2024 18:17:36 +02:00

x86/sev: Handle failures from snp_init()

Address the ignored failures from snp_init() in sme_enable(). Add error
handling for scenarios where snp_init() fails to retrieve the SEV-SNP CC
blob or encounters issues while parsing the CC blob. Ensure that SNP guests
will error out early, preventing delayed error reporting or undefined
behavior.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20241009092850.197575-3-nikunj@amd.com
---
 arch/x86/mm/mem_encrypt_identity.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index ac33b22..e6c7686 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -495,10 +495,10 @@ void __head sme_enable(struct boot_params *bp)
 	unsigned int eax, ebx, ecx, edx;
 	unsigned long feature_mask;
 	unsigned long me_mask;
-	bool snp;
+	bool snp_en;
 	u64 msr;
 
-	snp = snp_init(bp);
+	snp_en = snp_init(bp);
 
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
@@ -531,8 +531,11 @@ void __head sme_enable(struct boot_params *bp)
 	RIP_REL_REF(sev_status) = msr = __rdmsr(MSR_AMD64_SEV);
 	feature_mask = (msr & MSR_AMD64_SEV_ENABLED) ? AMD_SEV_BIT : AMD_SME_BIT;
 
-	/* The SEV-SNP CC blob should never be present unless SEV-SNP is enabled. */
-	if (snp && !(msr & MSR_AMD64_SEV_SNP_ENABLED))
+	/*
+	 * Any discrepancies between the presence of a CC blob and SNP
+	 * enablement abort the guest.
+	 */
+	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
 		snp_abort();
 
 	/* Check if memory encryption is enabled */

