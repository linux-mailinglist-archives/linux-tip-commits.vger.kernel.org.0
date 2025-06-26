Return-Path: <linux-tip-commits+bounces-5934-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1634BAEA918
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 23:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE301C40D34
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Jun 2025 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DB8262FE6;
	Thu, 26 Jun 2025 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nJ2EDNSX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02u6G7gz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C427F2571DD;
	Thu, 26 Jun 2025 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750974948; cv=none; b=J6zZ6GjK3JPvx/OydakKuvr613NFOe4dg/fk8gHv/3Wg2gqNtNk6zKdZZAkdfFTQIW0qXPxwVyFeZiLz5MXyWwk00cLGmSKKCRXrlrEt6JpS6nkRnC87+4FOWCLyauDmy2vsdh77bhc6wnwEKJ313E9Lf+j0qhaOETM2bZx1PlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750974948; c=relaxed/simple;
	bh=zL0wTsG8zuIic6fxR+GDXbV5z9jugmrFBBu9SjMRyXY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G5pf/e49BnY074YEt6KRlbzwRx9hkYS6+wV3FUiAtW+hkm+zgBs8FKvTVpe948+T3zexZeuy3URbyYxkRMrbZXZvLBgI69S+a9wq3yP8R9H+iUUqXGviG/FL5KOiE2FeFBYqLwuT4K4EJz/LvcwWWqslQ4cb7yTuSvKKTga8H90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nJ2EDNSX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=02u6G7gz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 26 Jun 2025 21:55:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750974945;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAVKuE+09Dk48VIHkVepLhQ3rOYCBRRRZbKi53IbD/s=;
	b=nJ2EDNSXuCfPz+J5o4eWHyQrZQnkkrrs+I+HXxrYt8I7GheuqM/qSlGBwYokZSlL2kuzg4
	1yGfk95XvqGX8378PWQOaz0twJPhvO+He/aiup5IytEB8gghG+Q+CGkV6qUFmTSFqZTNtZ
	sflMjwZbHz6RIx9o4JfizF+/+88URowikC3WYXTrnpgRFi8LMBtdr/O6NC0W+7aMM1cL9P
	PEvGCSTJPth4iRSdgofw1iZJJm1ElU0BkLe2qtddj+RJtKBKjrC8Qp2az6WeJZ5nC2MbnQ
	usfoEvkYQE+JM4+E9/ggD2e4Dqjwqb3qztb4yghV8rWwruvNL+yOw9mQsrWvpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750974945;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pAVKuE+09Dk48VIHkVepLhQ3rOYCBRRRZbKi53IbD/s=;
	b=02u6G7gzLW71d76cLE0tJAvoWcCh9faycDuntfR3DGPapdCLiv6Ru2qWo5QTNEb4EbO4de
	14tz1MUWmAzEtICw==
From: "tip-bot2 for Yury Norov [NVIDIA]" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: smp/core] smp: Use cpumask_any_but() in smp_call_function_many_cond()
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250623000010.10124-3-yury.norov@gmail.com>
References: <20250623000010.10124-3-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175097494407.406.3604280257171753188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     976e0e3103e463725e19a5493d02ce7b7b380663
Gitweb:        https://git.kernel.org/tip/976e0e3103e463725e19a5493d02ce7b7b380663
Author:        Yury Norov [NVIDIA] <yury.norov@gmail.com>
AuthorDate:    Sun, 22 Jun 2025 20:00:07 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 26 Jun 2025 23:46:34 +02:00

smp: Use cpumask_any_but() in smp_call_function_many_cond()

smp_call_function_many_cond() opencodes cpumask_any_but().

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250623000010.10124-3-yury.norov@gmail.com

---
 kernel/smp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 7c8cfab..5871acf 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -807,13 +807,8 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		run_local = true;
 
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
-	cpu = cpumask_first_and(mask, cpu_online_mask);
-	if (cpu == this_cpu)
-		cpu = cpumask_next_and(cpu, mask, cpu_online_mask);
-	if (cpu < nr_cpu_ids)
+	if (cpumask_any_and_but(mask, cpu_online_mask, this_cpu) < nr_cpu_ids) {
 		run_remote = true;
-
-	if (run_remote) {
 		cfd = this_cpu_ptr(&cfd_data);
 		cpumask_and(cfd->cpumask, mask, cpu_online_mask);
 		__cpumask_clear_cpu(this_cpu, cfd->cpumask);

