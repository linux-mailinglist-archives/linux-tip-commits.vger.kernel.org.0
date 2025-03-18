Return-Path: <linux-tip-commits+bounces-4308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7C8A67C50
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1010C16FD79
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 18:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6E213237;
	Tue, 18 Mar 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5tSYchF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MH5qmQ0z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAD81CF5E2;
	Tue, 18 Mar 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324073; cv=none; b=c8ckkVkX8ns1f2oBO3w06CW/k/22jjVkTRT3/lkbfLEvcUTFOx+3dW3jSx/iA5U4ssRAEXlu0XUiCAmveC9EnFYxnUQr537AX+cnOXEWV7j1Sm4AATOVlMdQG+ZqWzXKoLYYe2bJyfZgImUVBx7vWanIOxrUX9x/01lU0+nra5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324073; c=relaxed/simple;
	bh=RQF+3+QluoOE9xh/xpf85D7pAjEi+CJS1tAxC/aegEU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rJn+VUn2RQq7JDcnMfst32vjRGWjjvTx/brjd/kXRSB5U4u72WWXmX3FbBJM2u09Ck1PMNCB9dhRO+HGCoMp3rsp1R2yyGd6Yn0wom/P45K1KHMuAfgWkuK/NXS0Ll7mtJ536XCewYIq8lsS9hMxOVoyE709R39fx2ztvXIM4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5tSYchF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MH5qmQ0z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElHMKI0yEYw2RstMpOhVZII+57QsVi7EACtaSvIo4+4=;
	b=S5tSYchFFbRjUaM9rFPxIzfGHBpW0b7g+7TOm4YMfu4elbxILqySHQTBXLIXGUGwiTlY+n
	oriNnRMI98B8Pzsg2vAoFMx4G4BLdQJk99jCL/zCQwm4G8SbwDLB5JwSrwjC6WawbqhRou
	KfFfNw4l/IaY50lmD5PRrBMjxI95DNsMNm9EDAHQt6diuKdekJl+wQIOMtvE7vFppgxvmU
	eJ5zRIDfHi9ZKNiZPp4bUyzdOnHJIHENw3ipTS6c5EdSiDfo6AokJFPofo2ZIGPGyg7nlN
	HMK950k/9dXpmrHVYZVovGuNOCrGpMYSZPqNpxT33LCJa5LD+Apcf8iXTSXBdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ElHMKI0yEYw2RstMpOhVZII+57QsVi7EACtaSvIo4+4=;
	b=MH5qmQ0zKDGPJ+pGwmca6sl0zZMysuYngnKy7CQzAaWCVP6VbR49Wthz73GtzRvdxxIw2A
	HFq5gnjv5OsSd8BA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/acpi/cstate: Improve Intel Family model checks
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-9-sohil.mehta@intel.com>
References: <20250219184133.816753-9-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232406995.14745.1531093518030939482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     38ed76e1aed9116dd549e3c6e3ab9581ff6dbd05
Gitweb:        https://git.kernel.org/tip/38ed76e1aed9116dd549e3c6e3ab9581ff6dbd05
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:26 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:46 +01:00

x86/acpi/cstate: Improve Intel Family model checks

Update the Intel Family checks to consistently use Family 15 instead of
Family 0xF. Also, get rid of one of last usages of x86_model by using
the new VFM checks.

Update the incorrect comment since the check has changed since the
initial commit:

  ee1ca48fae7e ("ACPI: Disable ARB_DISABLE on platforms where it is not needed")

The two changes were:

 - 3e2ada5867b7 ("ACPI: fix Compaq Evo N800c (Pentium 4m) boot hang regression")
   removed the P4 - Family 15.

 - 03a05ed11529 ("ACPI: Use the ARB_DISABLE for the CPU which model id is less than 0x0f.")
   got rid of CORE_YONAH - Family 6, model E.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-9-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h | 3 +++
 arch/x86/kernel/acpi/cstate.c       | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 4296c8e..51ea366 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -187,6 +187,9 @@
 #define INTEL_XEON_PHI_KNL		IFM(6, 0x57) /* Knights Landing */
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
+/* Notational marker denoting the last Family 6 model */
+#define INTEL_FAM6_LAST			IFM(6, 0xFF)
+
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index d255842..d5ac341 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 
 #include <acpi/processor.h>
+#include <asm/cpu_device_id.h>
 #include <asm/cpuid.h>
 #include <asm/mwait.h>
 #include <asm/special_insns.h>
@@ -48,12 +49,11 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
 	/*
 	 * On all recent Intel platforms, ARB_DISABLE is a nop.
 	 * So, set bm_control to zero to indicate that ARB_DISABLE
-	 * is not required while entering C3 type state on
-	 * P4, Core and beyond CPUs
+	 * is not required while entering C3 type state.
 	 */
 	if (c->x86_vendor == X86_VENDOR_INTEL &&
-	    (c->x86 > 0xf || (c->x86 == 6 && c->x86_model >= 0x0f)))
-			flags->bm_control = 0;
+	    (c->x86 > 15 || (c->x86_vfm >= INTEL_CORE2_MEROM && c->x86_vfm <= INTEL_FAM6_LAST)))
+		flags->bm_control = 0;
 
 	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
 		if (c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0x0f &&

