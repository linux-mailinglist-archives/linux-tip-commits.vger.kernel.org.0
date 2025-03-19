Return-Path: <linux-tip-commits+bounces-4345-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15100A68AAE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12B2460021
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727402580C7;
	Wed, 19 Mar 2025 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GfE5GVqt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/o/lqdog"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDE257426;
	Wed, 19 Mar 2025 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382224; cv=none; b=k3Vm4ZNJ+6+jxhArBRanGwN6B4XWwqzC51ERBAl4G87fJU2ps4ifu0dY9i7n9seiS7L49qnhz8Mpbsk1dGS//s3OoPKRf7AWtSiQJ7a3RsyFhinFXOsjWcihBrDx90HhcfVcDllSfkYpfeOV8qVslOolBE8V651RU1Wo7n6UubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382224; c=relaxed/simple;
	bh=ZE9+I2WuB+pFnOGj/yM28aY9AoaJxSVHC0sVdtPxlXE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ds4GqdReJ6GvzIBm5y4g5bBtHPPTWICCCTAzFKk48vNlWBQzk/Mj1vbn3LBiRkAKIGgzpzI84Pw2qcEXT+c+Pq2li6je+7lXB2Td4kQaDysgvx8k88QH3xorruysBGJZ4YzRTWODaBeiUL48fuYjguDDDRWavCSD4SB5CuLz5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GfE5GVqt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/o/lqdog; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgRrl8wuj6larOKmpZ+KqvoNef8DEU7e/IGjx1rvkDQ=;
	b=GfE5GVqtUtFRTEmxkuFWi9H9HMYFqVFuLgw+n+5OrWcbeUx/GFZTiSiexdX8gy3TXbk1Ai
	jo480nKmv1KeIYNGBIbG8q2vetDzxHvS2Mirj4KH1mU8hxNgVlWFhbe5R4Yg4qk+w1qZ+C
	i3KYTOa8LeursLNRvoJeoeNSslkwEpGhDjDa5g28TXtJ93dN22mko32oripdTX/ww16PKb
	jpd9TGB7QBekverf6ahv5sQ1jAr+V634m8/ALhE+F48GPHVSUYmBQePmHLY0Z/pFM77WUB
	c6ayKvuIPuWc+WWkJ5/ym16C/vgxLxox36VqsdB1yMkBzXYcmSc31LOrooMYEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgRrl8wuj6larOKmpZ+KqvoNef8DEU7e/IGjx1rvkDQ=;
	b=/o/lqdogt9v/K5UAz5NgOnQ8zjA0tVNIwM6SKZa3mPN+sxucbZa0fuaUfh0ZB29kKJOiPt
	9a006efAD1u3/cAg==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/acpi/cstate: Improve Intel Family model checks
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
Message-ID: <174238222026.14745.3924876296977608633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     337959860dbb02120a029dcd169a26ae596c92ee
Gitweb:        https://git.kernel.org/tip/337959860dbb02120a029dcd169a26ae596c92ee
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:26 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:46 +01:00

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

