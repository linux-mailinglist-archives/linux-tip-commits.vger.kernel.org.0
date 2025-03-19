Return-Path: <linux-tip-commits+bounces-4351-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C476A68ABA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7952884B22
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397F259C9E;
	Wed, 19 Mar 2025 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="28C2ulOB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fTxdFtWo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8E2586E6;
	Wed, 19 Mar 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382227; cv=none; b=NcSONLJ9y6gPwZ+1oSJzAwQBNRBNxmYY2hklHvHwwuBcQ4wVo+vc4yUjvM5vDbWOhZE8+qLJ7yL6Oa42YRPg1qHbP7P5LA0vAPMZCOUx+oBcCznV5sm+7e5zyqwhzH4ShB3ITY7sjVfQOJUXKabBvqZHyCig9pWl1wvymA53T/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382227; c=relaxed/simple;
	bh=E+2qtfJKYpdI/y5bWtVkyXJWWLeag90srlIzyhrHKdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AOvcIE8jbJ4OeCt6Kddv/+/xjMkUqzi0D23Or26lkjp2FG4An2FUa5H0AF7ukMa9t/FqDZEytg4CjpiwGqE3PGqAGMFy47oGzYDN0k1vQTu5qgnMpzw+EW4iFLnWB351FqCsGMKsN7jRyvrJxFN2vekMSSntSeMOAuePFbO1K20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=28C2ulOB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fTxdFtWo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZbCgbAr1f6vigXM5w3KfMJGiT1c9ULZr6zg17jIU0g=;
	b=28C2ulOB6RRz7oBhaT1J846xLoXZdnb8BiFHMaysxS2Jvqk5TAfapWtFiWC4wY3zhh6G4W
	DfuR2nZNNFVdlfCtxN0eOW8Uf1LwSvKYX6KpfxaSKr0SLUGBNQNGUu++NY9/tEkf4tCyL0
	FiECsFugYS3Ae8tT144sL1oNlqu2GouIgnTlmOKKlNmAsnQb3V9XYOOCXhCBrshekkSgsv
	vr49JpGK93ZBR8djCckrr8QnK8CDWC4sMf6mnQ78w37XpSSFGkC98rnqmU8rw9TVH21RmO
	zNkiy5OWLHf/EnimP26kl+IOkDhkoquaITD5VIo4jHHGW+jWfcamx8Y12siV8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382223;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZbCgbAr1f6vigXM5w3KfMJGiT1c9ULZr6zg17jIU0g=;
	b=fTxdFtWoO5PLZCzrCk+Vwhx4rBwUdYny0SYHoWTU+IVlMQmI27/H8YgV/SH3kwDOe1/hXp
	2lJI5aV7QGxcw+Bg==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/microcode: Update the Intel processor flag scan check
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-4-sohil.mehta@intel.com>
References: <20250219184133.816753-4-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222305.14745.3957310536282175277.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     7e6b0a2e4152f4046af95eeb46f8b4f9b2a7398d
Gitweb:        https://git.kernel.org/tip/7e6b0a2e4152f4046af95eeb46f8b4f9b2a7398d
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:21 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:38 +01:00

x86/microcode: Update the Intel processor flag scan check

The Family model check to read the processor flag MSR is misleading and
potentially incorrect. It doesn't consider Family while comparing the
model number. The original check did have a Family number but it got
lost/moved during refactoring.

intel_collect_cpu_info() is called through multiple paths such as early
initialization, CPU hotplug as well as IFS image load. Some of these
flows would be error prone due to the ambiguous check.

Correct the processor flag scan check to use a Family number and update
it to a VFM based one to make it more readable.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-4-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h   | 1 +
 arch/x86/kernel/cpu/microcode/intel.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b657d78..f0e7ed0 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -46,6 +46,7 @@
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+#define INTEL_PENTIUM_III_DESCHUTES	IFM(6, 0x05)
 
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index f3d5348..819199b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -74,7 +74,7 @@ void intel_collect_cpu_info(struct cpu_signature *sig)
 	sig->pf = 0;
 	sig->rev = intel_get_microcode_revision();
 
-	if (x86_model(sig->sig) >= 5 || x86_family(sig->sig) > 6) {
+	if (IFM(x86_family(sig->sig), x86_model(sig->sig)) >= INTEL_PENTIUM_III_DESCHUTES) {
 		unsigned int val[2];
 
 		/* get processor flags from MSR 0x17 */

