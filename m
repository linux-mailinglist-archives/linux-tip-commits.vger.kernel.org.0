Return-Path: <linux-tip-commits+bounces-6632-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB94B57858
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A3F17AEF73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96AD3081C6;
	Mon, 15 Sep 2025 11:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WChY4hhl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cnGL2gJk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C743074B4;
	Mon, 15 Sep 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935678; cv=none; b=rPrO/8zbXOblHDLOMfp9PSXY+kG4CgGMg0b8MZ7vZ6EIP1VfY88jOKkOUaqu0k0EYgNFcgz/9tk/T+4ETLYojsbVjFmcFL+wn0bgc6YFXZB/mqtwZjhfM4OJqzu1zg+OaUw4wfyjF4x8rqJb2Xh/M6gnTL/3EonDISlow9co6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935678; c=relaxed/simple;
	bh=FzEPNkb5MrPuOOlUFpzks/J09mRBF4WU3jfoAR8yebc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=se5hvKz/tarjWCFDj0uua0HeJWRjLY0GVDAULUypWALVlMnQGNfVLGDBk7SLRr4FtJLbwpA6QD0slMarNdtfLx3XpA/9rqbeptJGHtXnlYCXLsTX3PegVb2kKbVWOuBVHStkNl8O//53Mo91fReU/OeDuHxjlljIJrNyaIVLSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WChY4hhl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cnGL2gJk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vlTsyiD38wx+MhebIvI+ujKuDP4oiiWTjmmcELtweM=;
	b=WChY4hhldv0pmLpYmQJW5uzk1nBqPsi+F5l708VmWPxLLT1cPN8F73NmFsg8krh1hGcqH6
	Q1dtSzYICXNzHIyhmRGvUw8X5L1F3l6iPRpzZcDXZCzmAj09paFlAlXSookbWAKrbObi1j
	kY9Hz4wln6+ej+vAuKk0M3Fa3/SqqorWQzx4bZQg4ka9cNJktnsAD1X4USxs1aC63kOmtA
	enUKrxW3IlkFi+qol49S+3jCKI8L++XdJ+Aq/+Lh5UO34cl/2dxqM29QE0Gfnjo+WORULK
	wz2tPxtCstuJuAlp/EFC63ipmwgn+04gLOGbI5DY2S4DOsVMEX4z4M+2Nn8pVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vlTsyiD38wx+MhebIvI+ujKuDP4oiiWTjmmcELtweM=;
	b=cnGL2gJkY55h3cpHJLfN22WAghuE5MRESIZlrFY/A5oluyvfHid6ZtB0B4cKyDLRZDN4bT
	pFFmbOYI86I2CqCg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Remove the rdt_mon_features global variable
Cc: Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <d663538d0ce03e61967cd8e308a3c4549b3cded3.1757108044.git.babu.moger@amd.com>
References:
 <d663538d0ce03e61967cd8e308a3c4549b3cded3.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793567375.709179.17482047346886221146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     63cc9811aa874e6fab671599ba93a989f4f93a5d
Gitweb:        https://git.kernel.org/tip/63cc9811aa874e6fab671599ba93a989f4f=
93a5d
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:02 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 11:55:50 +02:00

x86/resctrl: Remove the rdt_mon_features global variable

rdt_mon_features is used as a bitmask of enabled monitor events. A monitor
event's status is now maintained in mon_evt::enabled with all monitor events'
mon_evt structures found in the filesystem's mon_event_all[] array.

Remove the remaining uses of rdt_mon_features.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 arch/x86/include/asm/resctrl.h        |  1 -
 arch/x86/kernel/cpu/resctrl/core.c    |  9 +++++----
 arch/x86/kernel/cpu/resctrl/monitor.c |  5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index b1dd5d6..575f840 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -44,7 +44,6 @@ DECLARE_PER_CPU(struct resctrl_pqr_state, pqr_state);
=20
 extern bool rdt_alloc_capable;
 extern bool rdt_mon_capable;
-extern unsigned int rdt_mon_features;
=20
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 1a319ce..5d14f9a 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -863,21 +863,22 @@ static __init bool get_rdt_alloc_resources(void)
 static __init bool get_rdt_mon_resources(void)
 {
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	bool ret =3D false;
=20
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
 		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
-		rdt_mon_features |=3D (1 << QOS_L3_OCCUP_EVENT_ID);
+		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
-		rdt_mon_features |=3D (1 << QOS_L3_MBM_TOTAL_EVENT_ID);
+		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
-		rdt_mon_features |=3D (1 << QOS_L3_MBM_LOCAL_EVENT_ID);
+		ret =3D true;
 	}
=20
-	if (!rdt_mon_features)
+	if (!ret)
 		return false;
=20
 	return !rdt_get_mon_l3_config(r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 61d3851..07f8ab0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -31,11 +31,6 @@
  */
 bool rdt_mon_capable;
=20
-/*
- * Global to indicate which monitoring events are enabled.
- */
-unsigned int rdt_mon_features;
-
 #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
=20
 static int snc_nodes_per_l3_cache =3D 1;

