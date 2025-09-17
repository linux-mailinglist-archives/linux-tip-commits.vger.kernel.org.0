Return-Path: <linux-tip-commits+bounces-6669-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD5B7CA17
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41422323997
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782330DD28;
	Wed, 17 Sep 2025 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zcwWvb6k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bZthe3oi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75592D879A;
	Wed, 17 Sep 2025 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101935; cv=none; b=XLp9jT0WqgL5hw/rfrudFZ5lnKJhm09nwrzqH7TfA3s93OSIJgMKYY54D7IA/7TEatiQ3o+ioez/qgKUjvswU9b5DCaV27TnpPK3I462rj82CxxGVXQopeJOPopLfS5CpcTKS931K8N62EJD04IMhPVl8XoPPLaL6BH1vCz++io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101935; c=relaxed/simple;
	bh=rX1dgYtKBUMjgmyK/uM4zn2/OjNpqCLEsKzNYMkddfU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rUCMqiK+VuphAmDg8ltKOOvDOYyc5Q1dlWqdQ8gex29DrIbAUI3zb05Eu3Cen6mlR1atnHuvp5GIjpu100IVY5Ezsy5bhdaZ2007zKLqwfCHcyt0+QIhB+ZedYmwI8SzSgkEyyULsqY5iLYfCsa0dE+I1QvaQOLEUmwb54X5Zlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zcwWvb6k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZthe3oi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 09:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758101930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwfAbh3Lrqs081eg/UWoHGxmf2ckmF7L05dKh2iA0Uo=;
	b=zcwWvb6kUsalzJzNgnIINnBnLFygJw50/JxJIwREMd5qfTejqhRxQGU5d18oauo4BLd/VG
	hyYTHPa3N1pyK5QDOxFuPjH0CMi+/KDNjRdXXKjzW3j+NtuOwWkvqGPFYUfz5P+rEbn2Ep
	aeq+4dZm83r15u7ZVviC7A/ORzkXmUyDXB5LybcqqhYOSuFAcREoSwOPxuaH/aSNZQAn8u
	DNh6Tkl7vAOMMt5/suFrMEcDVhPtTmNr/3AK8N0WRxkgQ+CDDk+1i/1/LFA94Wjv6eCt3k
	Q9ZKokV+BtujfJFqGz5AmhtiITInWKqL559o83Exqm9TYl7exRDzuwtjWo04Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758101930;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwfAbh3Lrqs081eg/UWoHGxmf2ckmF7L05dKh2iA0Uo=;
	b=bZthe3oiZtEg9hnaG8vhaO5ONc0hCuE76PoRWXfFtzYw6xRfTnjxSN065rxjE/K6CpiggQ
	214rOYm3ihF3NOBQ==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Fix counter auto-assignment on mkdir
 with mbm_event enabled
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <9788ef37c17a9559a08019b694d2a47b507aa4ac.1758043391.git.babu.moger@amd.com>
References:
 <9788ef37c17a9559a08019b694d2a47b507aa4ac.1758043391.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175810192896.709179.16893129735281399809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     dd86b69d20fb9fa7e941ed01ff05f1e662fcc3ff
Gitweb:        https://git.kernel.org/tip/dd86b69d20fb9fa7e941ed01ff05f1e662f=
cc3ff
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Tue, 16 Sep 2025 12:25:49 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 17 Sep 2025 11:31:12 +02:00

fs/resctrl: Fix counter auto-assignment on mkdir with mbm_event enabled

rdt_resource::resctrl_mon::mbm_assign_on_mkdir determines if a counter will
automatically be assigned to an RMID, MBM event pair when its associated
monitor group is created via mkdir.

Testing shows that counters are always automatically assigned to new monitor
groups, whether mbm_assign_on_mkdir is set or not.

To support automatic counter assignment the check for mbm_assign_on_mkdir
should be in rdtgroup_assign_cntrs() that assigns counters during monitor
group creation. Instead, the check for mbm_assign_on_mkdir is in
rdtgroup_unassign_cntrs() that is called on monitor group deletion from where
counters should always be unassigned, whether mbm_assign_on_mkdir is set or
not.

Fix automatic counter assignment by moving the mbm_assign_on_mkdir check from
rdtgroup_unassign_cntrs() to rdtgroup_assign_cntrs().

  [ bp: Replace commit message with Reinette's version. ]

Fixes: ef712fe97ec57 ("fs/resctrl: Auto assign counters on mkdir and clean up=
 on group removal")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
---
 fs/resctrl/monitor.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 50c2446..4076336 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -1200,7 +1200,8 @@ void rdtgroup_assign_cntrs(struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
=20
-	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
+	    !r->mon.mbm_assign_on_mkdir)
 		return;
=20
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))
@@ -1258,8 +1259,7 @@ void rdtgroup_unassign_cntrs(struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r =3D resctrl_arch_get_resource(RDT_RESOURCE_L3);
=20
-	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r) ||
-	    !r->mon.mbm_assign_on_mkdir)
+	if (!r->mon_capable || !resctrl_arch_mbm_cntr_assign_enabled(r))
 		return;
=20
 	if (resctrl_is_mon_event_enabled(QOS_L3_MBM_TOTAL_EVENT_ID))

