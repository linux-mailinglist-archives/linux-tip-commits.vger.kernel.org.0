Return-Path: <linux-tip-commits+bounces-2679-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AC9B8324
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 20:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C2E1F22958
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 19:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF711A726F;
	Thu, 31 Oct 2024 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jbvunouG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D1YHTUUc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B524F347C7;
	Thu, 31 Oct 2024 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402111; cv=none; b=sWLxo05Ke1ADIJlDIck3+jv4TXRYz8d/W7AuUE5iIF3/Cx7H6N3e85XiOFJccfvao4YfsqJREX3lGiceN+jJPpT8JjIATZlVY1SftuKMZ75qEKRqL4WTbs7P64YkeJe13x9HKbz10saaijHSJDc574WDUXIv10/6bG4Tp5Twyg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402111; c=relaxed/simple;
	bh=a9zdZQVhyhietWCzukDywxWWXo7tU+BDB0BdBCgRcTM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Pl+CmPUnzzEOgYOVUqMwR0UCYs6PllSPJF4y7vRz4v5BUJ32sWZzJ58o7rOSuRca6r+JU15xOm+oUCMtIooDsSfRgPo7UeP+p+kJici2gTE8FrWMjoYfPcEHVjcek3HYfmliU+sdUsoKRj91qDabyY2jFBce/Y/yeiZZFWzBzn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jbvunouG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D1YHTUUc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 19:15:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730402106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xbsNjuZ+1drHrTtwHznaQPv1UpzwFIOh1lASH+nXJmE=;
	b=jbvunouGyPZOput6dpWXduQGK4abMWnEs30p3vQYayR7IboktOAdKpywtsfz7JpTODZJDE
	/tSGoz4j/jsRKQeLr6DfgKNbUqJpTn3wACZ/APjin88iVXNtD1BdwmAtzKpIcakVMFooLp
	DY2kcwhw3yweJWu4XAhqZENaNh4+JOuGxRdjI3HHBCMcbujrvdOVERZ3is6cJR9RzFpxAd
	BoufbYP6Z5uNzq04T1I7pr8d0oX09qEM/zJR4XEblElxnoxNjobWXE144jJCT0lop0/m4f
	+p2TbQLjkrofT+fmHREtBFACxt4xVfbDjMQueJD1CRYv43CA00HGQvKDixuLvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730402106;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xbsNjuZ+1drHrTtwHznaQPv1UpzwFIOh1lASH+nXJmE=;
	b=D1YHTUUcNT4ZNfILP38PTusfV/zZ/GvSxRZi7QcjBkJcLRS8Qn+euTmkk8DCOb+NsV10cq
	U341lHFIDmt5n3Dw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Fix FAM5_QUARK_X1000 to use X86_MATCH_VFM()
Cc: Tony Luck <tony.luck@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173040210499.3137.9772207552880255501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     110213b8f0e7021819d4db273facb27701bc3381
Gitweb:        https://git.kernel.org/tip/110213b8f0e7021819d4db273facb27701bc3381
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 31 Oct 2024 11:57:33 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 31 Oct 2024 12:02:21 -07:00

x86/cpu: Fix FAM5_QUARK_X1000 to use X86_MATCH_VFM()

This family 5 CPU escaped notice when cleaning up all the family 6
CPUs.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241031185733.17327-1-tony.luck%40intel.com
---
 arch/x86/include/asm/intel-family.h             | 1 -
 arch/x86/platform/efi/quirks.c                  | 3 +--
 arch/x86/platform/intel-quark/imr.c             | 2 +-
 arch/x86/platform/intel-quark/imr_selftest.c    | 2 +-
 drivers/thermal/intel/intel_quark_dts_thermal.c | 2 +-
 5 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 7367644..6d7b04f 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -177,7 +177,6 @@
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
 /* Family 5 */
-#define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
 /* Family 19 */
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc000..846bf49 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -656,8 +656,7 @@ static int qrk_capsule_setup_info(struct capsule_info *cap_info, void **pkbuff,
 }
 
 static const struct x86_cpu_id efi_capsule_quirk_ids[] = {
-	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000,
-				   &qrk_capsule_setup_info),
+	X86_MATCH_VFM(INTEL_QUARK_X1000, &qrk_capsule_setup_info),
 	{ }
 };
 
diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index d3d4569..ee25b03 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -569,7 +569,7 @@ static void __init imr_fixup_memmap(struct imr_device *idev)
 }
 
 static const struct x86_cpu_id imr_ids[] __initconst = {
-	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000, NULL),
+	X86_MATCH_VFM(INTEL_QUARK_X1000, NULL),
 	{}
 };
 
diff --git a/arch/x86/platform/intel-quark/imr_selftest.c b/arch/x86/platform/intel-quark/imr_selftest.c
index 84ba715..657925b 100644
--- a/arch/x86/platform/intel-quark/imr_selftest.c
+++ b/arch/x86/platform/intel-quark/imr_selftest.c
@@ -105,7 +105,7 @@ static void __init imr_self_test(void)
 }
 
 static const struct x86_cpu_id imr_ids[] __initconst = {
-	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000, NULL),
+	X86_MATCH_VFM(INTEL_QUARK_X1000, NULL),
 	{}
 };
 
diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 47296a1..89498eb 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -401,7 +401,7 @@ err_ret:
 }
 
 static const struct x86_cpu_id qrk_thermal_ids[] __initconst  = {
-	X86_MATCH_VENDOR_FAM_MODEL(INTEL, 5, INTEL_FAM5_QUARK_X1000, NULL),
+	X86_MATCH_VFM(INTEL_QUARK_X1000, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, qrk_thermal_ids);

