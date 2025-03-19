Return-Path: <linux-tip-commits+bounces-4341-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F6A68AA9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59800427E4B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695AC2571DC;
	Wed, 19 Mar 2025 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XewiF9bA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JCfClE0D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62304254AF0;
	Wed, 19 Mar 2025 11:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382222; cv=none; b=bkae7IZYWM5Y4BzcgFTsSQQHpZl3tBD0iKb2HDOU3VV5nsb8jRd+aTC/0mcKipIJ1N82Up5hQkMb5Q/QMlJEViMCduJDVC87bK2oNWqbNx5plQmBINCj5n8qWWM/C3HVAA8F0cds1i0D5hD4UVqLo4+3xKvDekaAWbQ/9P5UTz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382222; c=relaxed/simple;
	bh=evVEVMSB3Lz1RGUFVROQHmIqEsufW+pVTt/MUNns4/I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TnvUWPP7Df1wvURD04ysmYWw3rADltpxI3zVYMFDZAoNUX+UdakN9fgQR8dTdsvLcD9QuhhYxyJIyqP0uQvMqAYgFMZOMxq+iNyT5jtvNTl5Ps78q9ENRHCDy74Jm4NjeucMRMhNvjQtGvGm+ZgAn9ng3CdldBSG4WNyrcNNgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XewiF9bA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JCfClE0D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37atD4xGZpbCISOz/H0kJj6icdFy4WK/MN9bd8D5ygU=;
	b=XewiF9bA6Q9VM9vTWWCH3oPUqlZBBODTVKBWGGxj4cu1t6exttTD1QDk4U7NfIp0rDBLJ1
	vJbNkmj+pco23igUJ1FuyyJPUYt/lk/+pZce6NBAwPqAGDAbuXnf8Wfha3pYTpVot+zAdV
	+QsLvuJ+Gc2m4qkjmVe9c2ZUxL9LtvVHgP7+udzUPDpOszg9xRkr3EWIyrcOOXY8xbpaUq
	nuCK22mPTIAiLO9e9hw5lEilIqlRxgX+b09DM/BpfHgpdE6TpZA1ovEA+xuWELkhWqTPy2
	DDOYyGlSd8ax7V/w8jXQtVQiHrZIcIgPheRsOGfjqDHP8i23VtmQ+Zvg29/RiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=37atD4xGZpbCISOz/H0kJj6icdFy4WK/MN9bd8D5ygU=;
	b=JCfClE0DxZoGLwhdAHAwgcOcLmknfiTyEG61tb6DIsDtmXhbG7tcVXM9IRMGkVrLvwv970
	BZ/TjXTFvCTTDSCQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu/intel: Limit the non-architectural
 constant_tsc model checks
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-14-sohil.mehta@intel.com>
References: <20250219184133.816753-14-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221720.14745.16806760574929871708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fadb6f569b10bf668677add876ed50586931b8f3
Gitweb:        https://git.kernel.org/tip/fadb6f569b10bf668677add876ed50586931b8f3
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:31 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:56 +01:00

x86/cpu/intel: Limit the non-architectural constant_tsc model checks

X86_FEATURE_CONSTANT_TSC is a Linux-defined, synthesized feature flag.
It is used across several vendors. Intel CPUs will set the feature when
the architectural CPUID.80000007.EDX[1] bit is set. There are also some
Intel CPUs that have the X86_FEATURE_CONSTANT_TSC behavior but don't
enumerate it with the architectural bit.  Those currently have a model
range check.

Today, virtually all of the CPUs that have the CPUID bit *also* match
the "model >= 0x0e" check. This is confusing. Instead of an open-ended
check, pick some models (INTEL_IVYBRIDGE and P4_WILLAMETTE) as the end
of goofy CPUs that should enumerate the bit but don't.  These models are
relatively arbitrary but conservative pick for this.

This makes it obvious that later CPUs (like Family 18+) no longer need
to synthesize X86_FEATURE_CONSTANT_TSC.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250219184133.816753-14-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/intel.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 2181304..4cbb2e6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -201,10 +201,6 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
 
-	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
-		(c->x86 == 0x6 && c->x86_model >= 0x0e))
-		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
-
 	if (c->x86 >= 6 && !cpu_has(c, X86_FEATURE_IA64))
 		c->microcode = intel_get_microcode_revision();
 
@@ -257,10 +253,16 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	 *
 	 * It is also reliable across cores and sockets. (but not across
 	 * cabinets - we turn it off in that case explicitly.)
+	 *
+	 * Use a model-specific check for some older CPUs that have invariant
+	 * TSC but may not report it architecturally via 8000_0007.
 	 */
 	if (c->x86_power & (1 << 8)) {
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
+	} else if ((c->x86_vfm >= INTEL_P4_PRESCOTT && c->x86_vfm <= INTEL_P4_WILLAMETTE) ||
+		   (c->x86_vfm >= INTEL_CORE_YONAH  && c->x86_vfm <= INTEL_IVYBRIDGE)) {
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
 	}
 
 	/* Penwell and Cloverview have the TSC which doesn't sleep on S3 */

