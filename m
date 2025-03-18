Return-Path: <linux-tip-commits+bounces-4312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E879DA67C56
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEE817DE3A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764BE213E62;
	Tue, 18 Mar 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RZ450KV7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LIQjVCtX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D607F2135CE;
	Tue, 18 Mar 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324077; cv=none; b=OiM2sCvXV54WH1oOUnVghSnwNwMXJrHF7WgNrduV3alTglyw6PPH8kTubP1bnClLIwjRKXA8VtbHtr+xElZtLDhwKY72ts4N+oI89IMVP7nc5QaB0W+jrSyKuAfG7NwQTQyGdgt++KH/FWoWjHN/ZKIRdEUzePatjZ5YbcAnGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324077; c=relaxed/simple;
	bh=QZ6GILKvMFcCbXNL1gQ7y3HG1yLsFyf+EebYAhM7Hcc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZTQ+JTOrEgtvZ3f5RWiyN7U+8lA3/ZPkglgMU7dJOiQeNRl0+FxUh611H7cMHxvLtImaSD5lCvP2RvLDNeMs8xKdudVHY2Chgp9mnDtnzWNFTsD6po7otHCh9b2nKL7FRFquWmw07g2uFkeKpCs6GZ3hzusCuYktT/TYZilDeAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RZ450KV7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LIQjVCtX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rna07MfP9IMuiZK9CZLY3f5uZg5GQNlu1vR3FOeGLw0=;
	b=RZ450KV7iF/AZSSMIvrxFnE4nhbp3GS1eYpGPc2cS1nQOXGPOcMn8jkX3ajavg/YfrxvZy
	Ta7mRQXKYGhdwc+/rReHjJsGP9npxnG0+lBMBhbwHxZw7NlCDCE0ZYxUiq3nzTU5LjOT6u
	S78q+HTAZLwPpEthowm57oQMn8qEFskoJI4cPWqP1qKA1hvAGbpdBJzSROwxO4zd5y7sXH
	dK0kYXOJB5ZZW9q96YP0I2UbXg9j+7oy8tUONnRbzrArQOtevOEu7Q2WWrPqCVnG3o4Tkr
	3oOG/dpBePfIqCyRqTFj50AiqU68Jaxu8mwzxsAQB2BjqFKjR1LbuJKP7wtZ1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rna07MfP9IMuiZK9CZLY3f5uZg5GQNlu1vR3FOeGLw0=;
	b=LIQjVCtXkVNj01qLHVZFnEBC18oBNGTqIXtx9bdkbikV6nrIhRNSGN7EsTUoyPI7jwWdPG
	PrONZ/ZFv2ysR1Bw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/mtrr: Modify a x86_model check to an Intel VFM check
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-5-sohil.mehta@intel.com>
References: <20250219184133.816753-5-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232407313.14745.14361930258700243323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     23c905f7ec9d8dc3016fa4e3a9f321a920583b60
Gitweb:        https://git.kernel.org/tip/23c905f7ec9d8dc3016fa4e3a9f321a920583b60
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:22 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:45 +01:00

x86/mtrr: Modify a x86_model check to an Intel VFM check

Simplify one of the last few Intel x86_model checks in arch/x86 by
substituting it with a VFM one.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-5-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/mtrr/generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 6be3cad..e2c6b47 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -13,6 +13,7 @@
 #include <asm/processor-flags.h>
 #include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
+#include <asm/cpu_device_id.h>
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/tlbflush.h>
@@ -1026,8 +1027,7 @@ int generic_validate_add_page(unsigned long base, unsigned long size,
 	 * For Intel PPro stepping <= 7
 	 * must be 4 MiB aligned and not touch 0x70000000 -> 0x7003FFFF
 	 */
-	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86 == 6 &&
-	    boot_cpu_data.x86_model == 1 &&
+	if (mtrr_if == &generic_mtrr_ops && boot_cpu_data.x86_vfm == INTEL_PENTIUM_PRO &&
 	    boot_cpu_data.x86_stepping <= 7) {
 		if (base & ((1 << (22 - PAGE_SHIFT)) - 1)) {
 			pr_warn("mtrr: base(0x%lx000) is not 4 MiB aligned\n", base);

