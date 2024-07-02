Return-Path: <linux-tip-commits+bounces-1577-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA4924831
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C822287DCA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0E31D3644;
	Tue,  2 Jul 2024 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XgcWnzC+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nbHmVaWl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF531CF3E3;
	Tue,  2 Jul 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948260; cv=none; b=Xwky7MBPVjhwIEIkAjO/3DjmR8pNHZdJf70Qdc4fcEHeAt7Wl6TlXly4Hee02xUv7UYZPywtMr6mmN3xQ8TOTQBDEYmALn5ZnODApdc812t4Zn6Q1/36cjGOD0X5fgDhrTvLVOB+UZy31IX6HygRez7DZLHnvUSsrA2K66LeoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948260; c=relaxed/simple;
	bh=+Dk9q+WbJX/fnLZOmwEKFm7wLU1Tv4De9I5+U5abbso=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DsjwUCsfwx+P2dgQHvfhUffOENEe2TLXOn0oZPgYDeHRXRQSXdq5+K57HHflEH7xA8T9/LX984zmfI0BsJp2pwSYChPWSn6JYeUCv/3TkQ8cj8qcvZJWuYk1/h9OILDg9ssBWq2thIp23hX1+6AgcVkAdthYWbb7asviux9MSRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XgcWnzC+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nbHmVaWl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4RopiyGrQraoFFRz3HbRokR7605+HEnrv4hc9l7m58=;
	b=XgcWnzC+2RtZVByT8CLh1wSSIPABfPU01tbNoqBGdtPv3ERcm36t/9WXcgy4Q04EcmI7J/
	4x4N6RMCmmBzQxhitv49ASAi2JKtFeYgZz8WjkJ0vH/iF7uRnwDXRzuk8hJIy1M72l8kKh
	GDshF3krkw5AmgeNaK2DahOaU2vAX5l/HfzKphbK8q335sMoryaDFKuOm+bI8ihCSXcml/
	uT2BLWZgiqAq8Tw+nCCMoSxhn9YKyeEiVBB/nbzqzCpObRj/zQO1pcgT8vmRZk1aysWRKo
	/VfD+7QWn0X92QjNPy1TUe6A8YmKp2f4XhdlwCM1cWDzvwcTM3EjzGdm6frEvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948254;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4RopiyGrQraoFFRz3HbRokR7605+HEnrv4hc9l7m58=;
	b=nbHmVaWltRKudpdE1t0w8a7r1hxWP7kAaVe3zNSUN39UcFFqSCMK9/HCopKxXCXzQCIoOQ
	RNVjXCynoraxPICA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Initialize on-stack struct rmid_read instances
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-11-tony.luck@intel.com>
References: <20240628215619.76401-11-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825415.2215.13170170224791872909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     587edd7069b9e7dc7993d2df9371e7c37a4d2133
Gitweb:        https://git.kernel.org/tip/587edd7069b9e7dc7993d2df9371e7c37a4d2133
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:10 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Initialize on-stack struct rmid_read instances

New semantics rely on some struct rmid_read members having NULL values to
distinguish between the SNC and non-SNC scenarios.  resctrl can thus no longer
rely on this struct not being initialized properly.

Initialize all on-stack declarations of struct rmid_read:

  rdtgroup_mondata_show()
  mbm_update()
  mkdir_mondata_subdir()

to ensure that garbage values from the stack are not passed down to other
functions.

  [ bp: Massage commit message. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-11-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 3 +--
 arch/x86/kernel/cpu/resctrl/monitor.c     | 3 +--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 3b93836..4d76ff3 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -529,7 +529,6 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 	rr->evtid = evtid;
 	rr->r = r;
 	rr->d = d;
-	rr->val = 0;
 	rr->first = first;
 	rr->arch_mon_ctx = resctrl_arch_mon_ctx_alloc(r, evtid);
 	if (IS_ERR(rr->arch_mon_ctx)) {
@@ -557,12 +556,12 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 {
 	struct kernfs_open_file *of = m->private;
 	struct rdt_domain_hdr *hdr;
+	struct rmid_read rr = {0};
 	struct rdt_mon_domain *d;
 	u32 resid, evtid, domid;
 	struct rdtgroup *rdtgrp;
 	struct rdt_resource *r;
 	union mon_data_bits md;
-	struct rmid_read rr;
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index ff4e745..ca309c9 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -780,9 +780,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 static void mbm_update(struct rdt_resource *r, struct rdt_mon_domain *d,
 		       u32 closid, u32 rmid)
 {
-	struct rmid_read rr;
+	struct rmid_read rr = {0};
 
-	rr.first = false;
 	rr.r = r;
 	rr.d = d;
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 70d41a8..d044358 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3029,10 +3029,10 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
 				struct rdt_mon_domain *d,
 				struct rdt_resource *r, struct rdtgroup *prgrp)
 {
+	struct rmid_read rr = {0};
 	union mon_data_bits priv;
 	struct kernfs_node *kn;
 	struct mon_evt *mevt;
-	struct rmid_read rr;
 	char name[32];
 	int ret;
 

