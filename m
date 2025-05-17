Return-Path: <linux-tip-commits+bounces-5643-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A926ABA94F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BB27A3CDA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9B51FC0F0;
	Sat, 17 May 2025 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pO4gnVdz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D3yjk9M/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D01F6694;
	Sat, 17 May 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747476178; cv=none; b=IURdOaIM1ph6kpcUk9jb0liPisST52GcVAddOrz9dJliFcoelt3DCusovKSyGXvQUYQt1ERueTco06uSklfX8DTdsJ9NBAnAnslURUC0L+2x1ugPJBVkzDeeuNvecNQMbgpm4GO4xCyyAnCHPPk4RhL06dnifM+a7WxMl04vRxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747476178; c=relaxed/simple;
	bh=VhLNC2/GqxjwujGDr1i0oeFDTQ62kb4I16qIyw9Yvbc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mZmCqBFdkCrf97DmD0Qypj8Oodw7l84FF52TAOTPgHhMBXYpnxlaOMY/ax2iWC8u4NcCG6b3LVL/641vOQmWAZB+BvH0IcjnMtFyMY6hoB6G4NbtSLU54dkT9q3CKBeHtULbtCoAO3KtHh2n+sCD8hfdW2gnaiM/i5LwIbEwD7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pO4gnVdz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D3yjk9M/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 10:02:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747476175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugeW+Rl8n1fySIE/2k1CEHQA/iyjUOPT/mFRF2XQq4c=;
	b=pO4gnVdzIGeVCmSKRhdrD3R+JNsADI62O9yXpRJOaRvOAVynxd5/+f2PVABuqJOJ6QiP2E
	IY6ecpBk1srRyMGFQODx9QfDu9dKtHNyvHshTMxl1b1ePOsi/63qCVRVoEAkGoJ/b1EEoq
	ZA0EzDe2N3jq5slBjaRG9B4D2FvJ8r+MKbj/fGZL11HSFmrE9b/BcTp41ltsU2N0NQw3zt
	nYvkt3qssJabCgs1RdGkOdcMMm/41XFu2Xs1WCJV49osDhM04GKoS9zUXu2YLHxvLT3guX
	eSZI80FWlJtRSIKFh6ydrwjIMqwkwf6w2SPdQsoOHV9czfj87euU0BHJTF6QzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747476175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ugeW+Rl8n1fySIE/2k1CEHQA/iyjUOPT/mFRF2XQq4c=;
	b=D3yjk9M/3kKmohN3Nn1JviJ2YY3OsJNpT9NFX/OrgMmaaBUkmIxNaMQ4lgAbR2ZrSkxrpz
	GEeaRvrdlgV2dkAw==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move enum resctrl_event_id to resctrl.h
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515165855.31452-18-james.morse@arm.com>
References: <20250515165855.31452-18-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174747617435.406.7329056663566773095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     7bdb619c7f9f0a7264b2d69ad0472bf2c785e52a
Gitweb:        https://git.kernel.org/tip/7bdb619c7f9f0a7264b2d69ad0472bf2c785e52a
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Thu, 15 May 2025 16:58:47 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 May 2025 12:10:20 +02:00

x86/resctrl: Move enum resctrl_event_id to resctrl.h

resctrl_types.h contains common types and constants to enable architectures
to use these types in their definitions within asm/resctrl.h.

enum resctrl_event_id was placed in resctrl_types.h for
resctrl_arch_get_cdp_enabled() and resctrl_arch_set_cdp_enabled(), but
these two functions are no longer inlined by any architecture.

Move enum resctrl_event_id to resctrl.h.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Fenghua Yu <fenghuay@nvidia.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250515165855.31452-18-james.morse@arm.com
---
 include/linux/resctrl.h       | 10 ++++++++++
 include/linux/resctrl_types.h | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b9d1f29..5ef972c 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -48,6 +48,16 @@ int proc_resctrl_show(struct seq_file *m,
 	for_each_rdt_resource((r))					      \
 		if ((r)->mon_capable)
 
+enum resctrl_res_level {
+	RDT_RESOURCE_L3,
+	RDT_RESOURCE_L2,
+	RDT_RESOURCE_MBA,
+	RDT_RESOURCE_SMBA,
+
+	/* Must be the last */
+	RDT_NUM_RESOURCES,
+};
+
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index a66e793..a25fb9c 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -34,16 +34,6 @@
 /* Max event bits supported */
 #define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
 
-enum resctrl_res_level {
-	RDT_RESOURCE_L3,
-	RDT_RESOURCE_L2,
-	RDT_RESOURCE_MBA,
-	RDT_RESOURCE_SMBA,
-
-	/* Must be the last */
-	RDT_NUM_RESOURCES,
-};
-
 /*
  * Event IDs, the values match those used to program IA32_QM_EVTSEL before
  * reading IA32_QM_CTR on RDT systems.

