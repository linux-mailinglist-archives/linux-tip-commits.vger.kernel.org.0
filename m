Return-Path: <linux-tip-commits+bounces-6069-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A58B005AA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610615A2719
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Jul 2025 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ABE275858;
	Thu, 10 Jul 2025 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GiN1tjqv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AaRl5Tel"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CFD274FD1;
	Thu, 10 Jul 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158873; cv=none; b=gc+hXqsH+0CDlquyc40bPsIqL5amvDrZbTPo4N4xTwxMcoIgmFwDW6wiFUlKWDv4lMuPpKs+C634KShg/8xTZO5Jhs/RwOTl4RNyXpoCpFrF27AnHDN3F/AymGoSeWF7qbuAu9Ju1CK61r7bSI22rFc3b/FqkaTVaQMNmaryyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158873; c=relaxed/simple;
	bh=0v85dLTcdqLyW1qGSv9PLGX5JR0LYoRyslgH8uyNVig=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gOPMFRKWdp+kRkUlRoZSYULL1YfwDRYgIxadG+UJyQtrRMxLGQj0ITOGVFC/IAm2eqX9fQIzNdE103lnMMDWK0I5A3DiIG8rgeluf/nXnyNAZ0Gq6j7Tjh4AuqzOQ4iw4S3y85HOjj+AupTcU64Y9Au+Ryvydxj/WJOe+C/0/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GiN1tjqv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AaRl5Tel; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Jul 2025 14:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752158870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOgBu3H54U7HY1QrT1AbywTc9zXj69M0HbGLnlhNbic=;
	b=GiN1tjqv6BikYsDy3byhOyXOycC+hKRhQHmXL+AHNluMGE0IPv2olo6P2FuJHWec+ZbMGs
	CnROd4ihZ6P6iuCP3oEmZZPZIL2HQwoWyKQLS++a5b0AUHCqRPEg80yEaz1N9p3Xt26zUm
	CL6jIrLAbDfLixEEGrs6fJPMtph4+t8yjVtFoDl5RJLlumbL89DxYH6GgTuN4phv3iz/GW
	2D2SKLF8TdhitZF+PT2UC7vQ3IsDPJpfamkKukxdECj4PYSPCel7AS1+xTqJ6LSA8f4PMu
	VofoDZhYbbaIDxUklIxkGU6R2toIfJe9nUt63Uq0VxfDrSSq0l/r/TE+Xop5xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752158870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOgBu3H54U7HY1QrT1AbywTc9zXj69M0HbGLnlhNbic=;
	b=AaRl5TelEjx1Fr2kRnN2iCqB6tA/hzdwpxJlVTYV0HLfZ0FXgYK+hK9vSt1aqaFORNsgJN
	rgL9N/BeD/vOltDw==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] drm/gpu: Remove dead checks on wbinvd_on_all_cpus()'s
 return value
Cc: Sean Christopherson <seanjc@google.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250522233733.3176144-2-seanjc@google.com>
References: <20250522233733.3176144-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175215886895.406.9664769369203437279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1d738dbb252f66dd909a662d85c67b93314d7ae7
Gitweb:        https://git.kernel.org/tip/1d738dbb252f66dd909a662d85c67b93314d7ae7
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Thu, 22 May 2025 16:37:25 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Jul 2025 13:07:26 +02:00

drm/gpu: Remove dead checks on wbinvd_on_all_cpus()'s return value

Remove the checks and associated pr_err() on wbinvd_on_all_cpus() failure,
as the helper has unconditionally returned 0/success since commit

  caa759323c73 ("smp: Remove smp_call_function() and on_each_cpu() return values").

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250522233733.3176144-2-seanjc@google.com
---
 drivers/gpu/drm/drm_cache.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 7051c9c..ea1d2d5 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -93,8 +93,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 		return;
 	}
 
-	if (wbinvd_on_all_cpus())
-		pr_err("Timed out waiting for cache flush\n");
+	wbinvd_on_all_cpus();
 
 #elif defined(__powerpc__)
 	unsigned long i;
@@ -139,8 +138,7 @@ drm_clflush_sg(struct sg_table *st)
 		return;
 	}
 
-	if (wbinvd_on_all_cpus())
-		pr_err("Timed out waiting for cache flush\n");
+	wbinvd_on_all_cpus();
 #else
 	WARN_ONCE(1, "Architecture has no drm_cache.c support\n");
 #endif
@@ -172,8 +170,7 @@ drm_clflush_virt_range(void *addr, unsigned long length)
 		return;
 	}
 
-	if (wbinvd_on_all_cpus())
-		pr_err("Timed out waiting for cache flush\n");
+	wbinvd_on_all_cpus();
 #else
 	WARN_ONCE(1, "Architecture has no drm_cache.c support\n");
 #endif

