Return-Path: <linux-tip-commits+bounces-6820-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26818BDFC2C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 18:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BAAD19A7ECA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918EC33EAF5;
	Wed, 15 Oct 2025 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dvdt0I3z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5rKn/WR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0C333CEAE;
	Wed, 15 Oct 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547146; cv=none; b=tLPExFrDdLDCoHn9bWb+XS7zEyVJRhgQn6Ma9l1L0NJu5EbuOuyEwL0rELBn5GKm3t9KDjvSBzLSXmoR3lmMJQdXqSXatyajev3x9WWZLZj6BRvQOS0D0GQtarKr5ZgcEs6SAG0vRZfebYtBTF81GBtosiXmbPndBi4x1bzQkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547146; c=relaxed/simple;
	bh=pUmsdKuAaRqaXjsorztxq71Pb1kxuhmeCQIkVmIkAtk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WdayJEQWNmw3xYxM6mF8deHgNuKDJ8A0L3Cy1S3hc9vz0id3e/pYynw+2IHMKrBQDDrG6deF+o3BEO7EeYGVBea7KxwEnlQOJ7GUgMm8j63cVpOrumFvpQME7+KuZulrTXlQg5sTqbg5Bb46JEyWNcc9ZfgIsulYnE6jysgArtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dvdt0I3z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5rKn/WR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 16:52:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760547143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWlroYMp53RM7QmspvGwuCnWczlanVr1dmAQFd71g0s=;
	b=dvdt0I3zvXCJw6vQGWNxYGHkzMx9NiwWToZYgTM415XkUvChQ0Nokvg59COJUsQt7gywhp
	t3mVKdU8nIAzAwq6BkQ0efEe60hVVB8j46shx7pwAziATBSG+Mttv3OFQez4Acb78z8G1a
	xRlRWjflDTKA/cNmXsNS/e0RgA9WApjSwcEiWwoIVAp2LZVb/pLJn3oJ+Q9mzqP/P3NGHg
	Nxl9u8Ys/KATzrXQeEX+qbOwSc7zAoFKXuLpulfLcGIozV9E7G60y54bYEMsgcx9ePAaH8
	FKMp7vfQbGCJBIncTYtnkXb/yNRUqEkSS2zjebfuGttfInAauXoGca2fuDtp3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760547143;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWlroYMp53RM7QmspvGwuCnWczlanVr1dmAQFd71g0s=;
	b=G5rKn/WR+9nK3fkhBJ6gXRY5/9GMK1OcASduZI0xESNnx0j50pTBBNCr6snsm0WAmrTZvt
	RDlY4UkJfu+TwrBg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/microcode] x86/microcode/intel: Establish staging control logic
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Anselm Busse <abusse@amazon.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250921224841.3545-4-chang.seok.bae@intel.com>
References: <20250921224841.3545-4-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176054714162.709179.16748486101128898411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     740144bc6bde9d44e3a6c224cee6fe971a08fbca
Gitweb:        https://git.kernel.org/tip/740144bc6bde9d44e3a6c224cee6fe971a0=
8fbca
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Sun, 21 Sep 2025 15:48:37 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Oct 2025 16:47:20 +02:00

x86/microcode/intel: Establish staging control logic

When microcode staging is initiated, operations are carried out through
an MMIO interface. Each package has a unique interface specified by the
IA32_MCU_STAGING_MBOX_ADDR MSR, which maps to a set of 32-bit registers.

Prepare staging with the following steps:

  1.  Ensure the microcode image is 32-bit aligned to match the MMIO
      register size.

  2.  Identify each MMIO interface based on its per-package scope.

  3.  Invoke the staging function for each identified interface, which
      will be implemented separately.

  [ bp: Improve error logging. ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Link: https://lore.kernel.org/all/871pznq229.ffs@tglx
---
 arch/x86/include/asm/msr-index.h      |  2 +-
 arch/x86/kernel/cpu/microcode/intel.c | 51 ++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index 9e1720d..2b4560b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1226,6 +1226,8 @@
 #define MSR_IA32_VMX_VMFUNC             0x00000491
 #define MSR_IA32_VMX_PROCBASED_CTLS3	0x00000492
=20
+#define MSR_IA32_MCU_STAGING_MBOX_ADDR	0x000007a5
+
 /* Resctrl MSRs: */
 /* - Intel: */
 #define MSR_IA32_L3_QOS_CFG		0xc81
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index 371ca6e..216595a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -299,6 +299,56 @@ static __init struct microcode_intel *scan_microcode(voi=
d *data, size_t size,
 	return size ? NULL : patch;
 }
=20
+/*
+ * Handle the staging process using the mailbox MMIO interface.
+ * Return 0 on success or an error code on failure.
+ */
+static int do_stage(u64 mmio_pa)
+{
+	pr_debug_once("Staging implementation is pending.\n");
+	return -EPROTONOSUPPORT;
+}
+
+static void stage_microcode(void)
+{
+	unsigned int pkg_id =3D UINT_MAX;
+	int cpu, err;
+	u64 mmio_pa;
+
+	if (!IS_ALIGNED(get_totalsize(&ucode_patch_late->hdr), sizeof(u32))) {
+		pr_err("Microcode image 32-bit misaligned (0x%x), staging failed.\n",
+			get_totalsize(&ucode_patch_late->hdr));
+		return;
+	}
+
+	lockdep_assert_cpus_held();
+
+	/*
+	 * The MMIO address is unique per package, and all the SMT
+	 * primary threads are online here. Find each MMIO space by
+	 * their package IDs to avoid duplicate staging.
+	 */
+	for_each_cpu(cpu, cpu_primary_thread_mask) {
+		if (topology_logical_package_id(cpu) =3D=3D pkg_id)
+			continue;
+
+		pkg_id =3D topology_logical_package_id(cpu);
+
+		err =3D rdmsrq_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
+		if (WARN_ON_ONCE(err))
+			return;
+
+		err =3D do_stage(mmio_pa);
+		if (err) {
+			pr_err("Error: staging failed (%d) for CPU%d at package %u.\n",
+			       err, cpu, pkg_id);
+			return;
+		}
+	}
+
+	pr_info("Staging of patch revision 0x%x succeeded.\n", ucode_patch_late->hd=
r.rev);
+}
+
 static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 					  struct microcode_intel *mc,
 					  u32 *cur_rev)
@@ -627,6 +677,7 @@ static struct microcode_ops microcode_intel_ops =3D {
 	.collect_cpu_info	=3D collect_cpu_info,
 	.apply_microcode	=3D apply_microcode_late,
 	.finalize_late_load	=3D finalize_late_load,
+	.stage_microcode	=3D stage_microcode,
 	.use_nmi		=3D IS_ENABLED(CONFIG_X86_64),
 };
=20

