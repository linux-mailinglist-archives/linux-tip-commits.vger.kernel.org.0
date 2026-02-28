Return-Path: <linux-tip-commits+bounces-8276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEUtBSzLomnz5QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:02:04 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE091C26C7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 12:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3F653139A70
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105E43C05C;
	Sat, 28 Feb 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="szWJj21Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RY0dkRM0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681B429823;
	Sat, 28 Feb 2026 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276208; cv=none; b=H0K+CbRsoDi/hlHXpFaIsCYJpaOiQtZIucAT6+MtkoszC9eXeZO2dZc+KLvWKR6UWp5zCLt0PnkyuTeYEblYqpDCx7B9nwCEAO+gSPguUrv4kedab8WQsU3Vw//h4fUlgP9QkLGWZxpnu6+mtr+M3pp0nnlTIlSxNM8Ae6ezv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276208; c=relaxed/simple;
	bh=dC9u29mxOCvW2TghjIue6vIn8/vG3Yu0PHt+nc3YvKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vql9vmBQG7xyDsJceXUSpdouVzSWv9iPQMOVwpjYSBpyQ2jFk7SfVGQVDm9zJ3kJeHNys6Y8YgBVFVF1PceqcekAsOIi6sg2FVSyqJBjNM4MsnonBNDUsF/zkHK8jOXgzJMDHSVcKqvOp3XIBglcBzxKs35rxXilyFWKFuGfrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=szWJj21Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RY0dkRM0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 10:56:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772276206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLKHZvMFsVr36rKJtNAz1SNmytOKpcU+ZmygA7kUlE8=;
	b=szWJj21Q07GzD+2B+vox+Xzn8sFlVzJr8M304ULfCfH2B2tQ1hC8thmH8B0zc94C/niO6a
	O1RVSVl0eTIy343iVm+79Ic3a1KyxGo75dXwGiTPexAMG2QvQihCk71xVtM4Lec+rZ31xm
	HV7LxeNwIJbmmdWNodRbJFnIvDzYxAr5DcfgsTSfjIzQOnxKnn7W2zI0+ThRs1IxFz6yUS
	/mA0j6Ej/9XAw/x1EJicQ0Km3yh1XL5jhr/IYXU7AstpgBl34xeiwfhPoizjxgKAoaWgtR
	zbrBMwX7egDtGMgcBINse1iO64O5aGt3ZsGMfHVYrA8Eja3yEX93qLPEs6H8LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772276206;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLKHZvMFsVr36rKJtNAz1SNmytOKpcU+ZmygA7kUlE8=;
	b=RY0dkRM0vxur4zadu3+rjoe/zgCaLOLy3VEQcRYb0oltu/WHmO3DAecIlSip6x9WLiEAgP
	WTeQjhCpj6iC0+AQ==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/amd/ibs: Limit ldlat->l3missonly dependency to Zen5
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260216042216.1440-3-ravi.bangoria@amd.com>
References: <20260216042216.1440-3-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177227620482.1647592.12460331747210509791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8276-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 8CE091C26C7
X-Rspamd-Action: no action

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     898138efc99096c3ee836fea439ba6da3cfafa4d
Gitweb:        https://git.kernel.org/tip/898138efc99096c3ee836fea439ba6da3cf=
afa4d
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 16 Feb 2026 04:22:13=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:22 +01:00

perf/amd/ibs: Limit ldlat->l3missonly dependency to Zen5

The ldlat dependency on l3missonly is specific to Zen 5; newer generations
are not affected. This quirk is documented as an erratum in the following
Revision Guide.

  Erratum: 1606 IBS (Instruction Based Sampling) OP Load Latency Filtering
           May Capture Unwanted Samples When L3Miss Filtering is Disabled

  Revision Guide for AMD Family 1Ah Models 00h-0Fh Processors,
  Pub. 58251 Rev. 1.30 July 2025
  https://bugzilla.kernel.org/attachment.cgi?id=3D309193

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://patch.msgid.link/20260216042216.1440-3-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 705ef43..e0b64cb 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -356,7 +356,10 @@ static int perf_ibs_init(struct perf_event *event)
 		ldlat >>=3D 7;
=20
 		config |=3D (ldlat - 1) << 59;
-		config |=3D IBS_OP_L3MISSONLY | IBS_OP_LDLAT_EN;
+
+		config |=3D IBS_OP_LDLAT_EN;
+		if (cpu_feature_enabled(X86_FEATURE_ZEN5))
+			config |=3D IBS_OP_L3MISSONLY;
 	}
=20
 	/*

