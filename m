Return-Path: <linux-tip-commits+bounces-2050-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF812951987
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 12:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB7FF2852B1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 10:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752401AE852;
	Wed, 14 Aug 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRI3tSwE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jld8sOSF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF66AD5A;
	Wed, 14 Aug 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633174; cv=none; b=JmX+4sGHMng2dB1s4YfiNveuDd36HqPl9MtJEyi7/RZwRJV+10ccgGwp5mztK0Wd+OBwXQD7ZEVDrZOBCIuJCEAwCOYJcsMyL8+2jrkPZ/X4/x4k3lUngFi5oGwRLSZW7tO1+ju2L9ODYA5z0Hvq6qxNmEJfNVcZvlB2YeLpgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633174; c=relaxed/simple;
	bh=F/M/Vxi3EnARwbop+Y/BElYUTAWJG1MJJUQ7EeIPi0g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sRXiPiQbRjTlyTWpwX7GDyVot1v+e7zhpSVhCdhMkf5+qnVWLuS3v3/T3UBcWmol6ofVDfQ9B1zQkFdT6bba9u6LtsPh49CV67B5PABLvQs1aeHUEPaQ34hXnitDUv0Zay8bZtxhcXXDIDn2Qq03iOw/a4G9NAvHqCur+v2SRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRI3tSwE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jld8sOSF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Aug 2024 10:59:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723633171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGVvCB9MV4tgGO1fWP0J06GLQAF3SweWE3g8hu6rBOg=;
	b=NRI3tSwEYxUf+uhrlvzkcggabmeL2acVf4AvsalIjPFtNzBQPC7XBmlfWRqe031BvnbG6W
	keV4DztOa7nNxjcCGWsePFGczQ7XmRtQyrm8vcGsInQb5ss2DOVPu5V0TfKxofr3YQVZuv
	J9OqqKFO7yel7DBbKyGcqIMRk54aWfJezGpOMbcp78yYvt/o5EDhobZkxhcjyd1ussPHFx
	Ucopze+Y0E/MMBg6gkyn998/pM0hjHc3RXlUFgtGURTmTxPwdPGKeL+DRKOZ+u/ktIxOKU
	/pOXQ0mpU0HIKGvvk+aXKBF4VFev+JPhDbtXdTtJxdxRQrEExZYxdl0bQPW7Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723633171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGVvCB9MV4tgGO1fWP0J06GLQAF3SweWE3g8hu6rBOg=;
	b=Jld8sOSFeh59MrV9GwZFpH2EXyQ3XIQvsuezdQ7+LHFvqeplGU4D6iUClVSJDnMQiu9Rlq
	RNHOl3DvN6uq2oAg==
From: "tip-bot2 for Yue Haibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove unused declaration
 uv_irq_2_mmr_info()
Cc: Yue Haibing <yuehaibing@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240814031636.1304772-1-yuehaibing@huawei.com>
References: <20240814031636.1304772-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172363317050.2215.13627603380600979711.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     22f42697265589534df9b109fe0b0efa36896509
Gitweb:        https://git.kernel.org/tip/22f42697265589534df9b109fe0b0efa36896509
Author:        Yue Haibing <yuehaibing@huawei.com>
AuthorDate:    Wed, 14 Aug 2024 11:16:36 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 Aug 2024 12:49:35 +02:00

x86/platform/uv: Remove unused declaration uv_irq_2_mmr_info()

Commit 43fe1abc18a2 ("x86/uv: Use hierarchical irqdomain to manage UV interrupts")
removed the implementation but left declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240814031636.1304772-1-yuehaibing@huawei.com

---
 arch/x86/include/asm/uv/uv_irq.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv_irq.h b/arch/x86/include/asm/uv/uv_irq.h
index d6b17c7..1876b5e 100644
--- a/arch/x86/include/asm/uv/uv_irq.h
+++ b/arch/x86/include/asm/uv/uv_irq.h
@@ -31,7 +31,6 @@ enum {
 	UV_AFFINITY_CPU
 };
 
-extern int uv_irq_2_mmr_info(int, unsigned long *, int *);
 extern int uv_setup_irq(char *, int, int, unsigned long, int);
 extern void uv_teardown_irq(unsigned int);
 

