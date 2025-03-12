Return-Path: <linux-tip-commits+bounces-4143-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3232A5E277
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7AC3BC0F3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A71258CD6;
	Wed, 12 Mar 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OMzoKwu0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KI6gd/S3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241812571A6;
	Wed, 12 Mar 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800026; cv=none; b=HfGRwS+xqn/PAmfA8M9lgIobmblPozmI1kHzpNBfpxelvEyLnDP5pAV2lX3Byl6EZh3pk+VcTo481t3KT2OXA3rI33lK9300VfFtWUBwbBKn3KNgAkbU1+5bDT9uGweQlBHIWqnXhsAxUdDpYI7NeJ/EDVNx3z8TCreYaph/bR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800026; c=relaxed/simple;
	bh=EaTi/48jpa8K2rytyxZNMBpIB0EDkMSLiWmGfAEhG7o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aGFSouq9xB8ycc0heHNuzvKDWzMsAIq0FpPRSMGGNjPZWxpg5WbcSPR+vRp/bShsS3Q9dMjn3baL9nTN7feOqPjvFZfY+fMTp4voRxLykfQr9NIQgIItp25i/8wmVOKpz/obh60FjXMoeMFA8ENRIWUSK1rhfBkwg0ymsmB9ROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OMzoKwu0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KI6gd/S3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPRNPaN020NLWUZd8x+3MaPuz2nVpHT8MJiVwjhol2Q=;
	b=OMzoKwu00e5UFAc1EtnjHMxhq6Dt5hHgKxyKgIwP/kHUxzguEhJo01/UXXm/YZXKGDxZL4
	Z60sfKETX1L8eeJvp0yk8wj5GDGrF0nFRrxu3/2/bhqqGQyRKLTZctWpiwJ4lRRsO0hDW2
	j/VxTLCAYmZ7cHBu1JpJFSYGu2e0mROQe+Wj02eNgjppopO99vpu1sgPqiS9v4NFAjYoby
	nBRzVKd9fh1wF80Oa5mgAN97Saig6CHJcPkh/8EHk35U8+oiyHkZPidq1Fakjrvhfs2cLw
	1W5aX3rxewNcKU244ga3meeQ+7QsqKG6/IAxJTPeQ/wOl0t84Oegzdi43wwNNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800021;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPRNPaN020NLWUZd8x+3MaPuz2nVpHT8MJiVwjhol2Q=;
	b=KI6gd/S3wO6kB66uSF0OYB6G32dowfsWmRh1W4g2MP8qzmVr2m/O1NWU/gUkp9Mz6ueW3x
	9Dc2C/yvkso/IdDg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Make prefetch_disable_bits belong to
 the arch code
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Carl Worth <carl@os.amperecomputing.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-26-james.morse@arm.com>
References: <20250311183715.16445-26-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180002117.14745.15433290797717039575.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     4d20f38ab6d922dd6b8a33795b6e72516d733eb2
Gitweb:        https://git.kernel.org/tip/4d20f38ab6d922dd6b8a33795b6e72516d733eb2
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:10 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:24:30 +01:00

x86/resctrl: Make prefetch_disable_bits belong to the arch code

prefetch_disable_bits is set by rdtgroup_locksetup_enter() from a value
provided by the architecture, but is largely read by other architecture
helpers.

Make resctrl_arch_get_prefetch_disable_bits() set prefetch_disable_bits so
that it can be isolated to arch-code from where the other arch-code helpers
can use its cached value.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-26-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 1f42c11..90044a0 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -84,6 +84,8 @@ static const struct class pseudo_lock_class = {
  */
 u64 resctrl_arch_get_prefetch_disable_bits(void)
 {
+	prefetch_disable_bits = 0;
+
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86 != 6)
 		return 0;
@@ -99,7 +101,8 @@ u64 resctrl_arch_get_prefetch_disable_bits(void)
 		 * 3    DCU IP Prefetcher Disable (R/W)
 		 * 63:4 Reserved
 		 */
-		return 0xF;
+		prefetch_disable_bits = 0xF;
+		break;
 	case INTEL_ATOM_GOLDMONT:
 	case INTEL_ATOM_GOLDMONT_PLUS:
 		/*
@@ -110,10 +113,11 @@ u64 resctrl_arch_get_prefetch_disable_bits(void)
 		 * 2     DCU Hardware Prefetcher Disable (R/W)
 		 * 63:3  Reserved
 		 */
-		return 0x5;
+		prefetch_disable_bits = 0x5;
+		break;
 	}
 
-	return 0;
+	return prefetch_disable_bits;
 }
 
 /**
@@ -713,8 +717,7 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 	 * Not knowing the bits to disable prefetching implies that this
 	 * platform does not support Cache Pseudo-Locking.
 	 */
-	prefetch_disable_bits = resctrl_arch_get_prefetch_disable_bits();
-	if (prefetch_disable_bits == 0) {
+	if (resctrl_arch_get_prefetch_disable_bits() == 0) {
 		rdt_last_cmd_puts("Pseudo-locking not supported\n");
 		return -EINVAL;
 	}

