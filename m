Return-Path: <linux-tip-commits+bounces-7860-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D95FD0DC7F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49236301B8AF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6A82E0407;
	Sat, 10 Jan 2026 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rd7siM0n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TEJ1tTNE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679E2D77E9;
	Sat, 10 Jan 2026 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074388; cv=none; b=inWaW+sg++MVRXdQOYGHi6vyVQA1TjJw5a8dLZKWQe0mUPLLKHnPi31QaHoyiSm36k0xesMrpbOa2tUqVLNSuGAypewmXmw+EZPWnn3bqVoIwSUM3GI1BmnN1LsKDo+8PPWWitPoi+bfQFkNfsL9iXP1gKvhxg4Blk+hMdAmB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074388; c=relaxed/simple;
	bh=TMkQ/qrbVQPQhbo36E+wi5zwnfCe1faJv+efrBXAGro=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=psVOyYOrIABaGwA0KUUTOxI+z6QQXiZMvVAEuOBX7wWSk11ANk8TGNIS7Sg/KvGEdL1h8XWbIbyIPUMM1NQl/lbY7UYh598SyyoR0nEPKdJvmaENwJuwqMmTNYVKxZWuixtFrY3wm5IeK98lveMxe+ELmlMoiDmFwQoDHGvbt6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rd7siM0n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TEJ1tTNE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Jf0fAXSymIlIHo2kMayWo4JporAm1eqAtzf2vGuE5H8=;
	b=Rd7siM0nbfMmPncnT25JVQdcn17V4K9WyQWO+ky4eQGtzUyClaPQzoqFQKePBcP3HWRPe3
	jBGAQ24RrvpdFQ1RAiADTB1sUTP5uRHRNJQLd59AYuto7Brs+M3TzsW/hU2xVyxlm/4er6
	tAgw8O1H+TBU7MgDf2JF4iSX04jdP51CopjRJ38M2ua4hGypNPlmEuI1Diy6+rOEL34DvT
	whgr6QCX2bRG+cW5TeQ1A5dS4Q3lweEVHW9v1+fjv4hV0cN5JNQCjWqbTk0mFp7OqP4e0B
	PvhP2mbtSc9hNHtouWGx6s2JQU2I18Z+R3iA6QVVIcT7/+DKTF3MsZ27XAex0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Jf0fAXSymIlIHo2kMayWo4JporAm1eqAtzf2vGuE5H8=;
	b=TEJ1tTNE2ZJy7W/gZDdI0hpaZmMa1DD1HxzVp+6sPjJ7BmIOdlZeCle6WhxIVlh8+CuNj0
	RUd9PzbbzoHugjAQ==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Refactor domain_remove_cpu_mon() ready
 for new domain types
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437910.510.4044843748622184293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6396fc5351ea9130a72f6a2fc58eb7298ce6c15a
Gitweb:        https://git.kernel.org/tip/6396fc5351ea9130a72f6a2fc58eb7298ce=
6c15a
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:50 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 04 Jan 2026 08:01:51 +01:00

x86/resctrl: Refactor domain_remove_cpu_mon() ready for new domain types

New telemetry events will be associated with a new package scoped resource
with a new domain structure.

Refactor domain_remove_cpu_mon() so all the L3 domain processing is separate
from the general domain action of clearing the CPU bit in the mask.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 2a568b3..49b133e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -631,9 +631,7 @@ static void domain_remove_cpu_ctrl(int cpu, struct rdt_re=
source *r)
 static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
 {
 	int id =3D get_domain_id_from_scope(cpu, r->mon_scope);
-	struct rdt_hw_mon_domain *hw_dom;
 	struct rdt_domain_hdr *hdr;
-	struct rdt_mon_domain *d;
=20
 	lockdep_assert_held(&domain_list_lock);
=20
@@ -650,20 +648,29 @@ static void domain_remove_cpu_mon(int cpu, struct rdt_r=
esource *r)
 		return;
 	}
=20
-	if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, r->rid))
+	cpumask_clear_cpu(cpu, &hdr->cpu_mask);
+	if (!cpumask_empty(&hdr->cpu_mask))
 		return;
=20
-	d =3D container_of(hdr, struct rdt_mon_domain, hdr);
-	hw_dom =3D resctrl_to_arch_mon_dom(d);
+	switch (r->rid) {
+	case RDT_RESOURCE_L3: {
+		struct rdt_hw_mon_domain *hw_dom;
+		struct rdt_mon_domain *d;
=20
-	cpumask_clear_cpu(cpu, &d->hdr.cpu_mask);
-	if (cpumask_empty(&d->hdr.cpu_mask)) {
+		if (!domain_header_is_valid(hdr, RESCTRL_MON_DOMAIN, RDT_RESOURCE_L3))
+			return;
+
+		d =3D container_of(hdr, struct rdt_mon_domain, hdr);
+		hw_dom =3D resctrl_to_arch_mon_dom(d);
 		resctrl_offline_mon_domain(r, d);
-		list_del_rcu(&d->hdr.list);
+		list_del_rcu(&hdr->list);
 		synchronize_rcu();
 		mon_domain_free(hw_dom);
-
-		return;
+		break;
+	}
+	default:
+		pr_warn_once("Unknown resource rid=3D%d\n", r->rid);
+		break;
 	}
 }
=20

