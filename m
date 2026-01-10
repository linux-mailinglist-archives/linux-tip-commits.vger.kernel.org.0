Return-Path: <linux-tip-commits+bounces-7861-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E107D0DC82
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5CD9030274EA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539582E06D2;
	Sat, 10 Jan 2026 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CWmQlepY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1GUuUXWL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C572BDC0B;
	Sat, 10 Jan 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074388; cv=none; b=Np6SiwmSgE/icm15h5fode/Mme7nOgaKEw3RJtCmcLyfAAgNJUZJTqNfmxNOL0pLHet003OkE67PucTiEG/J/1UxG3lJ6PjLYXAwYkN8D4MhokrB3FBdKvh2kuM9CAp7lapILm2A9BvZLVQjA2VsnLqoS7XNooukBXNnf6zgGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074388; c=relaxed/simple;
	bh=0JFax11Va32SyHtgJxSZhIDSc5RKuHu7M/9xksBNiuw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mnwsVpDRxJvnlmZBTpjuXAzo2lRfTZnGjcPgy1KvOld6I9iw1Gha9p77mr16Nk2XyBimb1wQexmfNZwgU0BQNb8rwLtSxdt33o3p+lSVsH4bQ9yDtMYIsIXne6AGknuVYByEtRLwsFJU72iJlzNLSc41sG4i1ao6TuaE68WisUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CWmQlepY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1GUuUXWL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=p+5LDTgIfWUPOVkVrMi0hr23t+uUb11T4ja9Qt9kA80=;
	b=CWmQlepYOb8MAwEzmWmDPt1KhoBex23Pz+91WYsVvTuT/FqKIRMH4sJdJze1mwzSsZzOc8
	65vMvDoePNxMrD91Jpxk7FYYSbmTQr3rkImicz4pa6NiWVndWa7w3AxN8ZH7tSVdMnYlQ7
	KnsiaisPQv4DbWLX4HKNF1rbHDnSbl3ZYrUzzqov3zBwRQmsO35tLqlk1n63Q72QhgC4kZ
	UxvrRLAr0LsvhkCRMvRO+pF3TPK7shgbXMO5lZ1rixOiUqGjx6IogB0sYX1bFqfXSPfKpK
	O8JcMhfFFiCfWrrBTTWnyyaAvowf4tCfEv7eyq1kOKqDdDowdVLPRXDQiWdmHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=p+5LDTgIfWUPOVkVrMi0hr23t+uUb11T4ja9Qt9kA80=;
	b=1GUuUXWLjFmlhFLQzc8qBk3EbdyxU2niTZGnwDQi4cenmT6nSeq0l5gpB4rLru5G2vnLdh
	r8XPwKAGwNaKD9Ag==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Split L3 dependent parts out of
 __mon_event_count()
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437595.510.5355409251240135453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ad5c2ff75e0c53d2588dfc10eb87458e759b6bbe
Gitweb:        https://git.kernel.org/tip/ad5c2ff75e0c53d2588dfc10eb87458e759=
b6bbe
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:53 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 10:18:33 +01:00

fs/resctrl: Split L3 dependent parts out of __mon_event_count()

Carve out the L3 resource specific event reading code into a separate helper
to support reading event data from a new monitoring resource.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 fs/resctrl/monitor.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 572a992..b5e0db3 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -413,7 +413,7 @@ static void mbm_cntr_free(struct rdt_mon_domain *d, int c=
ntr_id)
 	memset(&d->cntr_cfg[cntr_id], 0, sizeof(*d->cntr_cfg));
 }
=20
-static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
+static int __l3_mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *r=
r)
 {
 	int cpu =3D smp_processor_id();
 	u32 closid =3D rdtgrp->closid;
@@ -494,6 +494,17 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, st=
ruct rmid_read *rr)
 	return ret;
 }
=20
+static int __mon_event_count(struct rdtgroup *rdtgrp, struct rmid_read *rr)
+{
+	switch (rr->r->rid) {
+	case RDT_RESOURCE_L3:
+		return __l3_mon_event_count(rdtgrp, rr);
+	default:
+		rr->err =3D -EINVAL;
+		return -EINVAL;
+	}
+}
+
 /*
  * mbm_bw_count() - Update bw count from values previously read by
  *		    __mon_event_count().

