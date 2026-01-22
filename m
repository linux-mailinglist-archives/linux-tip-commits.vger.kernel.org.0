Return-Path: <linux-tip-commits+bounces-8105-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGtUMVX7cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8105-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:26:29 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F53653C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6498C666683
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4440B6D2;
	Thu, 22 Jan 2026 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oXXNJ8Yv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVx1SHeI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E63F0752;
	Thu, 22 Jan 2026 10:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076973; cv=none; b=Nv6RDsrPr5ofZ+MO/02nYf5mr/oG9+2o66yYcdEhTig83SSmaO6fw2EzYxJIwmhjVuPwWJ9V41D1xGBVShN735Qz5DrZfZLtu1KbgKOpLFk36e5LPsYGDTCv/q+mlMeJvp+we2EdFGpyXGQmTIrMFj1JEe9kEVlWuPCK37Nn+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076973; c=relaxed/simple;
	bh=MHNoTpjbIY/rWWgre39CTH2bBhmn5WJ/FDFlPRONLqg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fm7eA25Ewqjmqfs/hNyC3c2NwTiLRnvvmn3RGCaRotwQnn0/DxYY1+CySdctf4gOv1gMwKISD9bRw4tuQYPZ9XTF3lB7RbXvrSLKADCLjjAwQeqLU+VjaL7cdVwR6lqvVK2GDhlR2Ei9c5kEmGmETXWEG/T7FA5jMvdN97DaVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oXXNJ8Yv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVx1SHeI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQeHSq8IYmv1LqyR7WA33Pr7zShDu8A+QBvoocdKAu8=;
	b=oXXNJ8YvnRkX3VvqeNfAJwy+7bUD11xCpORZmgeSfPiQse+X6q1hog4PTex4AQys/e1wiR
	IFqrwDVndJKRBjEExvJ0+9qRTbzARND0DOdHWS8083IPVxB05Z/0bIw1X2JYdUjMAwq7JI
	LlwqtGRgRTLGIVUhAln1QUnV3XUHUoX93bbuvXGwk7QMFEER3mRf6qVAH8EDp7jB8CHW4M
	zSkf2KVniYiOlr4ODyPe/sngDXF0wpcOOe1Lgxvq6rUeSPN7nBu0WMd+TgS/Mi0I/BRocn
	JpbgNpvJXFcxxrCV7rijlS5EbLhvpffGsDTLQulMx4ko0wuZrfWnc0yp3bJylA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076966;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQeHSq8IYmv1LqyR7WA33Pr7zShDu8A+QBvoocdKAu8=;
	b=FVx1SHeI9XZMB/4LsuCbtPYPb3LRVDNc1o/mK2cLs5BHclpnkRiwKBAu14FuSz2wKri6Vg
	TIjpJaah1xtzewCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Add prctl() to enable time slice extensions
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155708.858717691@linutronix.de>
References: <20251215155708.858717691@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907696556.510.10397690070317769452.tip-bot2@tip-bot2>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linutronix.de:dkim,msgid.link:url,vger.kernel.org:replyto,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,infradead.org:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8105-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: B6F53653C0
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     28621ec2d46c6adf7d33a6facbd83e2fa566bd34
Gitweb:        https://git.kernel.org/tip/28621ec2d46c6adf7d33a6facbd83e2fa56=
6bd34
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:17 +01:00

rseq: Add prctl() to enable time slice extensions

Implement a prctl() so that tasks can enable the time slice extension
mechanism. This fails, when time slice extensions are disabled at compile
time or on the kernel command line and when no rseq pointer is registered
in the kernel.

