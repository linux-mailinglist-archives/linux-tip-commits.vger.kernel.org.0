Return-Path: <linux-tip-commits+bounces-7634-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D198CB8661
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33BCE301FF6E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF701D9663;
	Fri, 12 Dec 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVwMQrua";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eDV8qkU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE01E885A;
	Fri, 12 Dec 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530643; cv=none; b=cZWSw+ZXR7AArTDBipmBVwdhgOvprfFd4IS3ykLKWhBkEHJgtXgU2RfgjCXytV1Swragf8SY0xRmWBv5oJUHtDGn3QoAMWJvm5CvbvRFlQpzhWDlrBpnug98/D54sww4+I+VWiyNgrf6Am2uwTK4c4/VeyYuRlN7Skea+IM7qgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530643; c=relaxed/simple;
	bh=S7Xrcf8DWK6Zg6k1bXGKllZ2QQ9mSkru6AIPJge/49w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dwsSa8Nl+3FSqJ7J0ghj+GJ4hdbBa1+zFiQWagRsbGg80Yy9kTQBNKNsFT0B/xDh8CvxJBo8YmdwbUEKDF9SsqyiIPgV9t6Jzm+x+EUlCVszYmzWiszbvbM56gsjHZ5UFw9/wlTAaltAvpVixzwc1EJN9VS79nPUtfeYk8XMQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EVwMQrua; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4eDV8qkU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:10:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765530640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLm+jyvmLWDyoAHBE1WvpWIuhP6EWYm8Oc4TNPngHDg=;
	b=EVwMQruaSetCfegK01N5JnT9itDEi8Uuy/xIGCv8wbXuJUpaYhwgbVTRg7DO/AqKyzRWA7
	hFkEgAAqrqUeF/ZnDmiyFRJ52g7mEVxEFIbNFSGjAMJfOTS0q0ukZg3DJdiXPWznSGQcqM
	HnjKBlRSNH3Rs16xnh8Lnbr52mvMSGgZqlfUSvuzoGwZflLCpgvYODTK9awSTgiJeH8v8I
	ofzk8vml8xKnqsK5F1GGY30OZuQPUkxCwp6ys6Mkpj4hddmgs72rLfDdanRYoiXSbHrNxv
	4jxu4hLReRiiBhsCXxf/zsqDr+ycHw9aAI9EGC8IHukyNvcosIfDfhGUxd1iiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765530640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLm+jyvmLWDyoAHBE1WvpWIuhP6EWYm8Oc4TNPngHDg=;
	b=4eDV8qkUD2PGmCbAT8I6zDNGi/4efR7bIhu1qcuEOaQTsyLkQbgQkUIUgSuEjcAGMnBLzC
	n+SYauun8jl0PwBA==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] rseq: Always inline rseq_debug_syscall_return()
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251205100753.4073221-1-edumazet@google.com>
References: <20251205100753.4073221-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176553063868.498.12063574097297367509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     f1de49094b9e0b44f85a0f8b77bc27d8ca222e3c
Gitweb:        https://git.kernel.org/tip/f1de49094b9e0b44f85a0f8b77bc27d8ca2=
22e3c
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Fri, 05 Dec 2025 10:07:53=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 10:07:06 +01:00

rseq: Always inline rseq_debug_syscall_return()

To get the full benefit of:

  eaa9088d568c ("rseq: Use static branch for syscall exit debug when GENERIC_=
IRQ_ENTRY=3Dy")

clang needs an __always_inline instead of a plain inline qualifier:

	$ for i in {1..10}; do taskset -c 4 perf5 bench syscall basic -l 100000000 |=
 grep "ops/sec"; done

		 Before	     After
	ops/sec  15424491    15872221   +2.9%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251205100753.4073221-1-edumazet@google.com
---
 include/linux/rseq_entry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index c92167f..a36b472 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -596,7 +596,7 @@ static __always_inline void rseq_exit_to_user_mode_legacy=
(void)
=20
 void __rseq_debug_syscall_return(struct pt_regs *regs);
=20
-static inline void rseq_debug_syscall_return(struct pt_regs *regs)
+static __always_inline void rseq_debug_syscall_return(struct pt_regs *regs)
 {
 	if (static_branch_unlikely(&rseq_debug_enabled))
 		__rseq_debug_syscall_return(regs);

