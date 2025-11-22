Return-Path: <linux-tip-commits+bounces-7468-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4DBC7D377
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 411183499BD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84762DC76C;
	Sat, 22 Nov 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WKyll+aG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RK+/KiLO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2422BE02C;
	Sat, 22 Nov 2025 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826524; cv=none; b=HZ52xssuaXKmftzef5TDuv0Xnm03er4UhZYa2a1NKCR7uGe2As0exDF1nn5hfa+4gFpBna5/ybIwXRRnj3xq6GyQAhGRXL9g4udjldQSIAFQ/58bX8njVO2Tm7c8rPp+sOkEkFc5S8mR7WSVlv+w1qpwpY25Ho4SbWYam8n7ndE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826524; c=relaxed/simple;
	bh=Xk8gIaNTVz3TJljbAbSqcL5rvG+oNF/DmXMu2ZMQxZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lMHieaYyYnW9VgnSbJHli4ZvBTp7r7+B8TWnQSrogJrapTQh1QatYAHopF4p66wh/qVqXbVrriHghO97u4G2/HNrCHxkahiIIAsyexMo3oKZWfnUy29Kkfoxt4H1QXdv9nE2fvmTyBZK2ZJSdwcG0wsPAApQZysCfBWKqgt3bco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WKyll+aG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RK+/KiLO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1C4ZRL5dQAUIN09w/jQM03MFkaARWvwwe+pjIhi5at4=;
	b=WKyll+aGhh7Vb1NfYZp+30cCKdIQd6ijJSqpoOtVJ3Ffd/LJ5Q8ug4QlDyYuINwGwbSOUI
	Rbz8aFfq+1kf1rK/NuotX7ypUcfJBsXKjBRkLqB9WC8eA7QUucxV9ev3KL8Gy7qZvogh0O
	Yu6jB64mcwJp5gkxC1ns1TxI+Voyk39Mq9L6zmRy/8NKGFF0lMYhQOKzypGcvjBQnkpvCE
	x37hNsQxZwl1uapo3sTDx4wumzygcy+OKahadZpB4yh5cfJdxZ+e4KUCrwCEpHKKNVkAnA
	5GbjHt1YG46RB+8cEZDF6eDnRma9G3Ru/eV9YvrvtzzzA41ij/F55ErF+7F4UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1C4ZRL5dQAUIN09w/jQM03MFkaARWvwwe+pjIhi5at4=;
	b=RK+/KiLOmy0bv8FVoO3aoWPYk40gVWGRJBoBdzTQhn4dZMazqLgblJOeESVVphUwUIMdzp
	yUx0gomdrtJG42CQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Detect io_alloc feature
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <df85a9a6081674fd3ef6b4170920485512ce2ded.1762995456.git.babu.moger@amd.com>
References:
 <df85a9a6081674fd3ef6b4170920485512ce2ded.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382652022.498.17845526767339022307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     7923ae7698cf9728501974d76d8ea712686281bc
Gitweb:        https://git.kernel.org/tip/7923ae7698cf9728501974d76d8ea712686=
281bc
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:29 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Nov 2025 22:04:59 +01:00

x86,fs/resctrl: Detect io_alloc feature

AMD's SDCIAE (SDCI Allocation Enforcement) PQE feature enables system software
to control the portions of L3 cache used for direct insertion of data from I/O
devices into the L3 cache.

Introduce a generic resctrl cache resource property "io_alloc_capable" as the
first part of the new "io_alloc" resctrl feature that will support AMD's
SDCIAE. Any architecture can set a cache resource as "io_alloc_capable" if
a portion of the cache can be allocated for I/O traffic.

Set the "io_alloc_capable" property for the L3 cache resource on x86 (AMD)
systems that support SDCIAE.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/df85a9a6081674fd3ef6b4170920485512ce2ded.17629=
95456.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 7 +++++++
 include/linux/resctrl.h            | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 2b2935b..3792ab4 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -274,6 +274,11 @@ static void rdt_get_cdp_config(int level)
 	rdt_resources_all[level].r_resctrl.cdp_capable =3D true;
 }
=20
+static void rdt_set_io_alloc_capable(struct rdt_resource *r)
+{
+	r->cache.io_alloc_capable =3D true;
+}
+
 static void rdt_get_cdp_l3_config(void)
 {
 	rdt_get_cdp_config(RDT_RESOURCE_L3);
@@ -855,6 +860,8 @@ static __init bool get_rdt_alloc_resources(void)
 		rdt_get_cache_alloc_cfg(1, r);
 		if (rdt_cpu_has(X86_FEATURE_CDP_L3))
 			rdt_get_cdp_l3_config();
+		if (rdt_cpu_has(X86_FEATURE_SDCIAE))
+			rdt_set_io_alloc_capable(r);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CAT_L2)) {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index a7d9271..533f240 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -206,6 +206,8 @@ struct rdt_mon_domain {
  * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
  * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
  *				level has CPU scope.
+ * @io_alloc_capable:	True if portion of the cache can be configured
+ *			for I/O traffic.
  */
 struct resctrl_cache {
 	unsigned int	cbm_len;
@@ -213,6 +215,7 @@ struct resctrl_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmasks;
 	bool		arch_has_per_cpu_cfg;
+	bool		io_alloc_capable;
 };
=20
 /**

