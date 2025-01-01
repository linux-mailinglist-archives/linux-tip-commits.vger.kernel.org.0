Return-Path: <linux-tip-commits+bounces-3155-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D099FF3DA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEEDD161B03
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 11:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B11E0E0B;
	Wed,  1 Jan 2025 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h7dQ5IcY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NQb1X0p+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AED713CA93;
	Wed,  1 Jan 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735731856; cv=none; b=Or6iSr+sAVuiZ1Ftc8+Cl0j8ZUQHw6X+I8ByFT9iL5oKc+SHwA7PXfS8Prbt94H7ChKquT/TSwkLGQPjqIfOVrSfTq9CTNnrYvwqTWeQnMSAf3Aj0KBCyZTpi1JDu/i3dYAxT31JRveJqhML3JX4z2shsttpFuIpRirQsyTL6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735731856; c=relaxed/simple;
	bh=gX+RocyAYNo59kJq36RuHq2wT30yzWtl2pCEwXFwlOw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qM9JK2Qwv3OtkE0kaqcHdbxJsyrewSEOU8dnedQU4QH0WnGUYCKICX09JN+0ZESVcLk25QcKNMj13XYBG2Wd33lgAkn/qDokW5h1UwiKmlphYyns5/wsy/8BbdlVLLsRywE5L1vuQdbJgJo8vYwLa4zJ/amFDoxVMqaeV6bXhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h7dQ5IcY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NQb1X0p+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 11:44:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735731848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDK8yvNkruxWy3Hzo5q58uAfPn3Of4icQfrtfItqSWk=;
	b=h7dQ5IcY3E8agJ/3huBkJu5FyofnIT/eX0GiVfx7TdZrDI2X6dwyw/ExCLDRUF6rEy63DY
	6ULgDRLVXA1QwSKBzNEiUu/6ciw9UTp7olWz8AgWs+8y6BNF9b1tpJC0/nWB2xPK6Tmnc0
	sOlTbFk5HiHpKLNuPyNwX39tT4Uozdc1PD1Ed2agwi2+pIk5yT1sYTv+IfzC6wv3oOhU8r
	qQIPcSJCI2Jyirtjn6Z9Czm8SXagpDKr4SlSJhIAC47CS0jPE2aqKuB+ckX2pg0PqM7uPL
	9vLSqKthqarxtfm/M9I2Sq6PfcKSO4X0ocN3elg+mZpBoN/zfGee+6P5Ioxnww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735731848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDK8yvNkruxWy3Hzo5q58uAfPn3Of4icQfrtfItqSWk=;
	b=NQb1X0p+VYMWpKs03iRbaAGX0r2xMuDJA2OzfFuKOQQ2e2ezkETg9X0yXo+PeXA8B0fqoE
	8kfqfS958rjf55Aw==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Convert family/model mixed checks to
 VFM-based checks
Cc: Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@intel.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241212140103.66964-6-qiuxu.zhuo@intel.com>
References: <20241212140103.66964-6-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573184786.399.17877739928527396215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     359d7a98e3e3f88dbf45411427b284bb3bbbaea5
Gitweb:        https://git.kernel.org/tip/359d7a98e3e3f88dbf45411427b284bb3bbbaea5
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Thu, 12 Dec 2024 22:01:01 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 11:11:08 +01:00

x86/mce: Convert family/model mixed checks to VFM-based checks

Convert family/model mixed checks to VFM-based checks to make the code
more compact. Simplify.

  [ bp: Drop the "what" from the commit message - it should be visible from
    the diff alone. ]

Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20241212140103.66964-6-qiuxu.zhuo@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3855ec2..f90cbcb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1936,7 +1936,7 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 	 * Various K7s with broken bank 0 around. Always disable
 	 * by default.
 	 */
-	if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
+	if (c->x86 == 6 && this_cpu_read(mce_num_banks))
 		mce_banks[0].ctl = 0;
 
 	/*
@@ -1954,6 +1954,10 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 
+	/* Older CPUs (prior to family 6) don't need quirks. */
+	if (c->x86_vfm < INTEL_PENTIUM_PRO)
+		return;
+
 	/*
 	 * SDM documents that on family 6 bank 0 should not be written
 	 * because it aliases to another special BIOS controlled
@@ -1962,22 +1966,21 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 	 * Don't ignore bank 0 completely because there could be a
 	 * valid event later, merely don't write CTL0.
 	 */
-	if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
+	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
 		mce_banks[0].init = false;
 
 	/*
 	 * All newer Intel systems support MCE broadcasting. Enable
 	 * synchronization with a one second timeout.
 	 */
-	if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
-	    mca_cfg.monarch_timeout < 0)
+	if (c->x86_vfm >= INTEL_CORE_YONAH && mca_cfg.monarch_timeout < 0)
 		mca_cfg.monarch_timeout = USEC_PER_SEC;
 
 	/*
 	 * There are also broken BIOSes on some Pentium M and
 	 * earlier systems:
 	 */
-	if (c->x86 == 6 && c->x86_model <= 13 && mca_cfg.bootlog < 0)
+	if (c->x86_vfm < INTEL_CORE_YONAH && mca_cfg.bootlog < 0)
 		mca_cfg.bootlog = 0;
 
 	if (c->x86_vfm == INTEL_SANDYBRIDGE_X)

