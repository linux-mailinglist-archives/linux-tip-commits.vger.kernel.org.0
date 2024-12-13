Return-Path: <linux-tip-commits+bounces-3061-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8141D9F17BA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F329E188F6C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2B194A6C;
	Fri, 13 Dec 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blNO9b3c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3B2l0Bn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7871925B8;
	Fri, 13 Dec 2024 21:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123763; cv=none; b=O15LETqzyZ2FCzfSdmkJnqXVwCaM6mz/kHJBonY2Ola9i2eUrP1ZeVezRclh+8Ssfs5DhdludcAzZ1u4FNFJBaQs1LHLcd5P6dTAn5yKRuVeJakx+ZcPhq7YrH9Y/kiEm5G9MOUZxefpIAncb5NIXX3ay1Bp1/YBrsoL+5QslYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123763; c=relaxed/simple;
	bh=oeIuQRikJDKsP4Lasiw0T4jr3EZSou7Ow/yeLcPHmv0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g4RuPsZd0QB4fT42qYlk3E5P06rz5/tC95YRgYd2WpoUXcUReMxgeOZXudYX8dyqlQaXe6bkAXxLP2C7uymigsfYfiytx+bHsbPWrRnhmkzyIwaN1lEtTt+QBNwnS4lbSuuRWbqZRHjmfbkCkh6F1lhql0Spp3pDvzcP1OBrDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blNO9b3c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3B2l0Bn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SEyY3VOtNDlTmEXkflIxgSAzLfABoWzynvxOkIFgfg=;
	b=blNO9b3cpXtR3lExJW49r1ClL0rZZOO8s+Vz3V+R1I7OousMfNfdE4b0xR9G6s9rLRT5ov
	fnIU6VKI2dYQ6VJF/M/ubxselJ1LJgQgDU3wOEi8LZK0JJPYTl0MuuKYtlDVl5kePk5z5t
	wSCkpAmPkt7nTT6VuVJnRUw5Yv86z6wCRMl/W6PNLKCurBkPVRXrE2pqSCwujkNbKAGLli
	Fr3LjQbYdVElmo01n4FeSyFTqfdABHDozdHPotw7wH0h3LgShVcmlThRohmUjJUhqknFfM
	jzHYyZ9fKKm+V29fQZ4T1ZyxHq/iVqUxNBW5JEvcu04K2/Riyms2JFh9QXvldQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123759;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/SEyY3VOtNDlTmEXkflIxgSAzLfABoWzynvxOkIFgfg=;
	b=q3B2l0BnfIzgtOsXRYkVZuko4vfunPJZfc+MKFnkHh76+eTqMHaU6ieVy8K4SIWES3ywHy
	4C5TwXuE2a2goiAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Make mba_sc use total bandwidth if
 local is not supported
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206163148.83828-6-tony.luck@intel.com>
References: <20241206163148.83828-6-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173412375871.412.3639021712562724978.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     141cb5c482b38d7e494a207f881d0fe61e4848ef
Gitweb:        https://git.kernel.org/tip/141cb5c482b38d7e494a207f881d0fe61e4848ef
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 06 Dec 2024 08:31:45 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Dec 2024 16:15:14 +01:00

x86/resctrl: Make mba_sc use total bandwidth if local is not supported

The default input measurement to the mba_sc feedback loop for memory bandwidth
control when the user mounts with the "mba_MBps" option is the local bandwidth
event. But some systems may not support a local bandwidth event.

When local bandwidth event is not supported, check for support of total
bandwidth and use that instead.

Relax the mount option check to allow use of the "mba_MBps" option for systems
when only total bandwidth monitoring is supported. Also update the error
message.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20241206163148.83828-6-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 94bf559..3d1735e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -965,6 +965,8 @@ static __init bool get_rdt_mon_resources(void)
 
 	if (is_mbm_local_enabled())
 		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+	else if (is_mbm_total_enabled())
+		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 
 	return !rdt_get_mon_l3_config(r);
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 8a52b25..0659b8e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2341,7 +2341,7 @@ static bool supports_mba_mbps(void)
 	struct rdt_resource *rmbm = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
 
-	return (is_mbm_local_enabled() &&
+	return (is_mbm_enabled() &&
 		r->alloc_capable && is_mba_linear() &&
 		r->ctrl_scope == rmbm->mon_scope);
 }
@@ -2768,7 +2768,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		ctx->enable_cdpl2 = true;
 		return 0;
 	case Opt_mba_mbps:
-		msg = "mba_MBps requires local MBM and linear scale MBA at L3 scope";
+		msg = "mba_MBps requires MBM and linear scale MBA at L3 scope";
 		if (!supports_mba_mbps())
 			return invalfc(fc, msg);
 		ctx->enable_mba_mbps = true;

