Return-Path: <linux-tip-commits+bounces-7462-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FC2C7D34A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9A9634E0AF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FC4C6D;
	Sat, 22 Nov 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hccxGW7B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/LAyEgL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2823E340;
	Sat, 22 Nov 2025 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826504; cv=none; b=BSnk6azmkYgBdMWX7qhefcpjygZgJP5bPkO6/8KVSBfXk9suQMdtmXIZpkQQ1IzJ/BjVeteMSYS1gFH+WH7rzBDmjwDzuvDF6MPOSXNCXFdkKUz3hyDLyTA38CFLNqHG8tDo1de+7SIWg9+3QqTAhvBk/aXtvTLu0FeUYRKRgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826504; c=relaxed/simple;
	bh=YcKNJpp9vlPv7znKdbKZ3rlFm50VmXJgkkqhVnF7IgY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZRwoPAh5zh8Wp7X+rhvzGwRvdQO5R0DX69cVBmaZH92t/upI3wjY42oOWeoiaP0LajJ3LmeoVTQs0PtH4O2T+f9MvLSdI8DTGI/tsd3WoA/VhEnL0L2aRPxz+PMP4H3ZU60qozMY+fZVeoCbZf/uH30VXFjzoviQGrYP32X/jD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hccxGW7B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/LAyEgL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZzKuwQQBQP2Ote8S8mcAxsIw8VuqO0l6zCmvKK03MQ=;
	b=hccxGW7B71vru3POERvtuX/Js7FsB+SuEgo7uPOF/VN66t0qboRHAU9a+Xk75kSKnhdxLW
	3xDXlt8Br50kn4+wLjOaOlz8LSVSJHB7I78jrHKqOo29zWEoajqWdccJ3Y2/eZoB9SojmB
	sRlP41rv4sHBerYnq0rQ+Q/zjI/zqd9szOVxijAD4K7J7PZvD08g+7J+PR/6bbI55Lve4n
	kTmrA/T/yMmKfrhqjTI0vPhmmhHuchhHBizmB1o226+6w29DtGHAx2j0m54p/iu/LTOMJ5
	rYi3PqJ2Tll2hYA3GHDMInlFiaxJy7t1px1b+6Uj1iKs/Ns6QSE4MuWclaITDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZzKuwQQBQP2Ote8S8mcAxsIw8VuqO0l6zCmvKK03MQ=;
	b=P/LAyEgLavPVZuHV6XS4N9pgO1a9T9knhFbYZU4+wP8dnrSQ4F2MYahAqRH19D6xtgrTXe
	D+sn9xocAL+hmrAg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Update bit_usage to reflect io_alloc
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <e02a0d424129fd7f3e45822a559b1c614ae4652a.1762995456.git.babu.moger@amd.com>
References:
 <e02a0d424129fd7f3e45822a559b1c614ae4652a.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382649929.498.8411171126977024741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ac7de456a37f9b126eb53b89c2bb27d625dc5fd9
Gitweb:        https://git.kernel.org/tip/ac7de456a37f9b126eb53b89c2bb27d625d=
c5fd9
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:36 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 22 Nov 2025 14:30:34 +01:00

fs/resctrl: Update bit_usage to reflect io_alloc

The "shareable_bits" and "bit_usage" resctrl files associated with cache
resources give insight into how instances of a cache is used.

Update the annotated capacity bitmasks displayed by "bit_usage" to include the
cache portions allocated for I/O via the "io_alloc" feature. "shareable_bits"
is a global bitmask of shareable cache with I/O and can thus not present the
per-domain I/O allocations possible with the "io_alloc" feature. Revise the
"shareable_bits" documentation to direct users to "bit_usage" for accurate
cache usage information.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/e02a0d424129fd7f3e45822a559b1c614ae4652a.17629=
95456.git.babu.moger@amd.com
---
 Documentation/filesystems/resctrl.rst | 35 +++++++++++++++-----------
 fs/resctrl/ctrlmondata.c              |  2 +-
 fs/resctrl/internal.h                 |  1 +-
 fs/resctrl/rdtgroup.c                 | 21 ++++++++++++++--
 4 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index bbc4b6c..8c8ce67 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -96,12 +96,19 @@ related to allocation:
 		must be set when writing a mask.
=20
 "shareable_bits":
