Return-Path: <linux-tip-commits+bounces-6963-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03486BF25CC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Oct 2025 18:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45F53A806C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 20 Oct 2025 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D6283682;
	Mon, 20 Oct 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cIZuMcJ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Frw6gIzy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630D1F875A;
	Mon, 20 Oct 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977004; cv=none; b=I8x6NaU7fCL6tg4VHHHl3xTonLuzWEPGd4YBGBn3i21YR81ynxR9uHRSmbDE5iiJfGRnD/uBZSWcJyaM7a0v+/OKopDp/pIhKOA5VhFqgrRUMUlNwvgSjtL6ORYLeoT6Ifbn1nLsFCLVwEQnpIVF7PgYYJAtclXGfaMGY0a1hws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977004; c=relaxed/simple;
	bh=KiMV88naAvNGqD6/P2CoP/o4jIDZv0w8Ks277SHNBcY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qLftKF/0//eITtN/MHqC+2cD28Zwx64OTfIlGia+1+hyAbdKyDoYO6cv5Qgav1Rn3wy1AEZW+0Rh0rFYYrGd82EEhvlaDcUpNBRyR5RvCd4ZTTbig0CggYiMyTgy05IW9H8VCZ7C8VKBHXBpeLZeg5S5QdgT/z2YZCHsIm5epQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cIZuMcJ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Frw6gIzy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 20 Oct 2025 16:16:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760977000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwMa4qwpeiYK6uMvBc/dyrJpfPZJ8N70kiMTfYlE7ao=;
	b=cIZuMcJ5Fse0lXCBu99UQkZdPHGqqtWElUD1F1AhlrBdg6we8zMajdfu7+GradWKBWC5B7
	NA4Geq4JQ0P04ZPGHoQz0SPz2aCO8IYRP37CmBW2drIwt5wvCYNIxBfQlBAvG9FlXOsUY8
	FyWPzeVtQa6VUv1W7Pl2tyeJ/ju6DaF4amN02mlAheddUBJR2F3R1v7bKOv7FeXqWHu+9x
	yJMmFyD+mApgaU4MdR0UhRbbaj/B9Vt3LoOjFeu1N0uDaP/eqIZS6ZPqJQ94VzTgFxGJke
	ORnddZD5X6j+Ky5d4xPBLALegum3zkCYSjCdupzyT9YsISBDPN9pkar3MUUlMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760977000;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SwMa4qwpeiYK6uMvBc/dyrJpfPZJ8N70kiMTfYlE7ao=;
	b=Frw6gIzy1lK9flHWzdqzT6HIfGf0arTkqHfFnv/eRlKpoccZC80tGl1vPorkmIvqCEBH2L
	YU5glqRCky3BgXBQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86,fs/resctrl: Fix NULL pointer dereference with
 events force-disabled in mbm_event mode
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <a62e6ac063d0693475615edd213d5be5e55443e6.1760560934.git.babu.moger@amd.com>
References:
 <a62e6ac063d0693475615edd213d5be5e55443e6.1760560934.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176097699593.2601451.1411282576310072979.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     19de7113bfac33ba92c004a9b510612bb745cfa0
Gitweb:        https://git.kernel.org/tip/19de7113bfac33ba92c004a9b510612bb74=
5cfa0
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Thu, 16 Oct 2025 08:34:19 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 20 Oct 2025 18:06:31 +02:00

x86,fs/resctrl: Fix NULL pointer dereference with events force-disabled in mb=
m_event mode

The following NULL pointer dereference is encountered on mount of resctrl fs
after booting a system that supports assignable counters with the
"rdt=3D!mbmtotal,!mbmlocal" kernel parameters:

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:mbm_cntr_get
  Call Trace:
  rdtgroup_assign_cntr_event
  rdtgroup_assign_cntrs
  rdt_get_tree

Specifying the kernel parameter "rdt=3D!mbmtotal,!mbmlocal" effectively disab=
les
the legacy X86_FEATURE_CQM_MBM_TOTAL and X86_FEATURE_CQM_MBM_LOCAL features
and the MBM events they represent. This results in the per-domain MBM event
related data structures to not be allocated during early initialization.

