Return-Path: <linux-tip-commits+bounces-8119-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC9SCU7deGnbtgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8119-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 16:44:14 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5682E96F6F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 16:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D1F301DAE8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CF63033C2;
	Tue, 27 Jan 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sj9AmrYC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U6OTDuWB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF765302CBA;
	Tue, 27 Jan 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528392; cv=none; b=CzgJAw4t13F+KDjo+VqwxWYvDHivWSV+zjP9X3rYuvmV0+58KIMhaCBFCEGH3xOXtE4UbVK+Mo5gJgVEg/DCeKCxUGmLGTSJZmfz5G8Sa7SjoO6ViRFcU2umsYuSQzNyejFh+Ck54+6JuTeEhg/FArHBJiK8laY7y2gSp4TOz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528392; c=relaxed/simple;
	bh=MBKaA/0aiEBoYIfcFeMeA+WkYy2p2OHTdyNq7GIniTY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XYDY0ZifygGkbjgFo/tgkBatpUGtOhYnpwbpSUy4GCkGYLYKKuxjx1y39jJBqpXuYoHWNIcN7htzIUlpEFaZdBbyg09kuXbMlWrm/We9S8c+m61blGHBs0QajJUIS8O2t/cYjGXDttRYbkY86MDZfZPYiYlD7brGaM2EfAfItco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sj9AmrYC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U6OTDuWB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Jan 2026 15:39:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769528388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDfRUJrDOwLDE5mk8RhxmEWAQZQWhEjgdD2M9Bk4U/0=;
	b=Sj9AmrYCEusqIeOmLg6COWwePqwEs9TOBxq1Q3zY02ddKQurM+ckcqfvujOuo21Omx7Yyv
	ReCm1O1ADgKkXde7iRJ6hX5Zmhwy+1pctlaoklPJ0tL7sU5FT+IJwQjdQhrxaYXlNVpOxG
	9xKt8ATLSL176J0FFCvQwV0pb9Cpt7DRK7KJB6brsGSrRAbwkbpajPS6N8YFhyf+t43+dx
	mIiCoIElXUN72VuiJjZClfkcAl5UVNJQeKTHVg5DQIhZ6hetA39lZAXmDgXcGQlyULsz14
	QMMKSXpa79pA96zje8sQgFcbmqW5drCI13CzRu/R2fHAcaJKZQLCJkuyuCZHwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769528388;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDfRUJrDOwLDE5mk8RhxmEWAQZQWhEjgdD2M9Bk4U/0=;
	b=U6OTDuWBdPLMw5z3gaZCvnBkcmBc11CyI157BgwLeupTYCJG+Hrbf3Ek8wO7AeAFj3bZPv
	jYnROpp4CXp/buAA==
From: "tip-bot2 for Ioana Ciornei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] bus: simple-pm-bus: Probe the Layerscape SCFG node
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Thomas Gleixner <tglx@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260122134034.3274053-3-ioana.ciornei@nxp.com>
References: <20260122134034.3274053-3-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176952838438.510.3277372599660230777.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8119-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:replyto,nxp.com:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: 5682E96F6F
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ba5c657141ea29261e893c46faff29a101f4496a
Gitweb:        https://git.kernel.org/tip/ba5c657141ea29261e893c46faff29a101f=
4496a
Author:        Ioana Ciornei <ioana.ciornei@nxp.com>
AuthorDate:    Thu, 22 Jan 2026 15:40:34 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 27 Jan 2026 16:33:32 +01:00

bus: simple-pm-bus: Probe the Layerscape SCFG node

Make the simple-pm-bus driver probe the Layerscape SCFG dt nodes and
populate platform_device structures from its child dt nodes.

This is now needed because its child interrupt-controller - ls-extirq -
is being handled as a platform_device instead of being initialized
through the IRQCHIP_DECLARE infrastructure which impeded its parent IRQ
retrieval through the blamed commit.

Note that this does not set ONLY_BUS because that enables the
of_platform_populate() call. The extra power management operations which
are enabled by that are not required but harmless.

Fixes: 1b1f04d8271e ("of/irq: Ignore interrupt parent for nodes without inter=
rupts")
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260122134034.3274053-3-ioana.ciornei@nxp.com
---
 drivers/bus/simple-pm-bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index d8e029e..3f00d95 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -142,6 +142,12 @@ static const struct of_device_id simple_pm_bus_of_match[=
] =3D {
 	{ .compatible =3D "simple-mfd",	.data =3D ONLY_BUS },
 	{ .compatible =3D "isa",		.data =3D ONLY_BUS },
 	{ .compatible =3D "arm,amba-bus",	.data =3D ONLY_BUS },
+	{ .compatible =3D "fsl,ls1021a-scfg", },
+	{ .compatible =3D "fsl,ls1043a-scfg", },
+	{ .compatible =3D "fsl,ls1046a-scfg", },
+	{ .compatible =3D "fsl,ls1088a-isc", },
+	{ .compatible =3D "fsl,ls2080a-isc", },
+	{ .compatible =3D "fsl,lx2160a-isc", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);

