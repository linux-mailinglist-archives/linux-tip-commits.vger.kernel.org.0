Return-Path: <linux-tip-commits+bounces-2877-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F929D8403
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 12:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9D3284C96
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BE194AD1;
	Mon, 25 Nov 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bBri7Ghv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UsNZZG4E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B01922D3;
	Mon, 25 Nov 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732532676; cv=none; b=Q0xILwkYLIHVmSYVt9kb/dhg1faMzmyfOv5hf27Vx4alSHCiVWgYfVVpucfo1CM7mRE2qz7yriWl5mab6ZgXZ8w7BNifgyp+NrVhcM880KzbtKdQ0TbjbqKX2+E6ki7j26+ptfKTRVkRcVywagJe43OO2YpbJAGQAeCTmXf0K/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732532676; c=relaxed/simple;
	bh=qsVG0ysoMbR4HNjo7UbxrX2d++0DTjxkDQ1cb6WACdY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M6VjciwqNMorItbiqAP1CQKZdeFJ1NVd0GsPuq3mANJ1blKG2lMGp3WPYG6pjFV8P9n4Ic8lyyGip1IxWWyDEl4b3pQK634MQD7Tf8HaEIviwgpVSUXR23J90WRZmcyIaV6hTzHD3+lkSSK/krfoFbOzUSga8rtzURa2F3PpYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bBri7Ghv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UsNZZG4E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Nov 2024 11:04:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732532673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8tw1ITcV+QmPCAFP+JmyQOE4a+ohfXuSGEgFhzex9I=;
	b=bBri7Ghv0Inc2EVHa6/jCG92zGCHHafhUSD0O956d9pnU4u+IHPx5UjabRPUrIspkJCPK6
	yPqr2NNwAaxO4YJuq678HJr/Erkxlm3uCoe8qvArZDmmktv/7WERMDTU5HA3/QXZGXM3/Q
	Ki1EQs4ynOp2sSQ5jiNcFC3WDvpbjcKdLlIsoI6lv2VEnhtpD3d3dRQM2Bz/ADvp7xjp6+
	GtbmRnmBqwtru/QqJR/VexHkJatqxcLKq23+x4H/65i2VXXGEm1IYH6aRsDz8Bl8sEHofg
	js0gJtO4heImPzQxXCU+iQC/O8I8+Sk+RZPs8LYR0wkYhLXnmNkqzGhllEDFow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732532673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8tw1ITcV+QmPCAFP+JmyQOE4a+ohfXuSGEgFhzex9I=;
	b=UsNZZG4Ef31YcRd2DL6WKCfemOHT6Gyw7KH3GOUjREtIrGJZCmZNJAooYSneJnsDdhAqhj
	XBuoomhE5vmwohDw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Flush patch buffer mapping after
 application
Cc: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ZyulbYuvrkshfsd2@antipodes>
References: <ZyulbYuvrkshfsd2@antipodes>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173253267217.412.15197181691016042037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c809b0d0e52d01c30066367b2952c4c4186b1047
Gitweb:        https://git.kernel.org/tip/c809b0d0e52d01c30066367b2952c4c4186b1047
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 19 Nov 2024 12:21:33 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 25 Nov 2024 11:43:21 +01:00

x86/microcode/AMD: Flush patch buffer mapping after application

Due to specific requirements while applying microcode patches on Zen1
and 2, the patch buffer mapping needs to be flushed from the TLB after
application. Do so.

If not, unnecessary and unnatural delays happen in the boot process.

Reported-by: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: <stable@kernel.org> # f1d84b59cbb9 ("x86/mm: Carve out INVLPG inline asm for use by others")
Link: https://lore.kernel.org/r/ZyulbYuvrkshfsd2@antipodes
---
 arch/x86/kernel/cpu/microcode/amd.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 31a7371..fb5d0c6 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -34,6 +34,7 @@
 #include <asm/setup.h>
 #include <asm/cpu.h>
 #include <asm/msr.h>
+#include <asm/tlb.h>
 
 #include "internal.h"
 
@@ -483,11 +484,25 @@ static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 	}
 }
 
-static int __apply_microcode_amd(struct microcode_amd *mc)
+static int __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
 {
+	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
 	u32 rev, dummy;
 
-	native_wrmsrl(MSR_AMD64_PATCH_LOADER, (u64)(long)&mc->hdr.data_code);
+	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
+
+	if (x86_family(bsp_cpuid_1_eax) == 0x17) {
+		unsigned long p_addr_end = p_addr + psize - 1;
+
+		invlpg(p_addr);
+
+		/*
+		 * Flush next page too if patch image is crossing a page
+		 * boundary.
+		 */
+		if (p_addr >> PAGE_SHIFT != p_addr_end >> PAGE_SHIFT)
+			invlpg(p_addr_end);
+	}
 
 	/* verify patch application was successful */
 	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
@@ -529,7 +544,7 @@ static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
 	if (old_rev > mc->hdr.patch_id)
 		return ret;
 
-	return !__apply_microcode_amd(mc);
+	return !__apply_microcode_amd(mc, desc.psize);
 }
 
 static bool get_builtin_microcode(struct cpio_data *cp)
@@ -745,7 +760,7 @@ void reload_ucode_amd(unsigned int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc))
+		if (!__apply_microcode_amd(mc, p->size))
 			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
 	}
 }
@@ -798,7 +813,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 		goto out;
 	}
 
-	if (__apply_microcode_amd(mc_amd)) {
+	if (__apply_microcode_amd(mc_amd, p->size)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;