resctrl fs initialization follows by implicitly enabling both MBM total and
local events on a system that supports assignable counters (mbm_event mode),
but this enabling occurs after the per-domain data structures have been
created.

After booting, resctrl fs assumes that an enabled event can access all its
state. This results in NULL pointer dereference when resctrl attempts to
access the un-allocated structures of an enabled event.

Remove the late MBM event enabling from resctrl fs.

This leaves a problem where the X86_FEATURE_CQM_MBM_TOTAL and
X86_FEATURE_CQM_MBM_LOCAL features may be disabled while assignable counter
(mbm_event) mode is enabled without any events to support. Switching between
the "default" and "mbm_event" mode without any events is not practical.

Create a dependency between the X86_FEATURE_{CQM_MBM_TOTAL,CQM_MBM_LOCAL} and
X86_FEATURE_ABMC (assignable counter) hardware features. An x86 system that
supports assignable counters now requires support of X86_FEATURE_CQM_MBM_TOTAL
or X86_FEATURE_CQM_MBM_LOCAL.

This ensures all needed MBM related data structures are created before use and
that it is only possible to switch between "default" and "mbm_event" mode when
the same events are available in both modes. This dependency does not exist in
the hardware but this usage of these feature settings work for known systems.

  [ bp: Massage commit message. ]

Fixes: 13390861b426e ("x86,fs/resctrl: Detect Assignable Bandwidth Monitoring=
 feature details")
Co-developed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/a62e6ac063d0693475615edd213d5be5e55443e6.17605=
60934.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 11 ++++++++++-
 fs/resctrl/monitor.c                  | 16 +++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 2cd25a0..fe1a2aa 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -458,7 +458,16 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 		r->mon.mbm_cfg_mask =3D ecx & MAX_EVT_CONFIG_BITS;
 	}
=20
-	if (rdt_cpu_has(X86_FEATURE_ABMC)) {
+	/*
+	 * resctrl assumes a system that supports assignable counters can
+	 * switch to "default" mode. Ensure that there is a "default" mode
+	 * to switch to. This enforces a dependency between the independent
+	 * X86_FEATURE_ABMC and X86_FEATURE_CQM_MBM_TOTAL/X86_FEATURE_CQM_MBM_LOCAL
+	 * hardware features.
+	 */
+	if (rdt_cpu_has(X86_FEATURE_ABMC) &&
+	    (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL) ||
+	     rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL))) {
 		r->mon.mbm_cntr_assignable =3D true;
 		cpuid_count(0x80000020, 5, &eax, &ebx, &ecx, &edx);
 		r->mon.num_mbm_cntrs =3D (ebx & GENMASK(15, 0)) + 1;
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 4076336..572a992 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1782,15 +1782,13 @@ int resctrl_mon_resource_init(void)
 		mba_mbps_default_event =3D QOS_L3_MBM_TOTAL_EVENT_ID;
=20
 	if (r->mon.mbm_cntr_assignable) {
-		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
-			resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
-		if (!resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
-			resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
-		mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg =3D r->mon.mbm_cfg_mask;
-		mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg =3D r->mon.mbm_cfg_mask &
-								   (READS_TO_LOCAL_MEM |
-								    READS_TO_LOCAL_S_MEM |
-								    NON_TEMP_WRITE_TO_LOCAL_MEM);
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_TOTAL_EVENT_ID].evt_cfg =3D r->mon.mbm_cfg_mask;
+		if (resctrl_is_mon_event_enabled(QOS_L3_MBM_LOCAL_EVENT_ID))
+			mon_event_all[QOS_L3_MBM_LOCAL_EVENT_ID].evt_cfg =3D r->mon.mbm_cfg_mask &
+									   (READS_TO_LOCAL_MEM |
+									    READS_TO_LOCAL_S_MEM |
+									    NON_TEMP_WRITE_TO_LOCAL_MEM);
 		r->mon.mbm_assign_on_mkdir =3D true;
 		resctrl_file_fflags_init("num_mbm_cntrs",
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);

