Return-Path: <linux-tip-commits+bounces-8103-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIdDHgH7cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8103-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:25:05 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB2E6535F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 617F2824B24
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B03EF0B7;
	Thu, 22 Jan 2026 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tS9dEb1J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AwnHg7/p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E83E8C6C;
	Thu, 22 Jan 2026 10:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076969; cv=none; b=atYsnovE65FdLytKTf8ZzHH0vYzy610RgqkOU0fwRSHuVjG4C6pxn6BpKr1g1VeoQIKQfFmOX7StlSxBA6c8i/3FEFF9587kX4AjRzD0afAGyzGTK0K2R1VxfrnXjT51/9M0p3tk5tb5/gEkW1Uub2K1mRpnF5AdlO4yqxoU5UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076969; c=relaxed/simple;
	bh=mZEFxdrHnFE/XN6uyBBw0SFc2/liOHGHr17kb150Ki0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lDPZzHg1Q12ltQv5LHICx4FjQZTcUY9Yii2IOquam11mprwfRozdsnsLOM1D95Tnl0npV6509AcBuTUD863ZznzagfoYGQTgW+cqbIYyoFR1SITZUoC8TnY3aRLFrs+LyGcFtiltMSXK9Jga59o14GerVs0oLPtlGH8M70xtGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tS9dEb1J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AwnHg7/p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:16:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEcWgUWcAWWij2wLes4m9lHgv/XEnlrlQH2daSitzz0=;
	b=tS9dEb1Jx7SdKdj/vDcWf8z0SGY/t9X4CvmgBdoSxOSHic+gIwq+1VD5HWvAEfloYbZpQG
	BRGqZi1dU4BC7BO1TJUDUxxlrmXpK+O27foWKEURGiEDEPAQpk6cIcNckB+O017xyIDzwH
	ZSbMFYjTxW6rKU/fY44X6xQ4L953w0LwmOeHSK4tADimYq7reCmM/4a1KITsmlh7zhzRqc
	TUZ/5Q4ESrsz6GIyieCLjF/xKFdRQu6XkT7jaGVZDzrnWVhOQGOWbYzudRxV1+WC9gFTtc
	0eWAqMEucWD9M0iXbabBQsxt1ArNop0VQZAjXHZjeoGcn8y2Zvm5SH4U29flNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEcWgUWcAWWij2wLes4m9lHgv/XEnlrlQH2daSitzz0=;
	b=AwnHg7/pnuK6nd8g3aZkhX2LaD4G/lRVtkTfCpoJWEOLi8jgEOa8bIXqsaWZ/78chtwm2l
	enyBv6Vac9PIAFCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Implement sys_rseq_slice_yield()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251215155708.929634896@linutronix.de>
References: <20251215155708.929634896@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907696439.510.7942680473551218935.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-8103-lists,linux-tip-commits=lfdr.de];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linutronix.de:email,linutronix.de:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto,efficios.com:email,arndb.de:email]
X-Rspamd-Queue-Id: DCB2E6535F
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     99d2592023e5d0a31f5f5a83c694df48239a1e6c
Gitweb:        https://git.kernel.org/tip/99d2592023e5d0a31f5f5a83c694df48239=
a1e6c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:15 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:17 +01:00

rseq: Implement sys_rseq_slice_yield()

Provide a new syscall which has the only purpose to yield the CPU after the
kernel granted a time slice extension.

sched_yield() is not suitable for that because it unconditionally
schedules, but the end of the time slice extension is not required to
schedule when the task was already preempted. This also allows to have a
strict check for termination to catch user space invoking random syscalls
including sched_yield() from a time slice extension region.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://patch.msgid.link/20251215155708.929634896@linutronix.de
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +-
 arch/arm/tools/syscall.tbl                  |  1 +-
 arch/arm64/tools/syscall_32.tbl             |  1 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +-
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +-
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +-
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +-
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +-
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +-
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +-
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +-
 include/linux/rseq_types.h                  |  2 ++-
 include/linux/syscalls.h                    |  1 +-
 include/uapi/asm-generic/unistd.h           |  5 ++++-
 kernel/rseq.c                               | 21 ++++++++++++++++++++-
 kernel/sys_ni.c                             |  1 +-
 scripts/syscall.tbl                         |  1 +-
 22 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/sysca=
lls/syscall.tbl
index 3fed974..f31b7af 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -510,3 +510,4 @@
 578	common	file_getattr			sys_file_getattr
 579	common	file_setattr			sys_file_setattr
 580	common	listns				sys_listns
