Return-Path: <linux-tip-commits+bounces-7855-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09DD0DCAF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1A7230C610D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819832D8391;
	Sat, 10 Jan 2026 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYteJbID";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YEnEUuWJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9F29B20A;
	Sat, 10 Jan 2026 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074382; cv=none; b=tLtRMqomMkF3x4eSdTnbmXKBag169fNreSoUA9XZQ0QSoO3t9bBEQs8ZNAt2IuHQgeaayfxIYhj/8/KVIi47sppByLT/N/wwZ6lqSNwyL8Rgz7J6udiBQ8AHfxGcJYmEfVv17b+dPK7FlR3MMdxlG62HOb5tg9N8JzuXH/gT0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074382; c=relaxed/simple;
	bh=Y3IEFMywI+0S3JBSFzs4j/j2i35p9ojTTmPsjSa9wD0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MzOkGPZTgBQzGwaW49DZDHYEZa6tdY7ZJgLPKf8ujX6i1Q6VS4cxUZpr1z9uJO+02eNN3kW1wcX9Zn/+0C8w/snrDtJVlwyz2MHMXJMj3uRFT9yIU6IgQTIzS7eXnP0SWnbYzYRDOKDg14lHJTERnvME0Z4GMq6ARd9W+drltJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QYteJbID; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YEnEUuWJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O+Vy840m22TXlnS4fQhu3wes4xk7eUG60dnRoqIUj00=;
	b=QYteJbIDz/IGv83D5kZUnbHN3DkLTs2ZXDrbOKtKNnQxTv3R4pUtqMCsmtXgQoxngK0X1Q
	FIl//NxPF4dMsEh4czmm76hH7cjdInFJ0xYLnweUIfUuWYc9r4ei5zdMq6Ka4h2qvRxppU
	wh2vonUUUoD9lXH7QjuuS9EelQIEcK3My1/Hv/9X2LcYoJtcp7h1eX2jjsruOCozSfhSDW
	wjPuM0OyJzSVOUqqMQT2NEF47/4XKnH03kDgjZkw/iU9KB+qEFoRt1Y283mK0plk/zhkG2
	Ee6olxSWtfIDB5WM12fOsfTXicinQt8gUMg0ocgWd4riR7bLPodCFmWkHTzjiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=O+Vy840m22TXlnS4fQhu3wes4xk7eUG60dnRoqIUj00=;
	b=YEnEUuWJsHu9VPJwqbztiYR2SCmoJpy4cDVJ0ATpq+WCEKHSpfxbFz8aR8jwI6l8OjhnG2
	fvV4A4/rCJ5AAiAA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86,fs/resctrl: Add and initialize a resource for
 package scope monitoring
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807436733.510.16512267630246746893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2e53ad66686a46b141c3395719afeee3057ffe2f
Gitweb:        https://git.kernel.org/tip/2e53ad66686a46b141c3395719afeee3057=
ffe2f
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:01 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 16:37:07 +01:00

x86,fs/resctrl: Add and initialize a resource for package scope monitoring

Add a new PERF_PKG resource and introduce package level scope for monitoring
telemetry events so that CPU hotplug notifiers can build domains at the
package granularity.

Use the physical package ID available via topology_physical_package_id()
to identify the monitoring domains with package level scope. This enables
user space to use:

  /sys/devices/system/cpu/cpuX/topology/physical_package_id

to identify the monitoring domain a CPU is associated with.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 10 ++++++++++
 fs/resctrl/internal.h              |  2 ++
 fs/resctrl/rdtgroup.c              |  2 ++
 include/linux/resctrl.h            |  2 ++
 4 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index a2b7f86..f3d7e22 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -100,6 +100,14 @@ struct rdt_hw_resource rdt_resources_all[RDT_NUM_RESOURC=
ES] =3D {
 			.schema_fmt		=3D RESCTRL_SCHEMA_RANGE,
 		},
 	},
+	[RDT_RESOURCE_PERF_PKG] =3D
+	{
+		.r_resctrl =3D {
+			.name			=3D "PERF_PKG",
+			.mon_scope		=3D RESCTRL_PACKAGE,
+			.mon_domains		=3D mon_domain_init(RDT_RESOURCE_PERF_PKG),
+		},
+	},
 };
=20
 u32 resctrl_arch_system_num_rmid_idx(void)
@@ -440,6 +448,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl=
_scope scope)
 		return get_cpu_cacheinfo_id(cpu, scope);
 	case RESCTRL_L3_NODE:
 		return cpu_to_node(cpu);
+	case RESCTRL_PACKAGE:
+		return topology_physical_package_id(cpu);
 	default:
 		break;
 	}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 14e5a9e..0110d11 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -255,6 +255,8 @@ struct rdtgroup {
=20
 #define RFTYPE_ASSIGN_CONFIG		BIT(11)
=20
+#define RFTYPE_RES_PERF_PKG		BIT(12)
+
 #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
=20
 #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 0e3b8bc..a06cefd 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -2396,6 +2396,8 @@ static unsigned long fflags_from_resource(struct rdt_re=
source *r)
 	case RDT_RESOURCE_MBA:
 	case RDT_RESOURCE_SMBA:
 		return RFTYPE_RES_MB;
+	case RDT_RESOURCE_PERF_PKG:
+		return RFTYPE_RES_PERF_PKG;
 	}
=20
 	return WARN_ON_ONCE(1);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 2f938a5..861e63e 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -53,6 +53,7 @@ enum resctrl_res_level {
 	RDT_RESOURCE_L2,
 	RDT_RESOURCE_MBA,
 	RDT_RESOURCE_SMBA,
+	RDT_RESOURCE_PERF_PKG,
=20
 	/* Must be the last */
 	RDT_NUM_RESOURCES,
@@ -270,6 +271,7 @@ enum resctrl_scope {
 	RESCTRL_L2_CACHE =3D 2,
 	RESCTRL_L3_CACHE =3D 3,
 	RESCTRL_L3_NODE,
+	RESCTRL_PACKAGE,
 };
=20
 /**

