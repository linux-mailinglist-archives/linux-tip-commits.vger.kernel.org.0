Return-Path: <linux-tip-commits+bounces-8264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M7zMufJommy5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:56:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 281051C25B2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2380F3040002
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1C3428473;
	Sat, 28 Feb 2026 10:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVeGTRTB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8Z2ujp9P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7032423A70;
	Sat, 28 Feb 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276197; cv=none; b=V2GnogmDB+N/6gCGqOaGzPqJvRchFMHYOYASoSVW3SyrNij3gWCqb5C83pDO2HMQtP636Qdop0gP4hPwcTjfCCPiDBtOxWom0qLvIi4BDM0bMq+lEUfMhjJtNLuBcYLl/dXeUFw0aIb+5ThbhjNcRLR1xleaG9S7gWZWx9yFa3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276197; c=relaxed/simple;
	bh=72auamQwLJ0ukYMUfuZSGyfU7UZXYbugpp+3ACcT3gU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SFeRLenRmBcR5czT3HQW3J/5DFG5w2XtmqUFGL2sf1uNP9g9pr3tOO/Fe/0JbRq4AC8feZcGnJBIcQNFgF71KmRwZf01VKNpZ6aZ6yGjiaI6KmSWRmeZxHPV/cMMBLotUxZdcMgMywJwunneRuYR8NH2BZGh8Ty6eceMAaF4p+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVeGTRTB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8Z2ujp9P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgYTNXikOkP2AF1urGeDXNKVWCkC/Tiz8RSeG+/rJfc=;
	b=GVeGTRTBReLj2jqeKGc+t6XGH7A61LOVBSI8kOCx6e8Dyhasoz4bJeEP0pUjLdLibnMdgI
	QBI90YI11pWpNyLgSV5XEy+wdvBc5nKcgyCgJ6qxdjOn3YMOhRsR63GReWtQbBCFnSKVEz
	ha1jAysiKqyjN+r5jbZQKK/aksea14G4Z3DIl+fLx8E2kiTKDr+fBQv4Ow+OT5lIrwYvBj
	6JegFxtBiFiSk1jK93F1SLNE4HwtYg2Zb6vJZvbBt/CO9L5A0LOpdh7BuqoR1nkKwUPwUi
	4IPFIzu98t7B0HcZ326kjBFFpgv4LTI1Z/ha9gJb3te+quTzFHzUb2giCehihA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276194;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgYTNXikOkP2AF1urGeDXNKVWCkC/Tiz8RSeG+/rJfc=;
	b=8Z2ujp9PIsfIMfUdkvBnjhNoiVo5H6SW0RkHfD5wnq5+Bu45KmnWMuLKF0JhGfYVWkjyr7
	BRL9noxtbgAg1KBQ==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Advertise remote socket capability
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042530.1546-8-ravi.bangoria@amd.com>
References: <20260216042530.1546-8-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227619326.1647592.17766530365208697502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8264-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 281051C25B2
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     65772b382a9865a5480ee527f3fa6e606fafc0e7
Gitweb:        https://git.kernel.org/tip/65772b382a9865a5480ee527f3fa6e606fa=
fc0e7
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:25:30=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:25 +01:00

perf/amd/ibs: Advertise remote socket capability

IBS OP on future hardware can indicate data source from remote socket
as well. Advertise this capability to userspace so that userspace tools
can decode IBS data accordingly.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260216042530.1546-8-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c      | 19 +++++++++++++++++++
 arch/x86/include/asm/amd/ibs.h |  3 ++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 0a8313e..eeb607b 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -730,6 +730,7 @@ PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_format, "co=
nfig1:0-10");
 PMU_EVENT_ATTR_STRING(fetchlat, ibs_fetch_lat_cap, "1");
 PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_format, "config1:12");
 PMU_EVENT_ATTR_STRING(strmst, ibs_op_strmst_cap, "1");
+PMU_EVENT_ATTR_STRING(rmtsocket, ibs_op_rmtsocket_cap, "1");
=20
 static umode_t
 zen4_ibs_extensions_is_visible(struct kobject *kobj, struct attribute *attr,=
 int i)
@@ -750,6 +751,12 @@ ibs_op_strmst_is_visible(struct kobject *kobj, struct at=
tribute *attr, int i)
 }
=20
 static umode_t
+ibs_op_rmtsocket_is_visible(struct kobject *kobj, struct attribute *attr, in=
t i)
+{
+	return ibs_caps & IBS_CAPS_STRMST_RMTSOCKET ? attr->mode : 0;
+}
+
+static umode_t
 ibs_op_ldlat_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 {
 	return ibs_caps & IBS_CAPS_OPLDLAT ? attr->mode : 0;
@@ -802,6 +809,11 @@ static struct attribute *ibs_op_strmst_cap_attrs[] =3D {
 	NULL,
 };
=20
+static struct attribute *ibs_op_rmtsocket_cap_attrs[] =3D {
+	&ibs_op_rmtsocket_cap.attr.attr,
+	NULL,
+};
+
 static struct attribute_group group_fetch_formats =3D {
 	.name =3D "format",
 	.attrs =3D fetch_attrs,
@@ -849,6 +861,12 @@ static struct attribute_group group_ibs_op_strmst_cap =
=3D {
 	.is_visible =3D ibs_op_strmst_is_visible,
 };
=20
+static struct attribute_group group_ibs_op_rmtsocket_cap =3D {
+	.name =3D "caps",
+	.attrs =3D ibs_op_rmtsocket_cap_attrs,
+	.is_visible =3D ibs_op_rmtsocket_is_visible,
+};
+
 static const struct attribute_group *fetch_attr_groups[] =3D {
 	&group_fetch_formats,
 	&empty_caps_group,
@@ -938,6 +956,7 @@ static const struct attribute_group *op_attr_update[] =3D=
 {
 	&group_ibs_op_dtlb_pgsize_cap,
 	&group_ibs_op_strmst_cap,
 	&group_ibs_op_strmst_format,
+	&group_ibs_op_rmtsocket_cap,
 	NULL,
 };
=20
diff --git a/arch/x86/include/asm/amd/ibs.h b/arch/x86/include/asm/amd/ibs.h
index 020916e..4eac36c 100644
--- a/arch/x86/include/asm/amd/ibs.h
+++ b/arch/x86/include/asm/amd/ibs.h
@@ -100,7 +100,8 @@ union ibs_op_data2 {
 			cache_hit_st:1,	/* 5: cache hit state */
 			data_src_hi:2,	/* 6-7: data source high */
 			strm_st:1,	/* 8: streaming store */
-			reserved1:55;	/* 9-63: reserved */
+			rmt_socket:1,   /* 9: remote socket */
+			reserved1:54;   /* 10-63: reserved */
 	};
 };
=20

