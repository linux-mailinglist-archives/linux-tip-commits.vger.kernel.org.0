Return-Path: <linux-tip-commits+bounces-6543-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0FB4FC2C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 15:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A448F3B3182
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5821FFC6D;
	Tue,  9 Sep 2025 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gT7kNdO8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d093Fct0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866A13774D;
	Tue,  9 Sep 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423748; cv=none; b=DEQa+zryA4cmT47/ZsGID7izZtp64YO9pXg4peGhkUcwGDW1oDOMYEDjPhLN7ARqYPJv9eqXqe3ukPdW2qxipTHX3q9NyMGAxydAO+I58vSV1MQgbxKXgkncAkbOeQtx1smFDfKot6xzTKYkn5b/TKJDA2ilnusxDrXv1pHV/EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423748; c=relaxed/simple;
	bh=QBwX/EKUW9vY3RxbJbBm1brFYAydWtPfIxW3hSGiwEs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=j+3lGHyFLdzqUZRn5FTAuBcfGMQzarL9SaCPDITEKbmA9VPiMjzqj3C9kWqbQ3mDMPEN/JMzH3bx9cRuRbgvNboI91K4POTVtCFeYEV7OqvFw2zHIEzITX5k/N+F8VSTie6XeEPRdE6leMU0gQa/MCswlaQPl8/IajdvehGK4SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gT7kNdO8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d093Fct0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 13:15:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757423743;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aoL/yAsWFWzL4Cp6itzGTPjU9AwJZAGFHVysPELO0vw=;
	b=gT7kNdO8C000zebX7m59jg/bel+ceQbT9+0gWGUMGSdCG0CPruP8LzkESHRO63C7PQ4QdV
	FQ65BgmqpGfWSfW5Jt/mEyAtlEI/3jw5bH6nOwN7uwTFyuNisDdaPaJHYiw+LKBYYf1s+M
	RjqfHu3TkRN2yzwhAZMvTbNYmj+9XMwmEyuKCxctgj5xLlI34Bu5PceQUpAugbJPXm7g6I
	I/tHfeqqP/jnut71TH5ua8wKadx9JPqBClPbq8E5CKEme0KXIE5wsRwNULXtZerdZLFkha
	O0Sm5HzyMv+qWD1Qi2mL0oQfA/7+KueaMySGvfEnkT4fg7cs59HIFv42CFEkqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757423743;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aoL/yAsWFWzL4Cp6itzGTPjU9AwJZAGFHVysPELO0vw=;
	b=d093Fct0uhBHjuYdnIc4tv5hJxV9Y3sdNGQZlDyszilOsCg94C1JO7htWoQ/lT7qnFW19e
	Tw9hX0tNzTql4zBA==
From: "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] fs/resctrl: Eliminate false positive lockdep
 warning when reading SNC counters
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175742374203.1920.16974187118083046833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d2e1b84c5141ff2ad465279acfc3cf943c960b78
Gitweb:        https://git.kernel.org/tip/d2e1b84c5141ff2ad465279acfc3cf943c9=
60b78
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Mon, 08 Sep 2025 15:15:51 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 09 Sep 2025 12:43:36 +02:00

fs/resctrl: Eliminate false positive lockdep warning when reading SNC counters

Running resctrl_tests on an SNC-2 system with lockdep debugging enabled
triggers several warnings with following trace:

  WARNING: CPU: 0 PID: 1914 at kernel/cpu.c:528 lockdep_assert_cpus_held
  ...
  Call Trace:
  __mon_event_count
  ? __lock_acquire
  ? __pfx___mon_event_count
  mon_event_count
  ? __pfx_smp_mon_event_count
  smp_mon_event_count
  smp_call_on_cpu_callback

get_cpu_cacheinfo_level() called from __mon_event_count() requires CPU hotplug
lock to be held. The hotplug lock is indeed held during this time, as
confirmed by the lockdep_assert_cpus_held() within mon_event_read() that calls
mon_event_count() via IPI, but the lockdep tracking is not able to follow the
IPI.

