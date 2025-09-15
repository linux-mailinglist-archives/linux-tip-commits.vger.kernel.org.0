Return-Path: <linux-tip-commits+bounces-6615-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F2B57825
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FA8445AF1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29543019DE;
	Mon, 15 Sep 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xV8Hy4hn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LxPAOdnw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEC2FF143;
	Mon, 15 Sep 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935659; cv=none; b=qmpjr7yr4M8dTiVx2tQqhiqBGtc6HIdq5wMjU75dUtpF+PKO4QPPywTsOlGJMvdeqMfoMutEGGnu/LzKDoYGcQfw37yxGMQooD0g3IK30Omrm6pAKjKPkUWAlQWFZrPc+3n+LQK+zSEJ9y9pXqUPUZKrrajkRxF27FpIYq1mJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935659; c=relaxed/simple;
	bh=wHz7tbRDLmUpSW4jY86D92U8Z1ZqUGEgov+bUpBhTls=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ez4Nne6m1dVF2M1gIU/A86QqxCsuvf7y7E0Xk9L/uVt/3Hc6IHyRVPNMl5xm9DaXhDcsMA3oV0XFu2X3HY3B7F7mbgGxumjIEKXx5fjinQc7h2XELLRDjTI6GJH0FDpPjhVAaHm3CO6J4rbCzNXSCZOMKT3LD3sOkNNE1BX+KVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xV8Hy4hn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LxPAOdnw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc/MX9OFJ3K3FYYdXAbUtta/syIrSzW/W391PamMeSA=;
	b=xV8Hy4hnkcU76igqc/PX/I/B2kYzELO+vOTBEDFyTCX9ZJK98KEn6viP/ceb6uu3UrvegH
	nqJCrhmzhVRgadINCZttHzPvZfvPWt4zZdX2eCSEzgvdgl4nZIUKqD6FB9Er0UhhR27g/z
	0MP/ZGFOR3D/37r6tSyGoE+s4QMeDASbfuP7RlJSxc7QaS6o5Iu2o/Szs9sPMjSH2b/c0G
	fg0a4hBVVkgNCLbEWwQp05sy91DbDQqaKXqofeeZaFA9nE4SAL7smxr9VItVoDUNksP1zT
	61PuQAErh+iOE1YpujwhnP26W67R6du3tx1oBQtf7+OswvDABXHc2/ycpq7y6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oc/MX9OFJ3K3FYYdXAbUtta/syIrSzW/W391PamMeSA=;
	b=LxPAOdnwm1Eeq6JX343S5pCBt5L+sWLjCtVh1wm9l0RtgW9wXxsGLRKqyGhhf2jjXE5p3W
	C1aQfI/fwIipjQAg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Introduce counter ID read, reset calls
 in mbm_event mode
Cc: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <7ffd07b6ce5f4f0c4719d9997b4580043c29176c.1757108044.git.babu.moger@amd.com>
References:
 <7ffd07b6ce5f4f0c4719d9997b4580043c29176c.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793565463.709179.8271374706957930792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     862314fd1f93d96eddb0559a807c66cb1f6ee520
Gitweb:        https://git.kernel.org/tip/862314fd1f93d96eddb0559a807c66cb1f6=
ee520
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:19 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:26:50 +02:00

fs/resctrl: Introduce counter ID read, reset calls in mbm_event mode

When supported, "mbm_event" counter assignment mode allows users to assign
a hardware counter to an RMID, event pair and monitor the bandwidth usage as
long as it is assigned. The hardware continues to track the assigned counter
until it is explicitly unassigned by the user.

Introduce the architecture calls resctrl_arch_cntr_read() and
resctrl_arch_reset_cntr() to read and reset event counters when "mbm_event"
mode is supported. Function names match existing resctrl_arch_rmid_read() and
resctrl_arch_reset_rmid().

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 include/linux/resctrl.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 50e3844..0415265 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -613,6 +613,44 @@ void resctrl_arch_config_cntr(struct rdt_resource *r, st=
ruct rdt_mon_domain *d,
 			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
 			      u32 cntr_id, bool assign);
=20
+/**
+ * resctrl_arch_cntr_read() - Read the event data corresponding to the count=
er ID
+ *			      assigned to the RMID, event pair for this resource
+ *			      and domain.
+ * @r:		Resource that the counter should be read from.
+ * @d:		Domain that the counter should be read from.
+ * @closid:	CLOSID that matches the RMID.
+ * @rmid:	The RMID to which @cntr_id is assigned.
+ * @cntr_id:	The counter to read.
+ * @eventid:	The MBM event to which @cntr_id is assigned.
+ * @val:	Result of the counter read in bytes.
+ *
+ * Called on a CPU that belongs to domain @d when "mbm_event" mode is enable=
d.
+ * Called from a non-migrateable process context via smp_call_on_cpu() unles=
s all
+ * CPUs are nohz_full, in which case it is called via IPI (smp_call_function=
_any()).
+ *
+ * Return:
+ * 0 on success, or -EIO, -EINVAL etc on error.
+ */
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 closid, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val);
+
+/**
+ * resctrl_arch_reset_cntr() - Reset any private state associated with count=
er ID.
+ * @r:		The domain's resource.
+ * @d:		The counter ID's domain.
+ * @closid:	CLOSID that matches the RMID.
+ * @rmid:	The RMID to which @cntr_id is assigned.
+ * @cntr_id:	The counter to reset.
+ * @eventid:	The MBM event to which @cntr_id is assigned.
+ *
+ * This can be called from any CPU.
+ */
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *=
d,
+			     u32 closid, u32 rmid, int cntr_id,
+			     enum resctrl_event_id eventid);
+
 extern unsigned int resctrl_rmid_realloc_threshold;
 extern unsigned int resctrl_rmid_realloc_limit;
=20

