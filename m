Return-Path: <linux-tip-commits+bounces-4140-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5C2A5E26E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1914175D1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Mar 2025 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D3225484F;
	Wed, 12 Mar 2025 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3dQESsD7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jbTbct0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA23282F1;
	Wed, 12 Mar 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800022; cv=none; b=n1WdzVEyuS9FUDxn7YFGkRf3LLlJ6plSdLU+chDGR18YkHvC39DFKf3lyfHC5x0eDnshsxAuxdZLwVdmEWRafyU0iiygnj5FsOGGQ7BPNJdPrLzNkYNUBhhPKwRSxUR8NFzdopGcVtoHaCo0e/ed1LfS2jklt/C742SnkNn2RVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800022; c=relaxed/simple;
	bh=9b2azM4zXJyOKa58Tqo9Qfl0J63cvAQdbZWG1yBXPMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EVwITjD/dIp6ts2jvDWnVnYvXV3LCrwEJI6n2QRbxyDut/GlGptrDwZgALqkSjOcywki01CU0Pm+Y9ATq9beTaDmIj0MhUyyJ6bS+wDstGusEIU5T2ra8x0kx5dCV21QVbUL4viNUQYYNCi8TU3vSJgXQSxcHAzhs+jBGjdeAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3dQESsD7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jbTbct0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Mar 2025 17:20:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741800019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nglgJkUp3w3g8mOpThU6rmiFP6dq0xIoRw+T2LS+5Cw=;
	b=3dQESsD7l7PVlQFC8X7J/Jfi4n9McgWab/whn1N3neD8eTckrtd8K2dcx6VdQixtgIzM1B
	+cfztPJno8IdDAbI0MC1fRCeqRB85l9kBu5kfBRQZRr++v8ptgL4neyJtw6i42pensib66
	xMQ7Jhb1/rijaoqOANA8oBXRzwX6svGr+39GI03acRK2COq+hQANt1Iis1pH0EQXvsmzQu
	DxhSQZ1BDUJzezS9ORSiex5w0Tx01+cfwtqSqede6zSCqNjZAu8noXKoATqA+LA3EH3SiH
	JhbngBXL4Nz1inuRCkA2UVCTCg0zJyRMOiQbJD1JQ5vY2E3PSDxMfyYM9KodUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741800019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nglgJkUp3w3g8mOpThU6rmiFP6dq0xIoRw+T2LS+5Cw=;
	b=0jbTbct0WFRGFzAEnCsgTKWhNxvIpCJBsIeE7fdev75XjTwFieHmMWWzPBLox4HFdk1zSI
	qyBFYoatweIgjEBg==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Handle throttle_mode for SMBA resources
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Babu Moger <babu.moger@amd.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
 Peter Newman <peternewman@google.com>,
 Amit Singh Tomar <amitsinght@marvell.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250311183715.16445-29-james.morse@arm.com>
References: <20250311183715.16445-29-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174180001862.14745.5960718022865281710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6c2282d42cb37f081587412f77340138b1df265e
Gitweb:        https://git.kernel.org/tip/6c2282d42cb37f081587412f77340138b1df265e
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 11 Mar 2025 18:37:13 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Mar 2025 12:24:46 +01:00

x86/resctrl: Handle throttle_mode for SMBA resources

Now that the visibility of throttle_mode is being managed by resctrl, it
should consider resources other than MBA that may have a throttle_mode.  SMBA
is one such resource.

Extend thread_throttle_mode_init() to check SMBA for a throttle_mode.

Adding support for multiple resources means it is possible for a platform with
both MBA and SMBA, but an undefined throttle_mode on one of them to make the
file visible.

Add the 'undefined' case to rdt_thread_throttle_mode_show().

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
Link: https://lore.kernel.org/r/20250311183715.16445-29-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 33 ++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 58feba3..5fc60c9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1188,10 +1188,19 @@ static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
 	struct resctrl_schema *s = of->kn->parent->priv;
 	struct rdt_resource *r = s->res;
 
-	if (r->membw.throttle_mode == THREAD_THROTTLE_PER_THREAD)
+	switch (r->membw.throttle_mode) {
+	case THREAD_THROTTLE_PER_THREAD:
 		seq_puts(seq, "per-thread\n");
-	else
+		return 0;
+	case THREAD_THROTTLE_MAX:
 		seq_puts(seq, "max\n");
+		return 0;
+	case THREAD_THROTTLE_UNDEFINED:
+		seq_puts(seq, "undefined\n");
+		return 0;
+	}
+
+	WARN_ON_ONCE(1);
 
 	return 0;
 }
@@ -2066,12 +2075,24 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 
 static void thread_throttle_mode_init(void)
 {
-	struct rdt_resource *r_mba;
+	enum membw_throttle_mode throttle_mode = THREAD_THROTTLE_UNDEFINED;
+	struct rdt_resource *r_mba, *r_smba;
 
 	r_mba = resctrl_arch_get_resource(RDT_RESOURCE_MBA);
-	if (r_mba->membw.throttle_mode != THREAD_THROTTLE_UNDEFINED)
-		resctrl_file_fflags_init("thread_throttle_mode",
-					 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
+	if (r_mba->alloc_capable &&
+	    r_mba->membw.throttle_mode != THREAD_THROTTLE_UNDEFINED)
+		throttle_mode = r_mba->membw.throttle_mode;
+
+	r_smba = resctrl_arch_get_resource(RDT_RESOURCE_SMBA);
+	if (r_smba->alloc_capable &&
+	    r_smba->membw.throttle_mode != THREAD_THROTTLE_UNDEFINED)
+		throttle_mode = r_smba->membw.throttle_mode;
+
+	if (throttle_mode == THREAD_THROTTLE_UNDEFINED)
+		return;
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 }
 
 void resctrl_file_fflags_init(const char *config, unsigned long fflags)