Fresh CPU cache information via get_cpu_cacheinfo_level() from
__mon_event_count() was added to support the fix for the issue where resctrl
inappropriately maintained links to L3 cache information that will be stale in
the case when the associated CPU goes offline.

Keep the cacheinfo ID in struct rdt_mon_domain to ensure that resctrl does not
maintain stale cache information while CPUs can go offline. Return to using
a pointer to the L3 cache information (struct cacheinfo) in struct rmid_read,
rmid_read::ci. Initialize rmid_read::ci before the IPI where it is used. CPU
hotplug lock is held across rmid_read::ci initialization and use to ensure
that it points to accurate cache information.

Fixes: 594902c986e2 ("x86,fs/resctrl: Remove inappropriate references to cach=
einfo in the resctrl subsystem")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 fs/resctrl/ctrlmondata.c | 2 +-
 fs/resctrl/internal.h    | 4 ++--
 fs/resctrl/monitor.c     | 6 ++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index d98e0d2..3c39cfa 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -625,11 +625,11 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 		 */
 		list_for_each_entry(d, &r->mon_domains, hdr.list) {
 			if (d->ci_id =3D=3D domid) {
-				rr.ci_id =3D d->ci_id;
 				cpu =3D cpumask_any(&d->hdr.cpu_mask);
 				ci =3D get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 				if (!ci)
 					continue;
+				rr.ci =3D ci;
 				mon_event_read(&rr, r, NULL, rdtgrp,
 					       &ci->shared_cpu_map, evtid, false);
 				goto checkresult;
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 0a1eedb..9a8cf6f 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -98,7 +98,7 @@ struct mon_data {
  *	   domains in @r sharing L3 @ci.id
  * @evtid: Which monitor event to read.
  * @first: Initialize MBM counter when true.
- * @ci_id: Cacheinfo id for L3. Only set when @d is NULL. Used when summing =
domains.
+ * @ci:    Cacheinfo for L3. Only set when @d is NULL. Used when summing dom=
ains.
  * @err:   Error encountered when reading counter.
  * @val:   Returned value of event counter. If @rgrp is a parent resource gr=
oup,
  *	   @val includes the sum of event counts from its child resource groups.
@@ -112,7 +112,7 @@ struct rmid_read {
 	struct rdt_mon_domain	*d;
 	enum resctrl_event_id	evtid;
 	bool			first;
-	unsigned int		ci_id;
+	struct cacheinfo	*ci;
 	int			err;
 	u64			val;
 	void			*arch_mon_ctx;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index f563785..7326c28 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -361,7 +361,6 @@ static int __mon_event_count(u32 closid, u32 rmid, struct=
 rmid_read *rr)
 {
 	int cpu =3D smp_processor_id();
 	struct rdt_mon_domain *d;
-	struct cacheinfo *ci;
 	struct mbm_state *m;
 	int err, ret;
 	u64 tval =3D 0;
@@ -389,8 +388,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct=
 rmid_read *rr)
 	}
=20
 	/* Summing domains that share a cache, must be on a CPU for that cache. */
-	ci =3D get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
-	if (!ci || ci->id !=3D rr->ci_id)
+	if (!cpumask_test_cpu(cpu, &rr->ci->shared_cpu_map))
 		return -EINVAL;
=20
 	/*
@@ -402,7 +400,7 @@ static int __mon_event_count(u32 closid, u32 rmid, struct=
 rmid_read *rr)
 	 */
 	ret =3D -EINVAL;
 	list_for_each_entry(d, &rr->r->mon_domains, hdr.list) {
-		if (d->ci_id !=3D rr->ci_id)
+		if (d->ci_id !=3D rr->ci->id)
 			continue;
 		err =3D resctrl_arch_rmid_read(rr->r, d, closid, rmid,
 					     rr->evtid, &tval, rr->arch_mon_ctx);

