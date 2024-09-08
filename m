Return-Path: <linux-tip-commits+bounces-2202-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA4A9707FB
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCCF1F228F7
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA62170A31;
	Sun,  8 Sep 2024 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcwrGXJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Da3N4sK/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AF5170A29;
	Sun,  8 Sep 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804455; cv=none; b=cd12Vi0PuZ94QFPnC3p6Q1Xl7DfL3FlNyBwOlHby3uZ4xGxZD0ZskxYewAcEEX0Qlcl5Bm3uH93mfdSJ6pOia1pm1lGqTZrCtQD7JWsCwq3txKEksjMoxmfaYmUktVXTLYN0C45PLBbWZHLFKlmqEFx4Hc9al29opuuw2IIYdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804455; c=relaxed/simple;
	bh=R5pwBp2715o6NSCvRGgWRxubQJOcAIg7xxhu5ATYuXk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CkzQVqBnYLoeldk6giiYDkA032b87YMvyoGrWx5PnpSrXzD7QHbJdPd4jV4VHEaovUy23j4QNAbfG6FKyQWzMKwuYYuAciHtVKRub7xqP3EauiTmglGlfR7ZZSsjYRA/MovDolNZNzGQGMbncFYSFVmcZIi0YkST/lx6ZawQe8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcwrGXJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Da3N4sK/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Sep 2024 14:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725804452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bYUEw/Haot8RTB94y9rK+bV3L99l6rdkTwTLwDMgkY=;
	b=CcwrGXJJx+rtPtZfwPgR6xlWT4pqbPEGuzD47zMnynNka1L4vLRQD9xbsJo+TzATyoWOUA
	HpSITYyu5P17NCKduaTwE747dCj775qEbtpw2JepAzor3jdXl3JKpUs3yVOzAYd7BA7kN8
	s4BtSmLMpZs/fJHX75tGfkseFrNY4t2wdPNh44vYw9rTkIYjpzt7Gzy6nFCKO8zCVg7rZM
	V0CiphWWCnwLW1BmsCV0e6Ci1+m4qaF0LEyaTAvrYXIRUz7iCh0IzFZ2QlT8iFqwSFx9d4
	nUrVeKgLhS35105tPy9B5a9lFgN7BUijZVbvVa5nMGyGqC+F2qxf8Rqw36KWyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725804452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8bYUEw/Haot8RTB94y9rK+bV3L99l6rdkTwTLwDMgkY=;
	b=Da3N4sK/afGRHsgEyWZf0TQ2s75hUu2wVOmkel1PvJgHEQOw61519Csr53MJ318ufWRwiu
	OXCBgOZEd+ySQfDQ==
From: "tip-bot2 for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Mark smp_prepare_boot_cpu() __init
Cc: Bibo Mao <maobibo@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Huacai Chen <chenhuacai@loongson.cn>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240907082720.452148-1-maobibo@loongson.cn>
References: <20240907082720.452148-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172580445139.2215.14675924073007959489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     1d07085402d122f223bda3f8b72bea37a46ee0c9
Gitweb:        https://git.kernel.org/tip/1d07085402d122f223bda3f8b72bea37a46ee0c9
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Sat, 07 Sep 2024 16:27:20 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Sep 2024 16:01:10 +02:00

smp: Mark smp_prepare_boot_cpu() __init

smp_prepare_boot_cpu() is only called during boot, hence mark it as
__init.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://lore.kernel.org/all/20240907082720.452148-1-maobibo@loongson.cn
---
 arch/loongarch/kernel/smp.c | 2 +-
 arch/mips/kernel/smp.c      | 2 +-
 arch/powerpc/kernel/smp.c   | 2 +-
 include/linux/smp.h         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ca405ab..be2655c 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -476,7 +476,7 @@ core_initcall(ipi_pm_init);
 #endif
 
 /* Preload SMP state for boot cpu */
-void smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	unsigned int cpu, node, rr_node;
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 0362fc5..39e193c 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -439,7 +439,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 }
 
 /* preload SMP state for boot cpu */
-void smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	if (mp_ops->prepare_boot_cpu)
 		mp_ops->prepare_boot_cpu();
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 46e6d2c..4ab9b8c 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1166,7 +1166,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	cpu_smt_set_num_threads(num_threads, threads_per_core);
 }
 
-void smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != boot_cpuid);
 #ifdef CONFIG_PPC64
diff --git a/include/linux/smp.h b/include/linux/smp.h
index fcd61df..6a0813c 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -109,7 +109,7 @@ static inline void on_each_cpu_cond(smp_cond_func_t cond_func,
  * Architecture specific boot CPU setup.  Defined as empty weak function in
  * init/main.c. Architectures can override it.
  */
-void smp_prepare_boot_cpu(void);
+void __init smp_prepare_boot_cpu(void);
 
 #ifdef CONFIG_SMP
 

