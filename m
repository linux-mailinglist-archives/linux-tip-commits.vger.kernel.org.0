Return-Path: <linux-tip-commits+bounces-3196-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2CA071DF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294B7188A248
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604EC217647;
	Thu,  9 Jan 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cy46Iqwf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kRkQ9CyD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BAF216E1A;
	Thu,  9 Jan 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415835; cv=none; b=qlCWYnlTHAruAU/Ar31minw0ggvUXRcR297Oo+zwCM91ukxmOlTOJZcC4Ur6YyNgGW1Xz3swK1ENhRlSy27oMLoYcajaayRds+LmhPiCDfONtIXD4CJAcFvZ/DL8w3JArIYr9i0RIH+VXblOdaI+3DbV+PF7lQBbClsBDdmW3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415835; c=relaxed/simple;
	bh=L+N9i0VvUkS3aOHFLLB0rLIGsfmvkDp4QMiBasVrV2k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U4hS/1K2H9oAvSXVlhH9MwB+YxbMa1cCpS+FExeP9cC7PwD2CmF2QX/SaPTgAK/jRKOLp93AWwIi28wo/POJ5wogqy/hIs5WlU/1e/HrKDIh3dn/dz4tub/f8LooeL+LE1evRuScjDJWSer/2bgY8f/UED7+hTMUrJJZVjj8g1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cy46Iqwf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kRkQ9CyD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEJhkZrr9Siph5RnX85iDYrnZ1GA/Q2bHToJj1y0r40=;
	b=cy46Iqwf55buezLC6RkhlhfXaE7DBuIE64N784OHgT0JIKliu3c7v0U5vB44guCCjaTV3L
	5OmdUhSEcK5/C/lFhYuQfMMDR1h3SbAn2jvE1ExSertglV+Gw+7MfOUvP7U1j6VnbnseBl
	rF2Ya5pzmAFa66xBU02lg7Gtx47lW3/3veeFwOsjlFHCGN6ix8s/lbxe6AmbBY7I+fI+mJ
	+t3C7Doc9eWf0I0hJ9p9RPuyTG8m9cNJB1GQxMZTLPlQqukRV8r++hVLHGyQUn4VM0RSCW
	iautXRHe3jnSbf/CasuCaIbQY9EEp7y1AhynPcjI8IdVdlEOEbuOtxiTALZE7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415832;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEJhkZrr9Siph5RnX85iDYrnZ1GA/Q2bHToJj1y0r40=;
	b=kRkQ9CyDCkKML4mI+wH7XCtYshgquldPLh9mJKg9/GGuUW2kmhW9Tctq9MOCs8F6hU+grU
	pzCm+0Gd/Vjd6sAg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Remove is_vmpck_empty() helper
Cc: Borislav Petkov <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-2-nikunj@amd.com>
References: <20250106124633.1418972-2-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641583182.399.17887247194861823108.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8234177d2027e52126e40472fe5807f4e94b19a3
Gitweb:        https://git.kernel.org/tip/8234177d2027e52126e40472fe5807f4e94b19a3
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:21 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 08:57:19 +01:00

virt: sev-guest: Remove is_vmpck_empty() helper

Remove is_vmpck_empty() which uses a local array allocation to check if the
VMPCK is empty and replace it with memchr_inv() to directly determine if the
VMPCK is empty without additional memory allocation.

  [ bp: Massage commit message. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250106124633.1418972-2-nikunj@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index b699771..62328d0 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -63,16 +63,6 @@ MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.
 /* Mutex to serialize the shared buffer access and command handling. */
 static DEFINE_MUTEX(snp_cmd_mutex);
 
-static bool is_vmpck_empty(struct snp_msg_desc *mdesc)
-{
-	char zero_key[VMPCK_KEY_LEN] = {0};
-
-	if (mdesc->vmpck)
-		return !memcmp(mdesc->vmpck, zero_key, VMPCK_KEY_LEN);
-
-	return true;
-}
-
 /*
  * If an error is received from the host or AMD Secure Processor (ASP) there
  * are two options. Either retry the exact same encrypted request or discontinue
@@ -335,7 +325,7 @@ static int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
 	guard(mutex)(&snp_cmd_mutex);
 
 	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(mdesc)) {
+	if (!mdesc->vmpck || !memchr_inv(mdesc->vmpck, 0, VMPCK_KEY_LEN)) {
 		pr_err_ratelimited("VMPCK is disabled\n");
 		return -ENOTTY;
 	}
@@ -1024,7 +1014,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	}
 
 	/* Verify that VMPCK is not zero. */
-	if (is_vmpck_empty(mdesc)) {
+	if (!memchr_inv(mdesc->vmpck, 0, VMPCK_KEY_LEN)) {
 		dev_err(dev, "Empty VMPCK%d communication key\n", vmpck_id);
 		goto e_unmap;
 	}