-		Bitmask of shareable resource with other executing
-		entities (e.g. I/O). User can use this when
-		setting up exclusive cache partitions. Note that
-		some platforms support devices that have their
-		own settings for cache use which can over-ride
-		these bits.
+		Bitmask of shareable resource with other executing entities
+		(e.g. I/O). Applies to all instances of this resource. User
+		can use this when setting up exclusive cache partitions.
+		Note that some platforms support devices that have their
+		own settings for cache use which can over-ride these bits.
+
+		When "io_alloc" is enabled, a portion of each cache instance can
+		be configured for shared use between hardware and software.
+		"bit_usage" should be used to see which portions of each cache
+		instance is configured for hardware use via "io_alloc" feature
+		because every cache instance can have its "io_alloc" bitmask
+		configured independently via "io_alloc_cbm".
+
 "bit_usage":
 		Annotated capacity bitmasks showing how all
 		instances of the resource are used. The legend is:
@@ -115,16 +122,16 @@ related to allocation:
 			"H":
 			      Corresponding region is used by hardware only
 			      but available for software use. If a resource
-			      has bits set in "shareable_bits" but not all
-			      of these bits appear in the resource groups'
-			      schematas then the bits appearing in
-			      "shareable_bits" but no resource group will
-			      be marked as "H".
+			      has bits set in "shareable_bits" or "io_alloc_cbm"
+			      but not all of these bits appear in the resource
+			      groups' schemata then the bits appearing in
+			      "shareable_bits" or "io_alloc_cbm" but no
+			      resource group will be marked as "H".
 			"X":
 			      Corresponding region is available for sharing and
-			      used by hardware and software. These are the
-			      bits that appear in "shareable_bits" as
-			      well as a resource group's allocation.
+			      used by hardware and software. These are the bits
+			      that appear in "shareable_bits" or "io_alloc_cbm"
+			      as well as a resource group's allocation.
 			"S":
 			      Corresponding region is used by software
 			      and available for sharing.
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 332918f..b2d178d 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -750,7 +750,7 @@ out:
  * resource. Note that if Code Data Prioritization (CDP) is enabled, the num=
ber
  * of available CLOSIDs is reduced by half.
  */
-static u32 resctrl_io_alloc_closid(struct rdt_resource *r)
+u32 resctrl_io_alloc_closid(struct rdt_resource *r)
 {
 	if (resctrl_arch_get_cdp_enabled(r->rid))
 		return resctrl_arch_get_num_closid(r) / 2  - 1;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index e1eda74..bff4a54 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -442,6 +442,7 @@ int resctrl_io_alloc_cbm_show(struct kernfs_open_file *of=
, struct seq_file *seq,
 			      void *v);
 ssize_t resctrl_io_alloc_cbm_write(struct kernfs_open_file *of, char *buf,
 				   size_t nbytes, loff_t off);
+u32 resctrl_io_alloc_closid(struct rdt_resource *r);
=20
 #ifdef CONFIG_RESCTRL_FS_PSEUDO_LOCK
 int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 3614974..8e39dfd 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1062,15 +1062,17 @@ static int rdt_bit_usage_show(struct kernfs_open_file=
 *of,
=20
 	cpus_read_lock();
 	mutex_lock(&rdtgroup_mutex);
-	hw_shareable =3D r->cache.shareable_bits;
 	list_for_each_entry(dom, &r->ctrl_domains, hdr.list) {
 		if (sep)
 			seq_putc(seq, ';');
+		hw_shareable =3D r->cache.shareable_bits;
 		sw_shareable =3D 0;
 		exclusive =3D 0;
 		seq_printf(seq, "%d=3D", dom->hdr.id);
 		for (i =3D 0; i < closids_supported(); i++) {
-			if (!closid_allocated(i))
+			if (!closid_allocated(i) ||
+			    (resctrl_arch_get_io_alloc_enabled(r) &&
+			     i =3D=3D resctrl_io_alloc_closid(r)))
 				continue;
 			ctrl_val =3D resctrl_arch_get_config(r, dom, i,
 							   s->conf_type);
@@ -1098,6 +1100,21 @@ static int rdt_bit_usage_show(struct kernfs_open_file =
*of,
 				break;
 			}
 		}
+
+		/*
+		 * When the "io_alloc" feature is enabled, a portion of the cache
+		 * is configured for shared use between hardware and software.
+		 * Also, when CDP is enabled the CBMs of CDP_CODE and CDP_DATA
+		 * resources are kept in sync. So, the CBMs for "io_alloc" can
+		 * be accessed through either resource.
+		 */
+		if (resctrl_arch_get_io_alloc_enabled(r)) {
+			ctrl_val =3D resctrl_arch_get_config(r, dom,
+							   resctrl_io_alloc_closid(r),
+							   s->conf_type);
+			hw_shareable |=3D ctrl_val;
+		}
+
 		for (i =3D r->cache.cbm_len - 1; i >=3D 0; i--) {
 			pseudo_locked =3D dom->plr ? dom->plr->cbm : 0;
 			hwb =3D test_bit(i, &hw_shareable);

