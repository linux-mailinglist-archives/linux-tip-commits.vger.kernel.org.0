Return-Path: <linux-tip-commits+bounces-8130-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LiqI2DteWkF1AEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8130-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 12:05:04 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C689FE8F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 12:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9283045C1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jan 2026 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63697299949;
	Wed, 28 Jan 2026 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gESLiaU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAQ3oZTU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D8257821;
	Wed, 28 Jan 2026 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769598127; cv=none; b=Mfqpdyqc+oxSzNwm1MCMZwgvK3C//E6DJgjijIAAf+bgTqMn22C/oBVURj1iHHj2j9z5Q1jaQe8ZmaC6GK/ySFOjGps6rUnOF3zWeewV6ilGWjeRgLOpuonJXOfIjZEzRaGf+SfBqqCt+ZaDKmEWmhsg36QWMHVMS6+yRpOgtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769598127; c=relaxed/simple;
	bh=s1X1Do9C9OXSSba1gSIxKNZz/xpZBQzuY0BjxKizJdc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hvOizcMiqbKt1GBYj4j/QVIBw4PvLmHsDxOh4wEGPVQurXtdzECaoDNYB5X8+Bdj1bVEUZxqv+6xjr7dxMmpa5AO9OxAgZoL/653eGVYzrgipAtl88bYab6bvEMU4meU7g2waFJHUn2j9HrgDuq6NUtXnmuw2usOEqydtEa6Js8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gESLiaU2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAQ3oZTU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Jan 2026 11:02:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769598123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=W9WcRBd0i6RuOQoclYMtXVVnJP/stsJD97QtJnojUsE=;
	b=gESLiaU2TVfluwH5QyT0JaIETKGhHpWIksPCWSbgH1imT0BVBMpqagYaH6cS54PHsWIBOi
	mcUGW+m2Jy12gjHdvS7DQl1FZXcWkpoNobee4DKX+UmuMy9WqETj8q+xNRtMyEmUZDbX8d
	cMmLqmNiIoIkEpq2S1eY3Y55M17HU7GoP2xTD3/ZRdeCNf6rl2MiJV10Vgi9Xqfi8AhBCJ
	hEZbUV72phu8vgRPDWhxzTBPw72Bh/NvUWTBWYzAE0SpXI1rY3moX4xan5evXQnFiCSfGP
	bBLZoc5nPyWcY+72ipatEIk3Yc+uub+SenBkjOEBkMEB+N8AidhjLyuQsgF49Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769598123;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=W9WcRBd0i6RuOQoclYMtXVVnJP/stsJD97QtJnojUsE=;
	b=sAQ3oZTUHBHIBpvjl1sNoxrlMnb3EGpjUoMd8yGbct5Y0tcThr3/0J7aEGBbG57JcAgsc3
	319JYqDCdtGE1hCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/platform] x86/hyperv: Fix smp_ops build failure on UP kernels
Cc: Mukesh Rathor <mrathor@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176959812223.510.4055929851272785854.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8130-lists,linux-tip-commits=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: E9C689FE8F
X-Rspamd-Action: no action

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     ac059ae422d7d05ed9d62970a30fa3b95870b967
Gitweb:        https://git.kernel.org/tip/ac059ae422d7d05ed9d62970a30fa3b9587=
0b967
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 Jan 2026 11:35:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Jan 2026 11:54:04 +01:00

x86/hyperv: Fix smp_ops build failure on UP kernels

CI testing found this build failure:

  arch/x86/hyperv/hv_crash.c:631:9: error: =E2=80=98smp_ops=E2=80=99 undeclar=
ed (first use in this function)

And I bisected it back to the initial commit that enabled this feature:

  77c860d2dbb72d1f3c6a2e882a07d19eca399db5 is the first bad commit
  commit 77c860d2dbb72d1f3c6a2e882a07d19eca399db5 (HEAD)
  Author: Mukesh Rathor <mrathor@linux.microsoft.com>
  Date:   Mon Oct 6 15:42:08 2025 -0700

  x86/hyperv: Enable build of hypervisor crashdump collection files

Hyperv should probably be limited to SMP kernels, as nobody
appears to be testing it on UP kernels.

Until then, fix the smp_ops assumption. Build tested only.

Fixes: 77c860d2dbb72 ("x86/hyperv: Enable build of hypervisor crashdump colle=
ction files")
Cc: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/hyperv/hv_crash.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index c0e2292..a78e4fe 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -628,7 +628,9 @@ void hv_root_crash_init(void)
 	if (rc)
 		goto err_out;
=20
+#ifdef CONFIG_SMP
 	smp_ops.crash_stop_other_cpus =3D hv_crash_stop_other_cpus;
+#endif
=20
 	crash_kexec_post_notifiers =3D true;
 	hv_crash_enabled =3D true;