That allows to implement a single trivial check in the exit to user mode
hotpath, to decide whether the whole mechanism needs to be invoked.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251215155708.858717691@linutronix.de
---
 include/linux/rseq.h       |  9 ++++++-
 include/uapi/linux/prctl.h | 10 +++++++-
 kernel/rseq.c              | 52 +++++++++++++++++++++++++++++++++++++-
 kernel/sys.c               |  6 ++++-
 4 files changed, 77 insertions(+)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 2266f4d..3c194a0 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -163,4 +163,13 @@ void rseq_syscall(struct pt_regs *regs);
 static inline void rseq_syscall(struct pt_regs *regs) { }
 #endif /* !CONFIG_DEBUG_RSEQ */
=20
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
+#else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned lo=
ng arg3)
+{
+	return -ENOTSUPP;
+}
+#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
+
 #endif /* _LINUX_RSEQ_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 51c4e8c..79944b7 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -386,4 +386,14 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
=20
+/* RSEQ time slice extensions */
+#define PR_RSEQ_SLICE_EXTENSION			79
+# define PR_RSEQ_SLICE_EXTENSION_GET		1
+# define PR_RSEQ_SLICE_EXTENSION_SET		2
+/*
+ * Bits for RSEQ_SLICE_EXTENSION_GET/SET
+ * PR_RSEQ_SLICE_EXT_ENABLE:	Enable
+ */
+# define PR_RSEQ_SLICE_EXT_ENABLE		0x01
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 415d75b..09848bb 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -71,6 +71,7 @@
 #define RSEQ_BUILD_SLOW_PATH
=20
 #include <linux/debugfs.h>
+#include <linux/prctl.h>
 #include <linux/ratelimit.h>
 #include <linux/rseq_entry.h>
 #include <linux/sched.h>
@@ -501,6 +502,57 @@ efault:
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
 DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
=20
+int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
+{
+	switch (arg2) {
+	case PR_RSEQ_SLICE_EXTENSION_GET:
+		if (arg3)
+			return -EINVAL;
+		return current->rseq.slice.state.enabled ? PR_RSEQ_SLICE_EXT_ENABLE : 0;
+
+	case PR_RSEQ_SLICE_EXTENSION_SET: {
+		u32 rflags, valid =3D RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+		bool enable =3D !!(arg3 & PR_RSEQ_SLICE_EXT_ENABLE);
+
+		if (arg3 & ~PR_RSEQ_SLICE_EXT_ENABLE)
+			return -EINVAL;
+		if (!rseq_slice_extension_enabled())
+			return -ENOTSUPP;
+		if (!current->rseq.usrptr)
+			return -ENXIO;
+
+		/* No change? */
+		if (enable =3D=3D !!current->rseq.slice.state.enabled)
+			return 0;
+
+		if (get_user(rflags, &current->rseq.usrptr->flags))
+			goto die;
+
+		if (current->rseq.slice.state.enabled)
+			valid |=3D RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+
+		if ((rflags & valid) !=3D valid)
+			goto die;
+
+		rflags &=3D ~RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+		rflags |=3D RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+		if (enable)
+			rflags |=3D RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+
+		if (put_user(rflags, &current->rseq.usrptr->flags))
+			goto die;
+
+		current->rseq.slice.state.enabled =3D enable;
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+die:
+	force_sig(SIGSEGV);
+	return -EFAULT;
+}
+
 static int __init rseq_slice_cmdline(char *str)
 {
 	bool on;
diff --git a/kernel/sys.c b/kernel/sys.c
index 8b58eec..af71987 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -53,6 +53,7 @@
 #include <linux/time_namespace.h>
 #include <linux/binfmts.h>
 #include <linux/futex.h>
+#include <linux/rseq.h>
=20
 #include <linux/sched.h>
 #include <linux/sched/autogroup.h>
@@ -2868,6 +2869,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg=
2, unsigned long, arg3,
 	case PR_FUTEX_HASH:
 		error =3D futex_hash_prctl(arg2, arg3, arg4);
 		break;
+	case PR_RSEQ_SLICE_EXTENSION:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error =3D rseq_slice_extension_prctl(arg2, arg3);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error =3D -EINVAL;

