Return-Path: <linux-tip-commits+bounces-1575-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23FF92482D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C11B259EC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 19:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851A1CFD77;
	Tue,  2 Jul 2024 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="071Su+Lp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8JTxsBRF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF071CF3E2;
	Tue,  2 Jul 2024 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948259; cv=none; b=T0JUP1NKrDDOfxJUCymSBMsTouDSgtBR2UbWpk5xzRf32CtFhUtqChJq0QZIQ3Ua+q2jt7Gk7wJidMRHOmGBornSNzWoj3bPOwJZOBJOU62KDz0C0IGthRmz6CgE8rMvRbRq6U5Q5+i72Xm7NT7NNAlgtv6xje/AqUgpKOugPzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948259; c=relaxed/simple;
	bh=PT9IYQYvj8lwNKg4h51uN3EbyaZouMkt9jY2RaHU4iE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MkRG1AYAB5ejybedR7Fgf4z67QAvKIxc9ZcrCAFsPumLbLUDaBjXPi8sgLa2mZN601nOq8xndt/noQZGdfBxhU47Eb2qfF01LpRajV4QbQWVRNWPHwWdbRLtrItcPmeuYPw2bHZGdwePSh5vhqQ3wZXUL06szth+wN+D2SHRVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=071Su+Lp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8JTxsBRF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 19:24:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719948255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyWXz0yR2vFxrJmQtNSC/bC/YiEatkm8TvI3v3uQY8E=;
	b=071Su+LpnKXSHiBEROmp0EMYi2Q57XDvHSrBykQ3ovqexMfi98exz3d5m0OEC/HmBK0Cnk
	IcQXEGE+sXuMGDwrCfvG+NovRzaL4NGZvQ6CDU7K2fAX95t+DOmNyg3RZFWCY6U80drKGT
	5l4rHrbJuqJq69Te2QF41n3b/AbHkcph4DGJq8ygTGA6pgeOSydeGAw/WtuVXRaNSePday
	/pt98K2sIbld0Rtz9fyUIsYs5S/eVaDH6x5V+Lkc65UxUX5K/3mdY5GXJSbM5ig17PqE/a
	mxa04khcUqE2/4qfQ4jrDfhSmI2W3Fpeg6kbKZNDItoaIOd5h6KKhzFUaa0ymQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719948255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iyWXz0yR2vFxrJmQtNSC/bC/YiEatkm8TvI3v3uQY8E=;
	b=8JTxsBRFCzkSq4UALbYEhXSuAE9fdxHO++JEFEfQ/+DDzUBjt1hshT3wUyKBpe70MtPDwk
	Jil8L2F/7JGwdhDg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Prepare for new Sub-NUMA Cluster (SNC)
 monitor files
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240628215619.76401-9-tony.luck@intel.com>
References: <20240628215619.76401-9-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171994825483.2215.17728955260068086457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     328ea688746420e12ced6cfbc5064413180244cc
Gitweb:        https://git.kernel.org/tip/328ea688746420e12ced6cfbc5064413180=
244cc
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 28 Jun 2024 14:56:08 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 02 Jul 2024 19:49:54 +02:00

x86/resctrl: Prepare for new Sub-NUMA Cluster (SNC) monitor files

When SNC is enabled, monitoring data is collected at the SNC node granularity,
but must be reported at L3-cache granularity for backwards compatibility in
addition to reporting at the node level.

Add a "ci" field to the rdt_mon_domain structure to save the cache information
about the enclosing L3 cache for the domain.  This provides:

1) The cache id which is needed to compose the name of the legacy monitoring
   directory, and to determine which domains should be summed to provide
   L3-scoped data.

2) The shared_cpu_map which is needed to determine which CPUs can be used to
   read the RMID counters with the MSR interface.

This is the first step to an eventual goal of monitor reporting files like th=
is
(for a system with two SNC nodes per L3):

  $ cd /sys/fs/resctrl/mon_data
  $ tree mon_L3_00
  mon_L3_00			<- 00 here is L3 cache id
  =E2=94=9C=E2=94=80=E2=94=80 llc_occupancy		\  These files provide legacy su=
pport
  =E2=94=9C=E2=94=80=E2=94=80 mbm_local_bytes		 > for non-SNC aware monitor a=
pps
  =E2=94=9C=E2=94=80=E2=94=80 mbm_total_bytes		/  that expect data at L3 cach=
e level
  =E2=94=9C=E2=94=80=E2=94=80 mon_sub_L3_00		<- 00 here is SNC node id
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 llc_occupancy		\  These f=
iles are finer grained
  =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 mbm_local_bytes		 > data =
from each SNC node
  =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 mbm_total_bytes		/
  =E2=94=94=E2=94=80=E2=94=80 mon_sub_L3_01
      =E2=94=9C=E2=94=80=E2=94=80 llc_occupancy		\
      =E2=94=9C=E2=94=80=E2=94=80 mbm_local_bytes		 > As above, but for node =
1.
      =E2=94=94=E2=94=80=E2=94=80 mbm_total_bytes		/

  [ bp: Massage commit message. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20240628215619.76401-9-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 7 ++++++-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 1 -
 include/linux/resctrl.h                   | 3 +++
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index b86c525..95ef8fe 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -19,7 +19,6 @@
 #include <linux/cpu.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/cacheinfo.h>
 #include <linux/cpuhotplug.h>
=20
 #include <asm/cpu_device_id.h>
@@ -608,6 +607,12 @@ static void domain_add_cpu_mon(int cpu, struct rdt_resou=
rce *r)
 	d =3D &hw_dom->d_resctrl;
 	d->hdr.id =3D id;
 	d->hdr.type =3D RESCTRL_MON_DOMAIN;
+	d->ci =3D get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
+	if (!d->ci) {
+		pr_warn_once("Can't find L3 cache for CPU:%d resource %s\n", cpu, r->name);
+		mon_domain_free(hw_dom);
+		return;
+	}
 	cpumask_set_cpu(cpu, &d->hdr.cpu_mask);
=20
 	if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/=
resctrl/pseudo_lock.c
index 70f0069..e69489d 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -11,7 +11,6 @@
=20
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
=20
-#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/debugfs.h>
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/res=
ctrl/rdtgroup.c
index d3b0fa9..70d41a8 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -12,7 +12,6 @@
=20
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
=20
-#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 #include <linux/fs.h>
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 64b6ad1..b0875b9 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -2,6 +2,7 @@
 #ifndef _RESCTRL_H
 #define _RESCTRL_H
=20
+#include <linux/cacheinfo.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/pid.h>
@@ -96,6 +97,7 @@ struct rdt_ctrl_domain {
 /**
  * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor resource
  * @hdr:		common header for different domain types
+ * @ci:			cache info for this domain
  * @rmid_busy_llc:	bitmap of which limbo RMIDs are above threshold
  * @mbm_total:		saved state for MBM total bandwidth
  * @mbm_local:		saved state for MBM local bandwidth
@@ -106,6 +108,7 @@ struct rdt_ctrl_domain {
  */
 struct rdt_mon_domain {
 	struct rdt_domain_hdr		hdr;
+	struct cacheinfo		*ci;
 	unsigned long			*rmid_busy_llc;
 	struct mbm_state		*mbm_total;
 	struct mbm_state		*mbm_local;

