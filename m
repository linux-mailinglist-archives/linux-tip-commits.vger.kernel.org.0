Return-Path: <linux-tip-commits+bounces-3063-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA89F17C0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146FA18877C8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736C51A7060;
	Fri, 13 Dec 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmacGDKx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qh00nCyK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4519A2A3;
	Fri, 13 Dec 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123767; cv=none; b=ef1Kk5do6FhUoFRrMfOSvC051Takq/agkUmLdHdmxNlV7oF88ERW9zs4dDGR0rIaYGqNePp8YPilIaGaqySBgWXRGLTSl+o23IFkXepHr9jretcWEYRgOA/WcA7K12oEMwaX/shqhZrmc4M1CxsNqeBHhXXt2a8149AMSmipr5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123767; c=relaxed/simple;
	bh=icV936Ft1wVLgYRvyGdsk57eskbGjS+DQYmc9KCxCSw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nv1RI1aTMIXGcNyO9skHYWqD7kaA3HuXOPK7RsJel4Ui052+Wkuv17cnK7SwC01FwaKOQCrErhnGSJdn1C/wZvW1CCswcooyGzNqb+SQS+DvbyPDPCvWZWjIROvpBj7UNwUJ4WNxCeZsCLd7tG2mPyMGeDVPvQLslNOBs6W+ueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmacGDKx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qh00nCyK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gg13wBGdR8y1Au0BtYqTMJL7SbqL2x7508pv+kDbugE=;
	b=wmacGDKx5RkGzZsVWapbd8V5X7lVOn5ZHfDHxIEsYe3YGP7WIRJMtRk0373uOpQ8nZG/e3
	IPPMECwbrsAdZP1p0wHMK7HmLbB5Cy/I+jw3QJ+nbsklwEkSgt1nUTZJFvVzG4DMvgoCyo
	F8bLHgd7XcNGvl65ZizAdjclzhKDvo8C4IpxD/4eYbJziTqIul7cg0Guy+D4GVSTigyuJh
	k+zKUMyM2h53KHoPT94N/Szc/72XavEZDwsLufQZ1L+47KOpspXgx9CY7rHcgnHlE3IOYe
	h2dDldOMKfXBncKXRdVu4LdTRnlE3PY0MCVFZoMhrMDJfDq2W5ePIAQFK60PpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gg13wBGdR8y1Au0BtYqTMJL7SbqL2x7508pv+kDbugE=;
	b=Qh00nCyKVC5oxsC9ULtKm6IPwR2Jchj09v2ZubD0EWzL1bJKsV/RmOdWtZ2yEVj2U3lLQy
	evKrDmCF8ufEpABg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Modify update_mba_bw() to use per
 CTRL_MON group event
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241206163148.83828-4-tony.luck@intel.com>
References: <20241206163148.83828-4-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173412376135.412.1247835243821152150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     481d363748b2df881df21569f3697b3c7fcf8fc1
Gitweb:        https://git.kernel.org/tip/481d363748b2df881df21569f3697b3c7fcf8fc1
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 06 Dec 2024 08:31:43 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Dec 2024 11:15:19 +01:00

x86/resctrl: Modify update_mba_bw() to use per CTRL_MON group event

update_mba_bw() hard codes use of the memory bandwidth local event which
prevents more flexible options from being deployed.

Change this function to use the event specified in the rdtgroup that is
being processed.

Mount time checks for the "mba_MBps" option ensure that local memory
bandwidth is enabled. So drop the redundant is_mbm_local_enabled() check.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20241206163148.83828-4-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 69bdc11..adb18f0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -752,20 +752,20 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
 	struct rdt_ctrl_domain *dom_mba;
+	enum resctrl_event_id evt_id;
 	struct rdt_resource *r_mba;
-	u32 cur_bw, user_bw, idx;
 	struct list_head *head;
 	struct rdtgroup *entry;
-
-	if (!is_mbm_local_enabled())
-		return;
+	u32 cur_bw, user_bw;
 
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	evt_id = rgrp->mba_mbps_event;
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
-	pmbm_data = &dom_mbm->mbm_local[idx];
+	pmbm_data = get_mbm_state(dom_mbm, closid, rmid, evt_id);
+	if (WARN_ON_ONCE(!pmbm_data))
+		return;
 
 	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -784,7 +784,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	 */
 	head = &rgrp->mon.crdtgrp_list;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = get_mbm_state(dom_mbm, entry->closid, entry->mon.rmid, evt_id);
+		if (WARN_ON_ONCE(!cmbm_data))
+			return;
 		cur_bw += cmbm_data->prev_bw;
 	}
 

