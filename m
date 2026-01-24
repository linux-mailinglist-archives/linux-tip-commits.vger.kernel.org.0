Return-Path: <linux-tip-commits+bounces-8112-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJlNB6GPdGmw7AAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8112-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 24 Jan 2026 10:23:45 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 549CD7D13C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 24 Jan 2026 10:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42D1B3011A7C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 24 Jan 2026 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE8E27055D;
	Sat, 24 Jan 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x+6OLmx7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OQ6Q+gQv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C01273D9A;
	Sat, 24 Jan 2026 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769246622; cv=none; b=kRH09njyDaM4lfv2g77B7yPgPnkUB4D9KyHEgspukqBoxgTFmbqrnDcxkONcdOM1KtIRNrR/jfy5ZBbTp172o+xpIGxK04SXEfqCsNxcPt+eOf4XPxiDoWye+6G1jUUyy4lz8u5wmjXIMZpq6ghpuzdh33i4+WFybeagYXfwW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769246622; c=relaxed/simple;
	bh=b2cf1NyMZaS0PTb2uIGnF5FseT3NlAJdDLIwcw9+4FA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fhSwYOtZMh10GJ9/hl8+I1b/4xtlYyJ+4X4IsXMVxL2YBrjRRimj9FcTg0RggTSxYIM0S2BWbuTebHufs10d3MEQ8zZ4vjIcV6mqnps+auoeJc5XOr+Hum+A+BIKATwZHyOKsEuoEMoLslp4BRMwGJ2VKtYvtNaDQtuiIXHxaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x+6OLmx7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OQ6Q+gQv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 24 Jan 2026 09:23:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769246613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK4GdT+/ZVk0bZ+/QPI41gm/04IqQR5/6K9wiuLIFoc=;
	b=x+6OLmx75fqG+J8MXA59R63t17I4AYSIZLxpfU0Wt4+M4V/8LGRPfwMQXjvQ5zkiIouN4U
	GUwufOIPBKyDv48B/90TLufGhmLbVsYI9nlN907ayoMI6b1zbuVsErtF93r9ph3gCvRMwB
	y3GMp1p780IQx0jZiH7K5/usotFJB0kQGrYtGwL7wxSsDI8BLnDRb7ad2dXtXKZTSnzVp9
	MoG1Ogzfvxg3XRx1A9F8UGNtVNqUfu366NREgBFG34YusiyuNYFz+SjC7K2FLtBVMwiWdw
	YfLgektjv0cAKiq5XHseDXpA5dczRm0jTP1VyFx8X/CDvotBLHV2r2859+f7RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769246613;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NK4GdT+/ZVk0bZ+/QPI41gm/04IqQR5/6K9wiuLIFoc=;
	b=OQ6Q+gQvbRngW6rfRt+sxa3ozAMPRpnnFjDYfXlthh17WZgt6P6g/vvhW1YlO6FbdrzGxy
	43VyDJw01lWayHAw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/entry] x86/entry/vdso32: Omit '.cfi_offset eflags' for LLVM < 16
Cc: Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20260123-x86-vdso32-wa-llvm-15-cfi-offset-eflags-v?=
 =?utf-8?q?1-1-0f412e3516a4=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C20260123-x86-vdso32-wa-llvm-15-cfi-offset-eflags-v1?=
 =?utf-8?q?-1-0f412e3516a4=40kernel=2Eorg=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176924660698.510.2856740193141790742.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8112-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim]
X-Rspamd-Queue-Id: 549CD7D13C
X-Rspamd-Action: no action

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     3e30278e0c71808e156cac8da5895d636ce819d5
Gitweb:        https://git.kernel.org/tip/3e30278e0c71808e156cac8da5895d636ce=
819d5
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 23 Jan 2026 16:20:28 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 24 Jan 2026 10:18:28 +01:00

x86/entry/vdso32: Omit '.cfi_offset eflags' for LLVM < 16

After commit:

  884961618ee5 ("x86/entry/vdso32: Remove open-coded DWARF in sigreturn.S")

building arch/x86/entry/vdso/vdso32/sigreturn.S with LLVM 15 fails with:

  <instantiation>:18:20: error: invalid register name
   .cfi_offset eflags, 64
                     ^
  arch/x86/entry/vdso/vdso32/sigreturn.S:33:2: note: while in macro instantia=
tion
   STARTPROC_SIGNAL_FRAME 8
   ^

Support for eflags as an argument to .cfi_offset was added in the LLVM
16 development cycle:

    https://github.com/llvm/llvm-project/commit/67bd3c58c0c7389e39c5a2f4d3b1a=
30459ccf5b7 [1]

Only add this .cfi_offset directive if it is supported by the assembler
to clear up the error.

[ mingo: Tidied up the changelog and the comment a bit ]

Fixes: 884961618ee5 ("x86/entry/vdso32: Remove open-coded DWARF in sigreturn.=
S")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://patch.msgid.link/20260123-x86-vdso32-wa-llvm-15-cfi-offset-efla=
gs-v1-1-0f412e3516a4@kernel.org
---
 arch/x86/entry/vdso/vdso32/sigreturn.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso32/sigreturn.S b/arch/x86/entry/vdso/vds=
o32/sigreturn.S
index 25b0ac4..b433353 100644
--- a/arch/x86/entry/vdso/vdso32/sigreturn.S
+++ b/arch/x86/entry/vdso/vdso32/sigreturn.S
@@ -22,7 +22,17 @@
 	CFI_OFFSET	cs,     IA32_SIGCONTEXT_cs
 	CFI_OFFSET	ss,     IA32_SIGCONTEXT_ss
 	CFI_OFFSET	ds,     IA32_SIGCONTEXT_ds
+/*
+ * .cfi_offset eflags requires LLVM 16 or newer:
+ *
+ *   https://github.com/llvm/llvm-project/commit/67bd3c58c0c7389e39c5a2f4d3b=
1a30459ccf5b7
+ *
+ * Check for 16.0.1 to ensure the support is present, as 16.0.0 may be a
+ * prerelease version.
+ */
+#if defined(CONFIG_AS_IS_GNU) || (defined(CONFIG_AS_IS_LLVM) && CONFIG_AS_VE=
RSION >=3D 160001)
 	CFI_OFFSET	eflags, IA32_SIGCONTEXT_flags
+#endif
 .endm
=20
 	.text

