Return-Path: <linux-tip-commits+bounces-8097-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKhXHdH6cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8097-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:24:17 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885065342
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9E96E66A577
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6938356A24;
	Thu, 22 Jan 2026 10:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QVNED1WO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWUNrpq8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8336827F;
	Thu, 22 Jan 2026 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076944; cv=none; b=mwKqXsea1Ro1C26i7/NHjH0ZzDPdnYCyvXPJemTUEBqwiwYBB/CxstkPlKjMuLZ6EPz3mKnqCTeo0yA3bWHjERhaS8u/0Gh9ko1PS+w9mE372wZnWC1KldCuRWGiPXejM9MH9CzyM0i13+UDAz+CBcRXa0YrfczKIHgNjVK59m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076944; c=relaxed/simple;
	bh=R1dbrl0MIaPrESKvSwYrQFSqMq2F5VQUsCg3BLDdaFY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p85Qq4LWmJfbr2PK0rri8g3QME0SUB9XOPB+SPGCOpcaHOxxnIHyqWVWYPduRBeoWR9TwsniNfGz4OtBXrtOGBd70kw3vCPHJx2yo4JE+xdX1tUxuAebU/lemO8EJSTfbYsIV1Zdtc6ixmZN0cYtURXzyq/W8lnfr1vT+pEEn6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QVNED1WO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWUNrpq8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjFt8rTyIgiQiKJZuVKgsslhrMtQE3L9Qy0NRBQhOCs=;
	b=QVNED1WODKwT0NBzdpQPXM3fMKcdJ6aokHhUzfftQh06yPEFZ0huWcVW5mTxk5sjAqa6O3
	pwcLsmCo50O4TEBfN3Cgh4T50elYljj7EQ8+kwq7V/y7Ud/y/qu/l4wiiQp0hDpuO25N42
	oOcm5NbNmB2Hkl13Bg6JPGcfnug+eQdxPazmnTreEf4ttN2mi2HL0J6wcsQsHRYsQnAxkV
	LdPQwXx/0ke0W9mECVDQoFNQHBWexcSbQMdJlbt9rxvG9v5WykqUGER2k77pRvEKGClcYH
	wIT8ElgLOCoiPiDoQIU6emD/Xqt5Ys1bUV/iT0Xdqzd7CKJkXAY95FhfVj6ETw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjFt8rTyIgiQiKJZuVKgsslhrMtQE3L9Qy0NRBQhOCs=;
	b=hWUNrpq8bcS6hInUnYU+niSMQKvGlZpYpdsVgDIx6WggqghyUai80pLj9a2EIJ69fF1Pdl
	/a8doOrGp6KlxMAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Allow registering RSEQ with slice extension
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121143207.814193010@infradead.org>
References: <20260121143207.814193010@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907693970.510.5602511824863257539.tip-bot2@tip-bot2>
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8097-lists,linux-tip-commits=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:replyto,msgid.link:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,linutronix.de:dkim,efficios.com:email]
X-Rspamd-Queue-Id: 2885065342
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d6200245c75e832af2087bc60ba2e6641a90eee9
Gitweb:        https://git.kernel.org/tip/d6200245c75e832af2087bc60ba2e6641a9=
0eee9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 19 Jan 2026 11:23:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:19 +01:00

rseq: Allow registering RSEQ with slice extension

Since glibc cares about the number of syscalls required to initialize a new
thread, allow initializing rseq with slice extension on. This avoids having to
do another prctl().

Requested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260121143207.814193010@infradead.org
---
 include/uapi/linux/rseq.h |  3 ++-
 kernel/rseq.c             | 12 ++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 6afc219..863c4a0 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -19,7 +19,8 @@ enum rseq_cpu_id_state {
 };
=20
 enum rseq_flags {
-	RSEQ_FLAG_UNREGISTER =3D (1 << 0),
+	RSEQ_FLAG_UNREGISTER			=3D (1 << 0),
+	RSEQ_FLAG_SLICE_EXT_DEFAULT_ON		=3D (1 << 1),
 };
=20
 enum rseq_cs_flags_bit {
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 275d701..1c5490a 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -424,7 +424,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rs=
eq_len, int, flags, u32
 		return 0;
 	}
=20
-	if (unlikely(flags))
+	if (unlikely(flags & ~(RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)))
 		return -EINVAL;
=20
 	if (current->rseq.usrptr) {
@@ -459,8 +459,12 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, r=
seq_len, int, flags, u32
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
=20
-	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
 		rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+		if (rseq_slice_extension_enabled() &&
+		    (flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON))
+			rseqfl |=3D RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+	}
=20
 	scoped_user_write_access(rseq, efault) {
 		/*
@@ -488,6 +492,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, r=
seq_len, int, flags, u32
 	current->rseq.len =3D rseq_len;
 	current->rseq.sig =3D sig;
=20
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+	current->rseq.slice.state.enabled =3D !!(rseqfl & RSEQ_CS_FLAG_SLICE_EXT_EN=
ABLED);
+#endif
+
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields

