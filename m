Return-Path: <linux-tip-commits+bounces-3379-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82DA37D75
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 09:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C51188F6B8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC019E7FA;
	Mon, 17 Feb 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Efw7VMvw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JD5SmDy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC391922E6;
	Mon, 17 Feb 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782318; cv=none; b=s9JyfzWrC6JLnqDqdJZUHdksjW5oNnJv6USC9pijhGE1CzGdB3IsFPFlq2FQvxQDeecUm9OkOryefYN+9PLqeup9WZjpMI4V42Q4rgBIUKOsOifAO8myw7+fBQz4L9+CL6ArvoE7vXHy4CEtOIcPg51u3C6Km8Wn4AAN/Ep+kZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782318; c=relaxed/simple;
	bh=XVDpuTATIh10USI6bnJWGS2r2U9xMRCvtkmfGknczTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KLAYoJceRvX7fXiJZYhrcpkbg01G1Kc8mUh/IRubyfAkY35bbvkeB7bQPsylxi+JeMfDB25MXHQBGIE2X3aDYYodCgCvqCy5Taqp8lr1Hjww5XSA4UfzrNjOOrRxm3AtzB3lhMVdVEAkL923u40BOKf+5erCAbe+MS37D/4ipvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Efw7VMvw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4JD5SmDy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 08:51:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739782314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0luJkl6iVMPP5T9MAJWiuwX+a7IeT/3wTbILKcF8f8=;
	b=Efw7VMvwKbeeROppsFGnmIV+gH+8+c5KPOEYXtcH02epPWCU2HA9vZsXRLH86dAMONieot
	8C+2Xi5SXO31IxxVSvVHkARm40jg0tGl5x24afFulnoaiqk9RUEmM7ioZoFnxguNH1gXAu
	K7VcPDJcWVLL41R9C7g81R7LNb9RTlPMyBgJHKp4wk5D1eXY3DtBaBv4JSLDtqPYiWb8Vh
	0ZOHIEl7FVEE5TyEVYW9d2OhN3fobNPIoRxsjjP66u6V5/Hw4IQ+rzlb3MN9DEhY7CEy+i
	BNHm3iTtzFh8EEaEKb5NlP4gLgEPiUYr7qH1uWmy70V+KJOkbSEY+/lOxu6Djg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739782314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0luJkl6iVMPP5T9MAJWiuwX+a7IeT/3wTbILKcF8f8=;
	b=4JD5SmDyIdnpqQ5lmr2TdALUqojRK0qExfv5SihXEt47uKA5n3NAxjoXwtr4ZoboQhBBbW
	6+c1Yk8JWKb5O1Aw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Add get_patch_level()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211163648.30531-6-bp@kernel.org>
References: <20250211163648.30531-6-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173978231016.10177.16561489698038568549.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     037e81fb9d2dfe7b31fd97e5f578854e38f09887
Gitweb:        https://git.kernel.org/tip/037e81fb9d2dfe7b31fd97e5f578854e38f09887
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 23 Jan 2025 13:02:32 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Feb 2025 09:42:40 +01:00

x86/microcode/AMD: Add get_patch_level()

Put the MSR_AMD64_PATCH_LEVEL reading of the current microcode revision
the hw has, into a separate function.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250211163648.30531-6-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 46 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index adfea4d..31f90e1 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -145,6 +145,15 @@ ucode_path[] __maybe_unused = "kernel/x86/microcode/AuthenticAMD.bin";
  */
 static u32 bsp_cpuid_1_eax __ro_after_init;
 
+static u32 get_patch_level(void)
+{
+	u32 rev, dummy __always_unused;
+
+	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
+
+	return rev;
+}
+
 static union cpuid_1_eax ucode_rev_to_cpuid(unsigned int val)
 {
 	union zen_patch_rev p;
@@ -483,10 +492,10 @@ static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 	}
 }
 
-static bool __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
+static bool __apply_microcode_amd(struct microcode_amd *mc, u32 *cur_rev,
+				  unsigned int psize)
 {
 	unsigned long p_addr = (unsigned long)&mc->hdr.data_code;
-	u32 rev, dummy;
 
 	native_wrmsrl(MSR_AMD64_PATCH_LOADER, p_addr);
 
@@ -504,9 +513,8 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
 	}
 
 	/* verify patch application was successful */
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	if (rev != mc->hdr.patch_id)
+	*cur_rev = get_patch_level();
+	if (*cur_rev != mc->hdr.patch_id)
 		return false;
 
 	return true;
@@ -563,11 +571,12 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 	struct cont_desc desc = { };
 	struct microcode_amd *mc;
 	struct cpio_data cp = { };
-	u32 dummy;
+	u32 rev;
 
 	bsp_cpuid_1_eax = cpuid_1_eax;
 
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->old_rev, dummy);
+	rev = get_patch_level();
+	ed->old_rev = rev;
 
 	/* Needed in load_microcode_amd() */
 	ucode_cpu_info[0].cpu_sig.sig = cpuid_1_eax;
@@ -589,8 +598,8 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 	if (ed->old_rev > mc->hdr.patch_id)
 		return;
 
-	if (__apply_microcode_amd(mc, desc.psize))
-		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
+	if (__apply_microcode_amd(mc, &rev, desc.psize))
+		ed->new_rev = rev;
 }
 
 static inline bool patch_cpus_equivalent(struct ucode_patch *p,
@@ -692,14 +701,9 @@ static void free_cache(void)
 static struct ucode_patch *find_patch(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	u32 rev, dummy __always_unused;
 	u16 equiv_id = 0;
 
-	/* fetch rev if not populated yet: */
-	if (!uci->cpu_sig.rev) {
-		rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-		uci->cpu_sig.rev = rev;
-	}
+	uci->cpu_sig.rev = get_patch_level();
 
 	if (x86_family(bsp_cpuid_1_eax) < 0x17) {
 		equiv_id = find_equiv_id(&equiv_table, uci->cpu_sig.sig);
@@ -722,22 +726,20 @@ void reload_ucode_amd(unsigned int cpu)
 
 	mc = p->data;
 
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
+	rev = get_patch_level();
 	if (rev < mc->hdr.patch_id) {
-		if (__apply_microcode_amd(mc, p->size))
-			pr_info_once("reload revision: 0x%08x\n", mc->hdr.patch_id);
+		if (__apply_microcode_amd(mc, &rev, p->size))
+			pr_info_once("reload revision: 0x%08x\n", rev);
 	}
 }
 
 static int collect_cpu_info_amd(int cpu, struct cpu_signature *csig)
 {
-	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct ucode_patch *p;
 
 	csig->sig = cpuid_eax(0x00000001);
-	csig->rev = c->microcode;
+	csig->rev = get_patch_level();
 
 	/*
 	 * a patch could have been loaded early, set uci->mc so that
@@ -778,7 +780,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 		goto out;
 	}
 
-	if (!__apply_microcode_amd(mc_amd, p->size)) {
+	if (!__apply_microcode_amd(mc_amd, &rev, p->size)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return UCODE_ERROR;

