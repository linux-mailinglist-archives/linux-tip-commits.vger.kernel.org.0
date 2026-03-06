Return-Path: <linux-tip-commits+bounces-8377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HHvCCapqmmzVAEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 11:15:02 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9927821E885
	for <lists+linux-tip-commits@lfdr.de>; Fri, 06 Mar 2026 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A932E3019FF9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2026 10:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2371372B5A;
	Fri,  6 Mar 2026 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G1jL1OTF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULBtcDxW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5285F371CED;
	Fri,  6 Mar 2026 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792066; cv=none; b=BO/RlQmsVjcRi2zOVKEKWhYEtWLe4HD1tUxMtcAMsYhdvyE4p7wBAwAqLKKWCdgvaH+1vuqAGvPFkGMhfR2lh0YqS09ydP+U1M1/y5LFebDGWYZJCRodPFtv4KqvIP5pOUZFCp6O1yL+Zran720awiG3p3WTtNWbs8tNN1uVctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792066; c=relaxed/simple;
	bh=w4/Yfocgk79Y23tHJ5U8M90OVy/NakHVhfW6vzdICHY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ebgO5baH8CELIwfMyPTZ4dYZgLx0udSFuS22FJUhFivoNCecSpPrOEcqSgXwrqONEAdSBQKb2r80NcntUZHvaiQVnW2+w3VfZVjujdGSkFgz7C005TM11F9DlK+AlGvhRFRPdwGaj+erJNsB6y0mW/WhDxGD2Yb5Q2s+ijyWvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G1jL1OTF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ULBtcDxW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Mar 2026 10:14:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772792062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KB58ynwbL3aWT7o6zYSSCp9LhluG2p3D65LNdvM52I=;
	b=G1jL1OTFKBqIblzKL5VKf2Wqfoo/zkAlqCACm9gfKUu6zOMx4aDZy/FlWDNvZmNcXupCJk
	v3m632Vn0qD0SAU5W/eW/k4oJCAV3vouXHtyQSnYR0JpTkCdy9xpNJP7r+rLD5nUk7TKfs
	GP+0UzOgLM9QtOtI7uwYRGJs3h4eoOvUNubIi5FnuiI8HRynEyD1Zn1iC07giT9kiqOcia
	5Mt4ZFwG7oAByDonq2HuEtir3VCH/tZxlu4EWBBSlcGb07Nsoc1O4JErzyhLlUtvk8Kl3E
	F9a0jojHjehBsjd7JQeHl9RtyhoBANUZg42FsClhq4c26Fc20+ItYn59MqVXGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772792062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6KB58ynwbL3aWT7o6zYSSCp9LhluG2p3D65LNdvM52I=;
	b=ULBtcDxWVetM2jGk9ZffA86bxDq/S3TssksmQccJYOJCjRK19+r0bUsrtiBIxGhCWOfx9I
	H5eViimsKQMt0HAQ==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry/vdso32: Work around libgcc unwinder bug
Cc: Xi Ruoyao <xry111@xry111.site>, "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260227010308.310342-1-hpa@zytor.com>
References: <20260227010308.310342-1-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177279206154.1647592.13831880002587716265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9927821E885
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
	TAGGED_FROM(0.00)[bounces-8377-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b5ef09a77d0b5213268300eedd8a7d28b4e92d47
Gitweb:        https://git.kernel.org/tip/b5ef09a77d0b5213268300eedd8a7d28b4e=
92d47
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Thu, 26 Feb 2026 17:03:07 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Mar 2026 17:06:08 +01:00

x86/entry/vdso32: Work around libgcc unwinder bug

The unwinder code in libgcc has a long standing bug which causes it to
fail to pick up the signal frame CFI flag. This is a generic bug
across all platforms.

It affects the __kernel_sigreturn and __kernel_rt_sigreturn vdso entry
points on i386. The x86-64 kernel doesn't provide a sigreturn stub,
and so there is no kernel-provided code that is affected on x86-64.

libgcc does have a legacy fallback path which happens to work as long
as the bytes immediately before each of the sigreturn functions fall
outside any function. This patch adds a nop before the ALIGN to each
of the sigreturn stubs to ensure that this is, indeed, the case.

The rest of the patch is just a comment which documents the invariants
that need to be maintained for this legacy path to work correctly.

This is a manifest bug: in the current vdso, __kernel_vsyscall is a
multiple of 16 bytes long and thus __kernel_sigreturn does not have
any padding in front of it.

Closes: https://lore.kernel.org/lkml/f3412cc3e8f66d1853cc9d572c0f2fab076872b1=
.camel@xry111.site
Fixes: 884961618ee5 ("x86/entry/vdso32: Remove open-coded DWARF in sigreturn.=
S")
Reported-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D124050
Link: https://patch.msgid.link/20260227010308.310342-1-hpa@zytor.com
---
 arch/x86/entry/vdso/vdso32/sigreturn.S | 30 +++++++++++++++++++++++++-
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso32/sigreturn.S b/arch/x86/entry/vdso/vds=
o32/sigreturn.S
index b433353..b33fcc5 100644
--- a/arch/x86/entry/vdso/vdso32/sigreturn.S
+++ b/arch/x86/entry/vdso/vdso32/sigreturn.S
@@ -35,9 +35,38 @@
 #endif
 .endm
=20
+/*
+ * WARNING:
+ *
+ * A bug in the libgcc unwinder as of at least gcc 15.2 (2026) means that
+ * the unwinder fails to recognize the signal frame flag.
+ *
+ * There is a hacky legacy fallback path in libgcc which ends up
+ * getting invoked instead. It happens to work as long as BOTH of the
+ * following conditions are true:
+ *
+ * 1. There is at least one byte before the each of the sigreturn
+ *    functions which falls outside any function. This is enforced by
+ *    an explicit nop instruction before the ALIGN.
+ * 2. The code sequences between the entry point up to and including
+ *    the int $0x80 below need to match EXACTLY. Do not change them
+ *    in any way. The exact byte sequences are:
+ *
+ *    __kernel_sigreturn:
+ *        0:   58                      pop    %eax
+ *        1:   b8 77 00 00 00          mov    $0x77,%eax
+ *        6:   cd 80                   int    $0x80
+ *
+ *    __kernel_rt_sigreturn:
+ *        0:   b8 ad 00 00 00          mov    $0xad,%eax
+ *        5:   cd 80                   int    $0x80
+ *
+ * For details, see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D124050
+ */
 	.text
 	.globl __kernel_sigreturn
 	.type __kernel_sigreturn,@function
+	nop			/* libgcc hack: see comment above */
 	ALIGN
 __kernel_sigreturn:
 	STARTPROC_SIGNAL_FRAME IA32_SIGFRAME_sigcontext
@@ -52,6 +81,7 @@ SYM_INNER_LABEL(vdso32_sigreturn_landing_pad, SYM_L_GLOBAL)
=20
 	.globl __kernel_rt_sigreturn
 	.type __kernel_rt_sigreturn,@function
+	nop			/* libgcc hack: see comment above */
 	ALIGN
 __kernel_rt_sigreturn:
 	STARTPROC_SIGNAL_FRAME IA32_RT_SIGFRAME_sigcontext