+581	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index fd09afa..94351e2 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -485,3 +485,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 8cdfe5d..62d93d8 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -482,3 +482,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscall=
s/syscall.tbl
index 871a5d6..2489342 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -470,3 +470,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/ke=
rnel/syscalls/syscall.tbl
index 022fc85..223d263 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -476,3 +476,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/sys=
calls/syscall_n32.tbl
index 8cedc83..7430714 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -409,3 +409,4 @@
 468	n32	file_getattr			sys_file_getattr
 469	n32	file_setattr			sys_file_setattr
 470	n32	listns				sys_listns
+471	n32	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/sys=
calls/syscall_n64.tbl
index 9b92bdd..630aab9 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -385,3 +385,4 @@
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
 470	n64	listns				sys_listns
+471	n64	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/sys=
calls/syscall_o32.tbl
index f810b8a..1286531 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -458,3 +458,4 @@
 468	o32	file_getattr			sys_file_getattr
 469	o32	file_setattr			sys_file_setattr
 470	o32	listns				sys_listns
+471	o32	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/sys=
calls/syscall.tbl
index 39bdaca..f6e2d03 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/s=
yscalls/syscall.tbl
index ec4458c..4fcc7c5 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -561,3 +561,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	nospu	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscall=
s/syscall.tbl
index 417ed16..09a7ef0 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -397,3 +397,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/sy=
scall.tbl
index 969c113..70b315c 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -474,3 +474,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/sysca=
lls/syscall.tbl
index 39aa26b..d5b1a71 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -516,3 +516,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls=
/syscall_32.tbl
index e979a3e..f832ebd 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -476,3 +476,4 @@
 468	i386	file_getattr		sys_file_getattr
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
+471	i386	rseq_slice_yield	sys_rseq_slice_yield
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls=
/syscall_64.tbl
index 8a4ac48..524155d 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -395,6 +395,7 @@
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
+471	common	rseq_slice_yield	sys_rseq_slice_yield
=20
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/sys=
calls/syscall.tbl
index 438a3b1..a9bca4e 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index 67e40c0..8c540e7 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -89,9 +89,11 @@ union rseq_slice_state {
 /**
  * struct rseq_slice - Status information for rseq time slice extension
  * @state:	Time slice extension state
+ * @yielded:	Indicator for rseq_slice_yield()
  */
 struct rseq_slice {
 	union rseq_slice_state	state;
+	u8			yielded;
 };
=20
 /**
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index cf84d98..6c8a570 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -961,6 +961,7 @@ asmlinkage long sys_statx(int dfd, const char __user *pat=
h, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
 			 int flags, uint32_t sig);
+asmlinkage long sys_rseq_slice_yield(void);
 asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned fla=
gs);
 asmlinkage long sys_open_tree_attr(int dfd, const char __user *path,
 				   unsigned flags,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/uni=
std.h
index 942370b..a627acc 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -860,8 +860,11 @@ __SYSCALL(__NR_file_setattr, sys_file_setattr)
 #define __NR_listns 470
 __SYSCALL(__NR_listns, sys_listns)
=20
+#define __NR_rseq_slice_yield 471
+__SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
+
 #undef __NR_syscalls
-#define __NR_syscalls 471
+#define __NR_syscalls 472
=20
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 09848bb..d8e1992 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -553,6 +553,27 @@ die:
 	return -EFAULT;
 }
=20
+/**
+ * sys_rseq_slice_yield - yield the current processor side effect free if a
+ *			  task granted with a time slice extension is done with
+ *			  the critical work before being forced out.
+ *
+ * Return: 1 if the task successfully yielded the CPU within the granted sli=
ce.
+ *         0 if the slice extension was either never granted or was revoked =
by
+ *	     going over the granted extension, using a syscall other than this one
+ *	     or being scheduled out earlier due to a subsequent interrupt.
+ *
+ * The syscall does not schedule because the syscall entry work immediately
+ * relinquishes the CPU and schedules if required.
+ */
+SYSCALL_DEFINE0(rseq_slice_yield)
+{
+	int yielded =3D !!current->rseq.slice.yielded;
+
+	current->rseq.slice.yielded =3D 0;
+	return yielded;
+}
+
 static int __init rseq_slice_cmdline(char *str)
 {
 	bool on;
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index bf5d05c..add3032 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -390,6 +390,7 @@ COND_SYSCALL(setuid16);
=20
 /* restartable sequence */
 COND_SYSCALL(rseq);
+COND_SYSCALL(rseq_slice_yield);
=20
 COND_SYSCALL(uretprobe);
 COND_SYSCALL(uprobe);
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index e74868b..7a42b32 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -411,3 +411,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	rseq_slice_yield		sys_rseq_slice_yield

