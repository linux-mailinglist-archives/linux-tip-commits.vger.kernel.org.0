Return-Path: <linux-tip-commits+bounces-8152-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHbPG2gofWk0QgIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8152-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:53:44 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E69BEE7D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 22:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4129301D4CA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 30 Jan 2026 21:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596E8354ACC;
	Fri, 30 Jan 2026 21:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20cbgpQF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JBQiav8T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96A34C9AD;
	Fri, 30 Jan 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769810013; cv=none; b=Lsee80I3292nodjbDKLCmSxIS43yQ3CkT1VboUrrE78Fq0KxCImz5RbXcAkjiTZEuJV9SZQ8lPniYfKgEn33/k6CFeP8fAFJQvYj/aTsgAaLOu5u5GoJWfbJiEUYPYxJEQrfTul2ufPbMQ0slR9Y4z5N3F45dcm7DhhdZJ50RBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769810013; c=relaxed/simple;
	bh=Qd2CCT/MGsRWfPkP/oUUwcnjq2Jq16rax/0HCovCcFo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RsWbtUtoHi4MDQgvmeEKin2uXiT57XN1vj+8Y+VFmkyIsaxXgscOPmofX52+Vy4x+nFArLwn71/J0UmdXo2x7z/qBFymZXj+u7hlb91W9qnh2M8PFW/0j3DHP5Ay1fEoURmEtaZYbFzdBPr1feYCxwtyM9TetA4VyiUkrxfcq1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20cbgpQF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JBQiav8T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 21:53:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769810010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxYSjscn1PZ1zzxnSG3XjWklH9OAiRZBDQuZaVEflrI=;
	b=20cbgpQF3508MlACFLC3r8DnHksKIrR0miEzFAc61FLtcswumzoPkwObQNgP+yivwIjTdq
	n15BoyA+i3qGAon7YZwwW3x7kzAMwJapaUdzQC7sql4vofmQ4+mcq8Z3sKTfRyvtPwdtlj
	+4BpIY/HQ4LlEVWo097OgoAenVrQr+eXe9NpE5l2fwLwx6W9bAIIplwfsbwgUtoev/ncC8
	txg9+wYax/x4H2uzDV4EbV/wyX/GDJ+gZJ8k5rolKCxYRf9whJ1rLHuQYNOzN8jMiVSchp
	GIPF9NRNmd+N2061DOk83OBkuwp2g1B/B+/fYiEhotQ9+rHWoyRhCE7k08Q60A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769810010;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxYSjscn1PZ1zzxnSG3XjWklH9OAiRZBDQuZaVEflrI=;
	b=JBQiav8T13MGrfQ3Og3CnE9MQrNwgagKx8IZxoe0pMOTspVVunnh423uputCUlvTJIkAhN
	h1U+xcaQbUY45kAA==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Remove unused syscall argument from
 syscall_trace_enter()
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128031934.3906955-2-ruanjinjie@huawei.com>
References: <20260128031934.3906955-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981000946.2495410.3737314275813737405.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8152-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,vger.kernel.org:replyto,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 01E69BEE7D
X-Rspamd-Action: no action

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     03150a9f84b328f5c724b8ed9ff8600c2d7e2d7b
Gitweb:        https://git.kernel.org/tip/03150a9f84b328f5c724b8ed9ff8600c2d7=
e2d7b
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Wed, 28 Jan 2026 11:19:21 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Fri, 30 Jan 2026 15:38:09 +01:00

entry: Remove unused syscall argument from syscall_trace_enter()

The 'syscall' argument of syscall_trace_enter() is immediately overwritten
before any real use and serves only as a local variable, so drop the
parameter.

No functional change intended.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128031934.3906955-2-ruanjinjie@huawei.com
---
 include/linux/entry-common.h  | 4 ++--
 kernel/entry/syscall-common.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 87efb38..e4a8287 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -45,7 +45,7 @@
 				 SYSCALL_WORK_SYSCALL_EXIT_TRAP	|	\
 				 ARCH_SYSCALL_WORK_EXIT)
=20
-long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long w=
ork);
+long syscall_trace_enter(struct pt_regs *regs, unsigned long work);
=20
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
@@ -75,7 +75,7 @@ static __always_inline long syscall_enter_from_user_mode_wo=
rk(struct pt_regs *re
 	unsigned long work =3D READ_ONCE(current_thread_info()->syscall_work);
=20
 	if (work & SYSCALL_WORK_ENTER)
-		syscall =3D syscall_trace_enter(regs, syscall, work);
+		syscall =3D syscall_trace_enter(regs, work);
=20
 	return syscall;
 }
diff --git a/kernel/entry/syscall-common.c b/kernel/entry/syscall-common.c
index 940a597..e6237b5 100644
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -17,10 +17,9 @@ static inline void syscall_enter_audit(struct pt_regs *reg=
s, long syscall)
 	}
 }
=20
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
+long syscall_trace_enter(struct pt_regs *regs, unsigned long work)
 {
-	long ret =3D 0;
+	long syscall, ret =3D 0;
=20
 	/*
 	 * Handle Syscall User Dispatch.  This must comes first, since

