Return-Path: <linux-tip-commits+bounces-5544-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05CCAB7F73
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 09:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2883BD586
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 07:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC5D281526;
	Thu, 15 May 2025 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C/hrAbob";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SiSz38z+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D301F4CAA;
	Thu, 15 May 2025 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295908; cv=none; b=nBFO6wRvYaCqDLgR4IonElT9J/lhsP4iwppiGsC7Mifz/9ZyxgEmHK3sL5oydDG75jV+jrnmsYLOMeYBsYMv990Mvnp4zmq51f5VGCcvkI/x8TxNoA7fqrgNk9HM+ETQB1SjAs+kRMqVjcWTX3Gd7L16eQofSESQBoX+KE3A8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295908; c=relaxed/simple;
	bh=H8dfP44ch9njqgpXd4mXOVs5iS4aHByOicjE2gwtaAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g8bipXtrh06eqPWVzq/fj7iZH/SkjgoEidYXQi42x370xkDCt+BIFsdfyGOOsKxguEdcsRFUVsSm4/iOHAnuNgwFt0Z69IjBCEzvt1rFPQMR6dA06kqJDP2Bfxuzgz/d4FB7ZShXunRo0EqcBTS9wktUd6mhgYyeU5yMRWVSvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C/hrAbob; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SiSz38z+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 07:58:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747295904;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbeOLalRqnzzkyoD/rlXLfaznoZUGgwrBmyWfFMDthA=;
	b=C/hrAbobHqZ3nIvS9z0vi4ccWCM859krf/p+eJc2brTWTn131BOohra6zCMHNPA7eRR18T
	Plaf+vMV+/TOiL3j5ky/RtVkd3qTCE+Lk3vFfcwUCIoUNPNLAeU4V0rkexVllv8Iba9lkD
	SVgFVrCfcDnP8CPUWzhIVsaVV66sWlLlhtsqX+a6PJQ/JqGmnCDFZTjHkH5umuAffuW1H3
	Gotyr7Hda91XH1Lt2H937S3GfOJiyCpVeB3GW4mmaM1ncJ/JPjsiwrsmLLX29JGx7RY76E
	w3YW53FiJmj5qzyVRVbN734lORkAvCLlrUerInOUf0xRoygCxgAY08NM+EIFtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747295904;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbeOLalRqnzzkyoD/rlXLfaznoZUGgwrBmyWfFMDthA=;
	b=SiSz38z+0BFwX3KbQsCZRNA7fhrZRVHVmfKRUJ7GV7950jQphZgulaRfrr17es/tGTHWZo
	wuorSo/5BbVfFlDQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/asm-offsets: Export certain 'struct cpuinfo_x86'
 fields for 64-bit asm use too
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250514104242.1275040-12-ardb+git@google.com>
References: <20250514104242.1275040-12-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174729590359.406.2257489863278395277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     25219c2578b32c96087569d074e32c8ae634d602
Gitweb:        https://git.kernel.org/tip/25219c2578b32c96087569d074e32c8ae634d602
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 14 May 2025 12:42:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 15 May 2025 09:12:07 +02:00

x86/asm-offsets: Export certain 'struct cpuinfo_x86' fields for 64-bit asm use too

Expose certain 'struct cpuinfo_x86' fields via asm-offsets for x86_64
too, so that it will be possible to set CPU capabilities from 64-bit
asm code.

32-bit already used these fields, so simply move those offset exports into
the unified asm-offsets.c file.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250514104242.1275040-12-ardb+git@google.com
---
 arch/x86/kernel/asm-offsets.c    |  8 ++++++++
 arch/x86/kernel/asm-offsets_32.c |  9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index ad4ea6f..6259b47 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -33,6 +33,14 @@
 
 static void __used common(void)
 {
+	OFFSET(CPUINFO_x86, cpuinfo_x86, x86);
+	OFFSET(CPUINFO_x86_vendor, cpuinfo_x86, x86_vendor);
+	OFFSET(CPUINFO_x86_model, cpuinfo_x86, x86_model);
+	OFFSET(CPUINFO_x86_stepping, cpuinfo_x86, x86_stepping);
+	OFFSET(CPUINFO_cpuid_level, cpuinfo_x86, cpuid_level);
+	OFFSET(CPUINFO_x86_capability, cpuinfo_x86, x86_capability);
+	OFFSET(CPUINFO_x86_vendor_id, cpuinfo_x86, x86_vendor_id);
+
 	BLANK();
 	OFFSET(TASK_threadsp, task_struct, thread.sp);
 #ifdef CONFIG_STACKPROTECTOR
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index 2b411cd..e0a292d 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -12,15 +12,6 @@ void foo(void);
 
 void foo(void)
 {
-	OFFSET(CPUINFO_x86, cpuinfo_x86, x86);
-	OFFSET(CPUINFO_x86_vendor, cpuinfo_x86, x86_vendor);
-	OFFSET(CPUINFO_x86_model, cpuinfo_x86, x86_model);
-	OFFSET(CPUINFO_x86_stepping, cpuinfo_x86, x86_stepping);
-	OFFSET(CPUINFO_cpuid_level, cpuinfo_x86, cpuid_level);
-	OFFSET(CPUINFO_x86_capability, cpuinfo_x86, x86_capability);
-	OFFSET(CPUINFO_x86_vendor_id, cpuinfo_x86, x86_vendor_id);
-	BLANK();
-
 	OFFSET(PT_EBX, pt_regs, bx);
 	OFFSET(PT_ECX, pt_regs, cx);
 	OFFSET(PT_EDX, pt_regs, dx);

