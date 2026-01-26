Return-Path: <linux-tip-commits+bounces-8118-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDWDE2jdd2ngmAEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8118-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 22:32:24 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D0E8DA28
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 22:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD67B3007AC2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 21:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A292BE7A7;
	Mon, 26 Jan 2026 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQsITr+y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQExlJzU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4323E35F;
	Mon, 26 Jan 2026 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463131; cv=none; b=NXPbfyCevecXV7d75emVbA1M3qR9ySvZ+kSw9YooLL1EY4ZJFKe2a6ex9STXhXTIIx2ggOS11vBTj8p6SnEEdDod6js8l+N2ESDMPmMQc8vzWYnLAbACieQEK2HMRl4zwF0+FOmBBWd/6uuCviVm5IfBc1u11rHivp3bKDwIFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463131; c=relaxed/simple;
	bh=HIlNpG8bphkxNBdht1t0APaQGAQysmLvV2qrXDpiIy8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HsRZwV6FEpGFVoXsdNpVcSUkIsEDe4vr3O/pblFz02oXm80AmNMSSMphKSU9YN4LgYM0Zm30dthcxX4LtOihH592OtU5cAgu8CIAK2wJFL3BMq+iWiwHgGN129T2BqjOimiqPpfA+4dNgJbz4s+e6yq5720cIiY1lapByGCiV1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQsITr+y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQExlJzU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Jan 2026 21:32:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769463128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiGBhy3hA7uqKSqLCTDHXbjFZqGisZ0n6up0bjvWMAA=;
	b=dQsITr+yIN/bWHmuL5WDJC823PqiwP2n26z35uMITiDezutjAlofWvCPnlRcdfvJmS9GWc
	ELMU6OeBs1ZpdeSqwdE4+QoeXnNY3VIKvwo+3uaEQMt9ojmD2eTaof7eyL7biWFS6/6/Hj
	MR/L4cdnvzZJznPAaDnCKK6rhwLgHLckNELqMaNZfvGW45amIRqS3o3Dyiw7TjgR8hPYwN
	/KN2x2zr/4s0A+x5rPyjWPoFdyTmlWpMQisaupX+iOi2gD5up5u/Q/ljMiPLlwzeHKT9qH
	lGEarN03re43k82mD4IFOyMM6aGbyMpU/xI7FM1+URJwv7iyBOnehXzGoXE6wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769463128;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xiGBhy3hA7uqKSqLCTDHXbjFZqGisZ0n6up0bjvWMAA=;
	b=kQExlJzUcfSe0igJmJiUl30AJDaBMwXEocDFMYhVR6xIg0KpUfBU71ZnuJhPqTb7se/+LY
	FBSWwoIDNKqIdBDg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Force inlining of
 __cvdso_clock_getres_common()
Cc: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20260123-vdso-clock_getres-inline-v1-1-4d6203b90cd3@linutronix.de>
References:
 <20260123-vdso-clock_getres-inline-v1-1-4d6203b90cd3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176946312622.510.10415796327436735908.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8118-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,linutronix.de:email,linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: 78D0E8DA28
X-Rspamd-Action: no action

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     546e9289c74f606423ef72075b34cc38eda3bb49
Gitweb:        https://git.kernel.org/tip/546e9289c74f606423ef72075b34cc38eda=
3bb49
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Fri, 23 Jan 2026 08:35:41 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 26 Jan 2026 22:27:07 +01:00

vdso/gettimeofday: Force inlining of __cvdso_clock_getres_common()

With CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, GCC may decide not to inline
__cvdso_clock_getres_common(). This introduces spurious internal
function calls in the vDSO fastpath.

Furthermore, with automatic stack variable initialization
(CONFIG_INIT_STACK_ALL_ZERO or CONFIG_INIT_STACK_ALL_PATTERN) GCC can emit
a call to memset() which is not valid in the vDSO.

Mark __cvdso_clock_getres_common() as __always_inline to avoid both issues.

Paradoxically the inlining even reduces the size of the code:

$ ./scripts/bloat-o-meter arch/powerpc/kernel/vdso/vgettimeofday-32.o.before =
arch/powerpc/kernel/vdso/vgettimeofday-32.o.after
add/remove: 0/1 grow/shrink: 1/1 up/down: 52/-148 (-96)
Function                                     old     new   delta
__c_kernel_clock_getres_time64                92     144     +52
__c_kernel_clock_getres                      136     132      -4
__cvdso_clock_getres_common                  144       -    -144
Total: Before=3D2788, After=3D2692, chg -3.44%

With CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy the functions are always inlined
and therefore the behaviour stays the same.

See also the equivalent change for clock_gettime() in commit b91c8c42ffdd
("lib/vdso: Force inlining of __cvdso_clock_gettime_common()").

Fixes: 21bbfd74044f ("x86/vdso: Provide clock_getres_time64() for x86-32")
Fixes: 1149dcdfc9ef ("ARM: VDSO: Provide clock_getres_time64()")
Fixes: f10c2e72b5de ("arm64: vdso32: Provide clock_getres_time64()")
Fixes: bec06cd6a140 ("MIPS: vdso: Provide getres_time64() for 32-bit ABIs")
Fixes: 759a1f97373f ("powerpc/vdso: Provide clock_getres_time64()")
Reported-by: Sverdlin, Alexander <alexander.sverdlin@siemens.com>
Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://lore.kernel.org/lkml/230c749f-ebd6-4829-93ee-601d88000a45@kerne=
l.org/
Link: https://patch.msgid.link/20260123-vdso-clock_getres-inline-v1-1-4d6203b=
90cd3@linutronix.de
Closes: https://lore.kernel.org/lkml/f45316f65a46da638b3c6aa69effd8980e6677b9=
.camel@siemens.com/
---
 lib/vdso/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 95df015..4399e14 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -421,7 +421,7 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(__=
kernel_old_time_t *time
 #endif /* VDSO_HAS_TIME */
=20
 #ifdef VDSO_HAS_CLOCK_GETRES
-static __maybe_unused
+static __always_inline
 bool __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t =
clock,
 				 struct __kernel_timespec *res)
 {

