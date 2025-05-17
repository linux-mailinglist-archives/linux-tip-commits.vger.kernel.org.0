Return-Path: <linux-tip-commits+bounces-5641-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B2ABA950
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E109189F080
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F091F8725;
	Sat, 17 May 2025 10:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LclFqDoA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mOTTHtyG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD871F419B;
	Sat, 17 May 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476177; cv=none; b=peEi+0lSDHIQnC55HXUchJlPYGgcsPEdjPGWm/LU32iFvOdD+qqgKfoKFXCLiAqHazNmTOozc0s4udsX/G13bEbwi7SpSjRGdFDJNxGDd/vtRtHJUL7AsbqTDFcULuwDr1lesPgKSgWA6Xvt06bJ/xcUl3YMmgIluWUQc5nkhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476177; c=relaxed/simple;
	bh=V9LD1qC9TwaskLIZKQaAIc1T/cf/82P21i036Ot24VE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lxp9zvXDVjyW7RdVAFr5csKCBWG1HsVGh9dq0DRPEGkDXZPUcanszyog/aA/nx/gYkubNA1Dx3dl4gVQX/Bm+bu4Lruoal36BJppS4Vpvk2rOJVnpdaeOMXhUj2PvoBkeof/AisObJnp9iF6nU2mv9UzvMfWQn6mmkUGKijV/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LclFqDoA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mOTTHtyG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UjTc7dBGfWSzhb0+ZHOJmkBmHseXdt2fbE1bt3THTv0=;
	b=LclFqDoAz+gfoYTQf1CGWsVDh3dJqk5b2UC/QOoEO40ot0KCFnPWe+ktmhKDxcJv66dBRY
	CwyovqOOz30cgn5RK1d5oQK714mQtnzS3UaMagwf60tIaHU5AK4UM+cDLEhshcaeRnueo+
	wPUYHn2+DZ4G3er7TD/HOnOWHWHiGZ1jwuQ5s/+lQ71sSjhjNuGujgJSwh/v3eKR1G785y
	2FiJYTK3GU28pLfBUvy1Bc9VNbfVW9qRvajGtNBe2cBri0YhzOwwrM1E/mbh3vDaDA6Mam
	SZROiEk+G4lIf5qJYQ39WrWNeUfpIKbV9fF3v6TQiy+PEO5Gh5BIYRvpE7Ja6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UjTc7dBGfWSzhb0+ZHOJmkBmHseXdt2fbE1bt3THTv0=;
	b=mOTTHtyGsiCGPWJ6KS22tHic+3E+EL482uhP4pyQgijhgTJ+bFQdhFt80gsBOXQepwTLCU
	kBaiBRG/u2D5csBw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move pseudo lock prototypes to
 include/linux/resctrl.h
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-20-james.morse@arm.com>
References: <20250515165855.31452-20-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617263.406.5434908084671148848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     279f225951e3c77a1708d77f557b4cc7bdbd76ed
Gitweb:        https://git.kernel.org/tip/279f225951e3c77a1708d77f557b4cc7bdbd76ed
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:49 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 12:21:00 +02:00

x86/resctrl: Move pseudo lock prototypes to include/linux/resctrl.h

The resctrl pseudo-lock feature allows an architecture to allocate data
into particular cache portions, which are then treated as reserved to
avoid that data ever being evicted. Setting this up is deeply architecture
specific as it involves disabling prefetchers etc. It is not possible
to support this kind of feature on arm64. Risc-V is assumed to be the
same.

The prototypes for the architecture code were added to x86's asm/resctrl.h,
with other architectures able to provide stubs for their architecture. This
forces other architectures to provide identical stubs.

Move the prototypes and stubs to linux/resctrl.h, and switch between them
using the existing Kconfig symbol.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-20-james.morse@arm.com
---
 arch/x86/include/asm/resctrl.h |  5 -----
 include/linux/resctrl.h        | 13 +++++++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index a2e20fe..ad497ab 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -205,11 +205,6 @@ static inline void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
 					     enum resctrl_event_id evtid,
 					     void *ctx) { }
 
-u64 resctrl_arch_get_prefetch_disable_bits(void);
-int resctrl_arch_pseudo_lock_fn(void *_plr);
-int resctrl_arch_measure_cycles_lat_fn(void *_plr);
-int resctrl_arch_measure_l2_residency(void *_plr);
-int resctrl_arch_measure_l3_residency(void *_plr);
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
 
 #else
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5ef972c..9ba771f 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -534,4 +534,17 @@ extern unsigned int resctrl_rmid_realloc_limit;
 int resctrl_init(void);
 void resctrl_exit(void);
 
+#ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
+u64 resctrl_arch_get_prefetch_disable_bits(void);
+int resctrl_arch_pseudo_lock_fn(void *_plr);
+int resctrl_arch_measure_cycles_lat_fn(void *_plr);
+int resctrl_arch_measure_l2_residency(void *_plr);
+int resctrl_arch_measure_l3_residency(void *_plr);
+#else
+static inline u64 resctrl_arch_get_prefetch_disable_bits(void) { return 0; }
+static inline int resctrl_arch_pseudo_lock_fn(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_cycles_lat_fn(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_l2_residency(void *_plr) { return 0; }
+static inline int resctrl_arch_measure_l3_residency(void *_plr) { return 0; }
+#endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
 #endif /* _RESCTRL_H */

