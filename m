Return-Path: <linux-tip-commits+bounces-3195-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11497A071DE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAED81888B97
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15866216E3D;
	Thu,  9 Jan 2025 09:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VCkwApia";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AHr8hvy3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F3C21578E;
	Thu,  9 Jan 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415835; cv=none; b=NYRRJX41sKIYQQX+1RA2Kj+OAfQnll7heFjg3Jc9/VeIRmCTr9co0jRvxzUyjJnc5Gby99IcXn+bTil7LkV/KF+nIixHGpWJ9ODIZ2yuIGUGF9IS+iBDyVSgEUDuvf9b8GRWXPOz3JUTV20RmHW9Qh3N0PwKwYsnqYthSbnoXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415835; c=relaxed/simple;
	bh=0pILOySn0vSZUxj41MO4kPd21WD7y1ALBgTuHaZs6UY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cGB/vm8tO+rKxw4GD9OiEcZF91mVMii4jPgE/Va0tkXLVhgy+/GdQ+mAgWB5t60S6lRxVXsw1HCzvDhtrEkEp+yJwHCdhMgtt0hC2G4u4HoAJJdV97f6+1tECkP09gcrX/nQCWO2lk4TJ/U91yOGGXAu80xAEneRjSIryHKLf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VCkwApia; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AHr8hvy3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzGauRnZQ8W9ZnaRwX8ZGGfxexoVLo1yGRWAWq98uVI=;
	b=VCkwApiag9FggJcT+6SmeMegImp4JqNNXzmQfGjncAmprdaugg+qc+gTkK76bPJWRs9yJ1
	/INcEYzRRZd5lbuk83FHkWJBnSbeDHeCv4EhjOGjJZdHLzddnGbXV1xX4krEsDWuFAttZr
	KU4xAWX/IArnmJqg1vck7dGGKGWKwYGbJq2KpGCMTWbVuk+X/qsOqJGfzuTFyZQ1HT/VS+
	0o8OXORvf6O/rYm8TLgjjrHkbJ2AfC9TmOEYRjrYw7vnvPIGWU2GQCcoumQXTdv2fQ02lA
	2rmFnGDoKpF+7vQGv+0nj++J9pYAAemvtouqAjb0ntuTZ5h+SLPAqolKzUJxHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzGauRnZQ8W9ZnaRwX8ZGGfxexoVLo1yGRWAWq98uVI=;
	b=AHr8hvy3S+LMK2H1/OTZ2uNwUCtkrnNT6RGgrjlmUN8DBv/ffjY5CaxAP/PJu1LNnES/Pt
	Ul28ly7qxiBdIFDA==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] virt: sev-guest: Replace GFP_KERNEL_ACCOUNT with GFP_KERNEL
Cc: Borislav Petkov <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-3-nikunj@amd.com>
References: <20250106124633.1418972-3-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582916.399.4849217740919036703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     864884a0c29cc610a859b5210158112fd8675fe1
Gitweb:        https://git.kernel.org/tip/864884a0c29cc610a859b5210158112fd8675fe1
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:22 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 10:26:20 +01:00

virt: sev-guest: Replace GFP_KERNEL_ACCOUNT with GFP_KERNEL

Replace GFP_KERNEL_ACCOUNT with GFP_KERNEL in the sev-guest driver code.
GFP_KERNEL_ACCOUNT is typically used for accounting untrusted userspace
allocations. After auditing the sev-guest code, the following changes are
necessary:

  * snp_init_crypto(): Use GFP_KERNEL as this is a trusted device probe
    path.

Retain GFP_KERNEL_ACCOUNT in the following cases for robustness and
specific path requirements:

  * alloc_shared_pages(): Although all allocations are limited, retain
    GFP_KERNEL_ACCOUNT for future robustness.

  * get_report() and get_ext_report(): These functions are on the unlocked
    ioctl path and should continue using GFP_KERNEL_ACCOUNT.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250106124633.1418972-3-nikunj@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 62328d0..250ce92 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -141,7 +141,7 @@ static struct aesgcm_ctx *snp_init_crypto(u8 *key, size_t keylen)
 {
 	struct aesgcm_ctx *ctx;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return NULL;
 

