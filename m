Return-Path: <linux-tip-commits+bounces-8107-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPfQEz/7cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8107-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:26:07 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0332653A1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 775384EBC41
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4925C40FDB0;
	Thu, 22 Jan 2026 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixk9yIn3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ao6as9X2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80923F23BF;
	Thu, 22 Jan 2026 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076975; cv=none; b=gl0oLXcZLlnJCQG8eFKycOqMxlV195bFixa0u2SKnj5dOpeFoDIzxM67AqIZCoMskyRKGFilRrayWD8qnomqV1kTVF3PEIt1+of8XyZFVBIO4E1JWbeNkHp3HRQgiX3Sg5tJjuYo0hZ9h+U1goZLy+dOQ5cV17Clt/FgYmfFFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076975; c=relaxed/simple;
	bh=zrOqrgsgv9XCxHLlN2u+0laew+OCiqhGnyOFOBn4JSQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SoukFEUBY3HRKTFQcoaeX0zAYtYSdl3cIAOWXgOgCV1lqzgdVrh3RoXjJU0O9xSYXbqNYvnts+dO1XT6sM9JJ6s9mk8w/Gr2e5ByvMklV06XJ0EfzEAXW+/xs7NxcDq+oNZdp560J/tdJCJFa5uaDdJXZHB9IM4miLGwhWjWzjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixk9yIn3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ao6as9X2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maI5shvy3xWgz4AfbtKHYq8t4ROIacHgRMdEfKTfgGo=;
	b=ixk9yIn3TykD2chxTZCzU7ZN4UzIyOToh5jh6CTj8vrJAjL+5e7YgsU1MRx3dHj8n9omCb
	8VTlvPLpI53P9TppZECfo4H8RtOyhGwpXeBJWdw1maw2TgCBOw90ODn8f6/xlH82WRSMH5
	tCrLlZYEoQ5vyWTaVKCsL37f+AYwpOVLPJ3buXSy4ij4uPzfn6gnwS+HsPcx4MaSfYqbE3
	mXTl6Bh3bjW3UR/Iw+Ci5daRwZGvzisWX6MzWpQTAY3pUkM92p2qMeyc6R0iLElKkMr/Mc
	g72LE53retd0SNnYqgGpqbofKHbsEMbLFX0155aZua33wHPU5M3eHNJaA3m1Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076969;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maI5shvy3xWgz4AfbtKHYq8t4ROIacHgRMdEfKTfgGo=;
	b=Ao6as9X2JxhtVMtHsTNwyi/UsTZIEUCpxQVH2ul6iL3aavc2/RkSik7vx/AFCX22qRgKmu
	A8XMti3oudiAZ2Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] rseq: Provide static branch for time slice extensions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155708.733429292@linutronix.de>
References: <20251215155708.733429292@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907696786.510.15218002182439356599.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,infradead.org:email,msgid.link:url,vger.kernel.org:replyto];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8107-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: F0332653A1
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f8380f976804533df4c6c3d3a0b2cd03c2d262bc
Gitweb:        https://git.kernel.org/tip/f8380f976804533df4c6c3d3a0b2cd03c2d=
262bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:16 +01:00

rseq: Provide static branch for time slice extensions

Guard the time slice extension functionality with a static key, which can
be disabled on the kernel command line.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251215155708.733429292@linutronix.de
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++-
 include/linux/rseq_entry.h                      | 11 ++++++++++-
 kernel/rseq.c                                   | 17 ++++++++++++++++-
 3 files changed, 33 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index a8d0afd..f2348bc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6600,6 +6600,11 @@ Kernel parameters
=20
 	rootflags=3D	[KNL] Set root filesystem mount option string
=20
+	rseq_slice_ext=3D [KNL] RSEQ based time slice extension
+			Format: boolean
+			Control enablement of RSEQ based time slice extension.
+			Default is 'on'.
+
 	initramfs_options=3D [KNL]
                         Specify mount options for for the initramfs mount.
=20
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index a36b472..d0ec471 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -75,6 +75,17 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE,=
 rseq_debug_enabled);
 #define rseq_inline __always_inline
 #endif
=20
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+DECLARE_STATIC_KEY_TRUE(rseq_slice_extension_key);
+
+static __always_inline bool rseq_slice_extension_enabled(void)
+{
+	return static_branch_likely(&rseq_slice_extension_key);
+}
+#else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline bool rseq_slice_extension_enabled(void) { return false; }
+#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
+
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, =
unsigned long csaddr);
 bool rseq_debug_validate_ids(struct task_struct *t);
=20
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 07c324d..bf75268 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -483,3 +483,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, r=
seq_len, int, flags, u32
 efault:
 	return -EFAULT;
 }
+
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
+
+static int __init rseq_slice_cmdline(char *str)
+{
+	bool on;
+
+	if (kstrtobool(str, &on))
+		return 0;
+
+	if (!on)
+		static_branch_disable(&rseq_slice_extension_key);
+	return 1;
+}
+__setup("rseq_slice_ext=3D", rseq_slice_cmdline);
+#endif /* CONFIG_RSEQ_SLICE_EXTENSION */

