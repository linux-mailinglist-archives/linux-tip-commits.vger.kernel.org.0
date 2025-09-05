Return-Path: <linux-tip-commits+bounces-6491-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0D4B456AC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 13:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB49B7B3BA4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7758734A30B;
	Fri,  5 Sep 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EWLw1aMk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyuYz91u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9BF34575B;
	Fri,  5 Sep 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072453; cv=none; b=h/axYBeMj21BDFu37JutZ9YgU+naG2U3L+lrlkRkIdssqsfZQx5ZwIVlVLwhoFi2Q478YzO4ZIF9ez9QcwwrKvrV14Z9ZMsn8Fmlq7JddQUvwzykYiisYFuAA/SNLZxf6QPKq+pGsXwaA8GHx4jNpZzhdyCmXtclg3TGEam29uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072453; c=relaxed/simple;
	bh=0l5h1L54cfbK3i80XepW0rPAQ5gtW/i/TQrBzzs3BZ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZWaj9KTUFlyaPOk5DrljVzz3fQgDKXDuLLMNmpCsSWC+ako2QzmIow8pUDallkvzE2wvCeR0Ywm27QmXwGhptRHM0fD9EOemf6Ladm/BnI37eebpu1+YMLobMPWNIbbk3VVRsgpIHQ7FN3aylBIu5CV8zVfepyLy8Hcqf6a8AJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EWLw1aMk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyuYz91u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 11:40:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757072450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZJF7UT8fxZ03IF9LqDR7CiAdtmi8tynRC9FDXeQV+I=;
	b=EWLw1aMk7G02sijdvUY+SEjginJYR/8EKhf24B6WoVwwEnqmMLIwrIFl8JffW3hTlhV+5e
	DmHy8uIUoZotwGAvaNW3kZxHiLxpikhRRDAjteokZJodj/l57/jEAOFGFdYCC+e+L2Ir0D
	Vz0fG14IyTYc2NSUfzO8Pc5pZlI6W8iJRuiMYlqIByshYANv0eYH5yDqyDuZzWAMuzwiA/
	d627dLh530ahLGiWeAglU5uOTBFRS6yjb7bFi0a+ijtyjMKkwU8I10RPkL17LWmMNvuhGY
	CheAeE9CLJMyppvzCCITHTqJWdVZFD6lNyGTRtJl8eJXH/KbL0ac0cm8Qx3YCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757072450;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZJF7UT8fxZ03IF9LqDR7CiAdtmi8tynRC9FDXeQV+I=;
	b=WyuYz91uPAAxumr48LIxg5jMltRPG05g5tT0BqaYLTRuoxe5pwcxkTvA1gBy4oFGBeQUsd
	vaPk2OV+mSKAFcCw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Remove smca_banks_map
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250825-wip-mca-updates-v5-3-865768a2eef8@amd.com>
References: <20250825-wip-mca-updates-v5-3-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175707244869.1920.12079373882875716405.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     b249288abde5190bb113ea5acef8af4ceac4957c
Gitweb:        https://git.kernel.org/tip/b249288abde5190bb113ea5acef8af4ceac=
4957c
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 25 Aug 2025 17:33:00=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 05 Sep 2025 12:41:48 +02:00

x86/mce/amd: Remove smca_banks_map

The MCx_MISC0[BlkPtr] field was used on legacy systems to hold a register
offset for the next MCx_MISC* register. In this way, an implementation-specif=
ic
number of registers can be discovered at runtime.

The MCAX/SMCA register space simplifies this by always including the
MCx_MISC[1-4] registers. The MCx_MISC0[BlkPtr] field is used to indicate
(true/false) whether any MCx_MISC[1-4] registers are present.

Currently, MCx_MISC0[BlkPtr] is checked early and cached to be used during
sysfs init later. This is unnecessary as the MCx_MISC0 register is read again
later anyway.

Remove the smca_banks_map variable as it is effectively redundant, and use
a direct register/bit check instead.

  [ bp: Zap smca_get_block_address() too. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250825-wip-mca-updates-v5-3-865768a2eef8@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 50 ++++++----------------------------
 1 file changed, 9 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f429451..7e36bc0 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -252,9 +252,6 @@ static DEFINE_PER_CPU(struct threshold_bank **, threshold=
_banks);
  */
 static DEFINE_PER_CPU(u64, bank_map);
=20
-/* Map of banks that have more than MCA_MISC0 available. */
-static DEFINE_PER_CPU(u64, smca_misc_banks_map);
-
 static void amd_threshold_interrupt(void);
 static void amd_deferred_error_interrupt(void);
=20
@@ -264,28 +261,6 @@ static void default_deferred_error_interrupt(void)
 }
 void (*deferred_error_int_vector)(void) =3D default_deferred_error_interrupt;
=20
-static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
-{
-	u32 low, high;
-
-	/*
-	 * For SMCA enabled processors, BLKPTR field of the first MISC register
-	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
-	 */
-	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
-		return;
-
-	if (!(low & MCI_CONFIG_MCAX))
-		return;
-
-	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high))
-		return;
-
-	if (low & MASK_BLKPTR_LO)
-		per_cpu(smca_misc_banks_map, cpu) |=3D BIT_ULL(bank);
-
-}
-
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
 	u8 *bank_counts =3D this_cpu_ptr(smca_bank_counts);
@@ -326,8 +301,6 @@ static void smca_configure(unsigned int bank, unsigned in=
t cpu)
 		wrmsr(smca_config, low, high);
 	}
=20
-	smca_set_misc_banks_map(bank, cpu);
-
 	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
 		pr_warn("Failed to read MCA_IPID for bank %d\n", bank);
 		return;
@@ -525,18 +498,6 @@ static void deferred_error_interrupt_enable(struct cpuin=
fo_x86 *c)
 	wrmsr(MSR_CU_DEF_ERR, low, high);
 }
=20
-static u32 smca_get_block_address(unsigned int bank, unsigned int block,
-				  unsigned int cpu)
-{
-	if (!block)
-		return MSR_AMD64_SMCA_MCx_MISC(bank);
-
-	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT_ULL(bank)))
-		return 0;
-
-	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
-}
-
 static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block,
 			     unsigned int cpu)
@@ -546,8 +507,15 @@ static u32 get_block_address(u32 current_addr, u32 low, =
u32 high,
 	if ((bank >=3D per_cpu(mce_num_banks, cpu)) || (block >=3D NR_BLOCKS))
 		return addr;
=20
-	if (mce_flags.smca)
-		return smca_get_block_address(bank, block, cpu);
+	if (mce_flags.smca) {
+		if (!block)
+			return MSR_AMD64_SMCA_MCx_MISC(bank);
+
+		if (!(low & MASK_BLKPTR_LO))
+			return 0;
+
+		return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
+	}
=20
 	/* Fall back to method we used for older processors: */
 	switch (block) {

