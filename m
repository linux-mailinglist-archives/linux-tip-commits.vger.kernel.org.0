Return-Path: <linux-tip-commits+bounces-4048-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5BA56801
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 13:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6AC7A62E3
	for <lists+linux-tip-commits@lfdr.de>; Fri,  7 Mar 2025 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2A314A4F9;
	Fri,  7 Mar 2025 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EhLbZYRN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRP4bvSx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D72192F6;
	Fri,  7 Mar 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351272; cv=none; b=PNEmwQIm4KlwSv+dys2OYQlHh4OAeNiqoDT6rzmEh0ClvMpugvtgDtWLdid1zcwja0gKoSO1zkXY6CGa+FTbn2S7dqEFKxb+3MaTB3KmvRriYzDbR4zlNhvJxSFovPJ24tk4vY6j5uklBg64KSNOVRxQ7d2brb6wzMWYtWM/Qj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351272; c=relaxed/simple;
	bh=RFnMpGCEq6KusUZOTkqeWE75JiqiNWQN8xEID0URfTk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KMuzMtb3I4aH0N3musOVd+vHrFY0JfBWPcdf9XPXrKxSFlC3c6vtKLrteuwdTNcUqMlV5hJdHykT2sAD6/Doy9HAdH/v1QKXVfOpCUCogMw6MTzlZIpYRIq1rx8COQfxQjS0rsjDbGtsxtHHzOSbgfDDueSqSbVJVTMfgUy+AFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EhLbZYRN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRP4bvSx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 07 Mar 2025 12:41:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741351269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7hW6K9PJ8lxkQjFDwtGIOrFreGrUa4zCoiv+rlaSd8=;
	b=EhLbZYRNoA5BbficassE/mzKeBYeXZOVAx+wWg5T5GPUY/BVVbwgsea8umvLcODkeR8dX3
	om/YDJ4ht57ykfmVDKtk3lQnVt0jFq0F9k3Syp3DU+enkP6ZjkgHtgGAOj2gmauH90YGVo
	nc+fJtWEs26/VW2oeyicOTlxfQj6MB2VyrV5k/mFkmGDE9UhYmj2zE5ogHBd389MXQgdM7
	2bc5uAD445xngOhSfVA3vHwIDssjBmF5okp8aTH+CGX1c5LKAMcVciB1nQ3UCtfkTv8sp/
	M8jHaXCGpl9zC0dh0iCP+ndX6tfvB2T4qpB9D6XGmFEE426I7CLNk0AmZlNHLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741351269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h7hW6K9PJ8lxkQjFDwtGIOrFreGrUa4zCoiv+rlaSd8=;
	b=NRP4bvSxu5XmY4ProwuwqSoE8WSEQHhrKS4fnT87YLfHoF3ASUvpgvJttqgwND65inJQqD
	1M9yUn2ZGVkOWmDg==
From: "tip-bot2 for Andrew Cooper" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()
Cc: Andrew Cooper <andrew.cooper3@citrix.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307002846.3026685-1-andrew.cooper3@citrix.com>
References: <20250307002846.3026685-1-andrew.cooper3@citrix.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174135126828.14745.8496438046154822833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     14cb5d83068ecf15d2da6f7d0e9ea9edbcbc0457
Gitweb:        https://git.kernel.org/tip/14cb5d83068ecf15d2da6f7d0e9ea9edbcbc0457
Author:        Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate:    Fri, 07 Mar 2025 00:28:46 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 07 Mar 2025 13:28:31 +01:00

x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()

Xen doesn't offer MSR_FAM10H_MMIO_CONF_BASE to all guests.  This results
in the following warning:

  unchecked MSR access error: RDMSR from 0xc0010058 at rIP: 0xffffffff8101d19f (xen_do_read_msr+0x7f/0xa0)
  Call Trace:
   xen_read_msr+0x1e/0x30
   amd_get_mmconfig_range+0x2b/0x80
   quirk_amd_mmconfig_area+0x28/0x100
   pnp_fixup_device+0x39/0x50
   __pnp_add_device+0xf/0x150
   pnp_add_device+0x3d/0x100
   pnpacpi_add_device_handler+0x1f9/0x280
   acpi_ns_get_device_callback+0x104/0x1c0
   acpi_ns_walk_namespace+0x1d0/0x260
   acpi_get_devices+0x8a/0xb0
   pnpacpi_init+0x50/0x80
   do_one_initcall+0x46/0x2e0
   kernel_init_freeable+0x1da/0x2f0
   kernel_init+0x16/0x1b0
   ret_from_fork+0x30/0x50
   ret_from_fork_asm+0x1b/0x30

based on quirks for a "PNP0c01" device.  Treating MMCFG as disabled is the
right course of action, so no change is needed there.

This was most likely exposed by fixing the Xen MSR accessors to not be
silently-safe.

Fixes: 3fac3734c43a ("xen/pv: support selecting safe/unsafe msr accesses")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250307002846.3026685-1-andrew.cooper3@citrix.com
---
 arch/x86/kernel/amd_nb.c |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 11fac09..67e7737 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -143,7 +143,6 @@ bool __init early_is_amd_nb(u32 device)
 
 struct resource *amd_get_mmconfig_range(struct resource *res)
 {
-	u32 address;
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
@@ -151,13 +150,11 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
-	/* assume all cpus from fam10h have mmconfig */
-	if (boot_cpu_data.x86 < 0x10)
+	/* Assume CPUs from Fam10h have mmconfig, although not all VMs do */
+	if (boot_cpu_data.x86 < 0x10 ||
+	    rdmsrl_safe(MSR_FAM10H_MMIO_CONF_BASE, &msr))
 		return NULL;
 
-	address = MSR_FAM10H_MMIO_CONF_BASE;
-	rdmsrl(address, msr);
-
 	/* mmconfig is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;

