Return-Path: <linux-tip-commits+bounces-3186-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D35DA071CC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2137B16334C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC221576D;
	Thu,  9 Jan 2025 09:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmQauo9d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/AR1rcz4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08300215769;
	Thu,  9 Jan 2025 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415828; cv=none; b=BN27X0gJVxRrrXYtJ4Nld1o15xRPV5ngrp0yn5TAII476tIVY+McYYRwSeSBK1YFGZLAmjWgqyXkeqGVLhp0zbBZEZYnKhDqNLZWjajHO0wcfh//NWO6d747rv6xP7Hyez5EHJ/qqQRd9XSAivJ9LLyl6y2F0iHOZX6iEzRmY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415828; c=relaxed/simple;
	bh=SQaBrg1zjN24y6FhbalDEj57n3VuE8EpiAqJOXNR0ZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fFGw5S+MH1CBCrwUjzfiMhu3+2hOYUC/AJ3waoKh2Xc8DlTfilEfMvz1Y/HX+n19TtKml7GuoujDfBJ6coamtyU3ZJ0TsBSPUtiCCiKsq1s9id6qxlcoWr9tXzGFULxzlYNhZjwWmR4YJkDO4dGpoFCcrqFH9/zm9Mee+AG4zlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmQauo9d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/AR1rcz4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba3wYC9yDIWcDyc6l/+yr3/cr1HB536mKOxXDS45AeM=;
	b=hmQauo9dUF4mWUrxfZCw/erlRrTEO75SZCorHk8xEHSg1i6kREeCJp8AT9FuY27K2iSbvR
	GP+VsMYiZe4TW/xGAPxgWO+vOx8iXo4BFuJVKBA2nXbVmTNpwTkKdvV7l07S/BQzpoeMNF
	ZfEeM0u/6ulQIHHRjsDv5EKbHIAI/sjFfVKEebjKjSKUKeMb1jgmhHULLdhuO+H2iGIqeC
	45Fh/BPSJwYg1VVGrUEDyZ+X4EqNkKxwF6iqCmMyavwafp6Azui0Wk0bRwferLf2A5VUrq
	9xRPAkXYTZtqmsYqrCLFFwWTM/WqCXp+2KQAw1uHvAXAS73MQyF+tirDFr5Y0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415824;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ba3wYC9yDIWcDyc6l/+yr3/cr1HB536mKOxXDS45AeM=;
	b=/AR1rcz4CU3omMo8N421aL9KQLiyV+ZjCaSpFHsh8EOZJzDJuFBfJd2zkEvjhvBQ8PmuZr
	gxn646AL9oJPRJCQ==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Add the Secure TSC feature for SNP guests
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-14-nikunj@amd.com>
References: <20250106124633.1418972-14-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582369.399.9163326077028868911.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0563ee35ae2c9cfb0c6a7b2c0ddf7d9372bb8a98
Gitweb:        https://git.kernel.org/tip/0563ee35ae2c9cfb0c6a7b2c0ddf7d9372bb8a98
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:33 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 09 Jan 2025 10:21:56 +01:00

x86/sev: Add the Secure TSC feature for SNP guests

Now that all the required plumbing is done for enabling Secure TSC, add it to
the SNP features present list.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Link: https://lore.kernel.org/r/20250106124633.1418972-14-nikunj@amd.com
---
 arch/x86/boot/compressed/sev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index cd44e12..bb55934 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -401,7 +401,8 @@ finish:
  * by the guest kernel. As and when a new feature is implemented in the
  * guest kernel, a corresponding bit should be added to the mask.
  */
-#define SNP_FEATURES_PRESENT	MSR_AMD64_SNP_DEBUG_SWAP
+#define SNP_FEATURES_PRESENT	(MSR_AMD64_SNP_DEBUG_SWAP |	\
+				 MSR_AMD64_SNP_SECURE_TSC)
 
 u64 snp_get_unsupported_features(u64 status)
 {

