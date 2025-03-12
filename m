Return-Path: <linux-tip-commits+bounces-4147-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A30A5E282
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576803BC10F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891BB25A620;
	Wed, 12 Mar 2025 17:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQ+6uqVr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NB2OQU4f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A924FC1F;
	Wed, 12 Mar 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800029; cv=none; b=iWdb11VKkHwlyxm+vAxylxHuBvVUjFTdE2mOpMRBLFVm67a0/Psq5xKN2kgFGWiISl6g1X3y2X4PCZe2jrSpy6LLU0DpaJYhLO1TouE2JjsgR3VeT36ec+37Sa+BXRmpJyE1HXgXaLdt5xo8uN6v1jV49iivlZETwObZYBkfO78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800029; c=relaxed/simple;
	bh=0kKwHl4pCuav2Fk+vOm+OQsC2i2EtsE5q82zQUppvgs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c422dmxvlvhZqkdFXzm7889MydGCoZ+rvaUuBXN/mjS7YKK9z0HbMbdJopUcpflBCBZcafMf6XkvOvZvenTj0OShE4qFKPuQS/wJTT5A/z1Z5Prc66Ay0+KEhM5ZqsrMTOWHZ4wm4Hh0A+kL74S5kl+Pmoq4AotCs4WQYmsOgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sQ+6uqVr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NB2OQU4f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrkYf/SNci7st2XTJCiaoNm4dvCAKdwAXBbiXV8lO3s=;
	b=sQ+6uqVrPIUy3UN7KHImMx653Ii4PDUfQqtqXvPjxv9c9FFTMTAvq7oYYtpMd1TlH0EaiP
	VR1Cb+dcfnBbWvRgsAi7crTFs01BKyhbZzvY6taac3IgN6Ejs7R4k1eyW9Q+v8Bo4wAF7j
	5NOlPSSGC/QElGUMvWGq9zhfhN4Wff3kyXuBjq0aKJ7fAuWNA7MZBOhDraM7qvDH5RjNDQ
	lFJJsp0mGrOwLyo+cuwLBrX+J5pHVuRVWA+7bDjmD5KKvoAqYNccZhBQt7hF6uL7izWYOB
	3+ovDNBYxNQHBMyxYXtR0oeoGLfcI854NpVkCyP4S1cEKPrZJbZmvlbclcTlVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800025;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrkYf/SNci7st2XTJCiaoNm4dvCAKdwAXBbiXV8lO3s=;
	b=NB2OQU4f9yutoSUS8nsztcoRHcMWBrZ6SCvy78JPnDt/zOr5qOjWCIVxCYMW9TBYh81waD
	7FpNtsKt+oi72UAA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Move mba_mbps_default_event init to
 filesystem code
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-22-james.morse@arm.com>
References: <20250311183715.16445-22-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180002422.14745.4469088229520775387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     37bae1756734b065f5e5cddc54ad121ff0c8db51
Gitweb:        https://git.kernel.org/tip/37bae1756734b065f5e5cddc54ad121ff0c8db51
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:06 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:23:52 +01:00

x86/resctrl: Move mba_mbps_default_event init to filesystem code

mba_mbps_default_event is initialised based on whether mbm_local or mbm_total
is supported. In the case of both, it is initialised to mbm_local.
mba_mbps_default_event is initialised in core.c's get_rdt_mon_resources(),
while all the readers are in rdtgroup.c.

After this code is split into architecture-specific and filesystem code,
get_rdt_mon_resources() remains part of the architecture code, which would
mean mba_mbps_default_event has to be exposed by the filesystem code.

Move the initialisation to the filesystem's resctrl_mon_resource_init().

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
Link: https://lore.kernel.org/r/20250311183715.16445-22-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c    | 5 -----
 arch/x86/kernel/cpu/resctrl/monitor.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 6f0d1bb..b9b74f5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -923,11 +923,6 @@ static __init bool get_rdt_mon_resources(void)
 	if (!rdt_mon_features)
 		return false;
 
-	if (resctrl_arch_is_mbm_local_enabled())
-		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
-	else if (resctrl_arch_is_mbm_total_enabled())
-		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
-
 	return !rdt_get_mon_l3_config(r);
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 27d9831..306b06b 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1213,6 +1213,11 @@ int __init resctrl_mon_resource_init(void)
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 
+	if (resctrl_arch_is_mbm_local_enabled())
+		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+	else if (resctrl_arch_is_mbm_total_enabled())
+		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
+
 	return 0;
 }
 

