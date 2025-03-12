Return-Path: <linux-tip-commits+bounces-4141-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A51A5E272
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69CF17A87B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169032571A4;
	Wed, 12 Mar 2025 17:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r/kvr7JW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6OMBTlwQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15132417D6;
	Wed, 12 Mar 2025 17:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800023; cv=none; b=C5rLSIMCI/ZSE8Sl0AZRzL862fg84SzrJgkgKdjGgL2AQiMY3VoJ3zDThAj2SIQOet04YCoS9Ni/z5WYmVDORedpgEnxe6AgsmDPtnVugM8Pavzuy8Y4j0MnS28UqdnFJdEePwFCtSJPD1wVaDFmHHoUD8r82v3xSvoqq5gCSVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800023; c=relaxed/simple;
	bh=BKaH6Pfm9mhlsWtzaZKT1RgpMRm+MwgkNY86MKWga/k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iUyAFxub/f5kvXuIZsjyt3UdyHDbNH85sEwdXmq8/TFM3PRnqNlPdz2g3nG43ZiE3omW5pVb4ava2ZeqrhKcSusGQy71lEwIX/aOG7+qdHtePem3+lP4Em2CBEPhbY/GhoewwgvZ/RyqCR7rj7tROW/p9FRZ4dO056DT83sFjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r/kvr7JW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6OMBTlwQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7sl//RldBkwtHThz5V3oaI5BTQD1fSF/ojREj2JPNk=;
	b=r/kvr7JWc4IlT8A1MB4TlZ6hsoK8LOYfBw94FlJYwiorJSBrjqnKD7I5Qa1ZgvdhrBi9iz
	EVJB6fiF+tIOH3GTIYwWXyoqSxSyeE4USzoVE4Nr2HGDSeCfSpGanV9GifELZu6vsqTMVs
	9aiD+A9Xwc/Lec80Wyb6yl9QeeFYOBywa7Xp9WqdvdZinCt1WDm6vekMekIb2tzUTRjrDP
	QeisMcm4vrJQoCuK92PhDtMmMLR3w1njFvb5IXLsHzK0Om+2BYA8csL0B0xvq7zA1ICv5R
	Jde899USEZdr2lRWE/p+coH0phI6f4Gw0GixoyXRBzwoaicn0EFSkU7CE9VSyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C7sl//RldBkwtHThz5V3oaI5BTQD1fSF/ojREj2JPNk=;
	b=6OMBTlwQKBJD9lgpYLMRm3wfp729h9Z48cWJvgQX6Pufntrvt44XP0WdBzO+36nX0vYgWb
	T4lDHlAeF6D03eDw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Move RFTYPE flags to be managed by resctrl
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-28-james.morse@arm.com>
References: <20250311183715.16445-28-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180001947.14745.4859162220572284627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     373af4ecfdc922657be081b3feebbd0af8e7fa65
Gitweb:        https://git.kernel.org/tip/373af4ecfdc922657be081b3feebbd0af8e7fa65
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:12 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:24:37 +01:00

x86/resctrl: Move RFTYPE flags to be managed by resctrl

resctrl_file_fflags_init() is called from the architecture specific code to
make the 'thread_throttle_mode' file visible. The architecture specific code
has already set the membw.throttle_mode in the rdt_resource.

This forces the RFTYPE flags used by resctrl to be exposed to the architecture
specific code.

This doesn't need to be specific to the architecture, the throttle_mode can be
used by resctrl to determine if the 'thread_throttle_mode' file should be
visible. This allows the RFTYPE flags to be private to resctrl.

Add thread_throttle_mode_init(), and use it to call resctrl_file_fflags_init()
from resctrl_init(). This avoids publishing an extra function between the
architecture and filesystem code.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Amit Singh Tomar <amitsinght@marvell.com> # arm64
Tested-by: Shanker Donthineni <sdonthineni@nvidia.com> # arm64
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20250311183715.16445-28-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     |  3 ---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b9b74f5..e590dd3 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -227,9 +227,6 @@ static __init bool __get_mem_config_intel(struct rdt_resource *r)
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
 
-	resctrl_file_fflags_init("thread_throttle_mode",
-				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
-
 	r->alloc_capable = true;
 
 	return true;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e592715..58feba3 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2064,6 +2064,16 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
+static void thread_throttle_mode_init(void)
+{
+	struct rdt_resource *r_mba;
+
+	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
+	if (r_mba->membw.throttle_mode != THREAD_THROTTLE_UNDEFINED)
+		resctrl_file_fflags_init("thread_throttle_mode",
+					 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
+}
+
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)
 {
 	struct rftype *rft;
@@ -4277,6 +4287,8 @@ int __init resctrl_init(void)
 
 	rdtgroup_setup_default();
 
+	thread_throttle_mode_init();
+
 	ret = resctrl_mon_resource_init();
 	if (ret)
 		return ret;

