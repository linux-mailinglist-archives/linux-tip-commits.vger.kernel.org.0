Return-Path: <linux-tip-commits+bounces-8320-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WVsLG/0Oo2m99QQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8320-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:51:25 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01AF1C4276
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0418A30B928E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D3480DD5;
	Sat, 28 Feb 2026 15:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xE9O0egu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ugw7PAwF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103748034C;
	Sat, 28 Feb 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293017; cv=none; b=o6tbstQprDTWoP+er8wROpe0YuTZ+PdMFzV5FmJ29LAnctAoMd73xc8uMberGkdXUZznt4acyolcrOj5quwiOocYpfl/zx0NvqRpUdSfULecexM21HRIlixkXTw+S94scck5OwIABNH39wByME+YS4BBkne9jstmBBYVqZX9+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293017; c=relaxed/simple;
	bh=hzSdP/gyETVx4tU2srxPaYWTbw9+X5YEunXKF7QpbLw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F9HIqCUB9xAw4tlU27+HxNi+JZ/l2xmam0WV4iLE92dW2FW5Jf1dxv/kaBMlfZNSqKjTwWlqw5yLllTZTsp88gpHbENVSWNQLo8rxFBsq6SKIJqxX0H3iOW8YKtTigH3uVHuP55//oKGopk8UmMk8HSb37sZOzSIrHwsGXCjZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xE9O0egu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ugw7PAwF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsSh+NY1hDsIwqjh+3pqsIVUUFLu4cqu3q4GS4JoVJ4=;
	b=xE9O0eguupqnS9XOY42wODx8iygIzXMRzisScAvfGIu0P9dlKg97QPbPjCusSSKD8inrGm
	aJicy8bF4nT5Ae0Vj9r7Asv3vQ7CmEy0uPRWWedc/K8ySosiTswIeJC58Hte9k97rjz9lg
	36DnfumppB5t29aPtvOzYAliJJkKLx5sOfdBqzVA6nDEYGQohei2zzlFphCyk3UAocF36H
	OD0tRY/JUapZL2rdoUsohSdGFOw65+KjO7PQ9rPQYEt4GAdtGywujrxpt1c3dGNE0GiWuO
	3PMS0/3jv5MC5w1eJ5OU6wF98mS3lp7NBV0QgE7Q+LLKKAuRgwiEqLcyW0AWhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qsSh+NY1hDsIwqjh+3pqsIVUUFLu4cqu3q4GS4JoVJ4=;
	b=ugw7PAwFZ98xgFXlW0RAkOxwdC3/ekItiJCuTTQlgSkZimU/XC4NdLVokqbHcB1igFOUKe
	LqGzwI83tCEp32Cg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] x86: Inline TSC reads in timekeeping
Cc: Thomas Gleixner <tglx@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.741886362@kernel.org>
References: <20260224163429.741886362@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229300859.1647592.13245776203770731377.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8320-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: B01AF1C4276
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     b27801189f7fc97a960a96a63b78dcabbb67a52f
Gitweb:        https://git.kernel.org/tip/b27801189f7fc97a960a96a63b78dcabbb6=
7a52f
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:24 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:07 +01:00

x86: Inline TSC reads in timekeeping

Avoid the overhead of the indirect call for a single instruction to read
the TSC.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.741886362@kernel.org
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/clock_inlined.h | 14 ++++++++++++++
 arch/x86/kernel/tsc.c                |  1 +
 3 files changed, 16 insertions(+)
 create mode 100644 arch/x86/include/asm/clock_inlined.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e2df1b1..d337d8d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -141,6 +141,7 @@ config X86
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_DEFAULT_BPF_JIT	if X86_64
+	select ARCH_WANTS_CLOCKSOURCE_READ_INLINE	if X86_64
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_GENERAL_HUGETLB
diff --git a/arch/x86/include/asm/clock_inlined.h b/arch/x86/include/asm/cloc=
k_inlined.h
new file mode 100644
index 0000000..29902c5
--- /dev/null
+++ b/arch/x86/include/asm/clock_inlined.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CLOCK_INLINED_H
+#define _ASM_X86_CLOCK_INLINED_H
+
+#include <asm/tsc.h>
+
+struct clocksource;
+
+static __always_inline u64 arch_inlined_clocksource_read(struct clocksource =
*cs)
+{
+	return (u64)rdtsc_ordered();
+}
+
+#endif
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d9aa694..74a26fb 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1201,6 +1201,7 @@ static struct clocksource clocksource_tsc =3D {
 	.mask			=3D CLOCKSOURCE_MASK(64),
 	.flags			=3D CLOCK_SOURCE_IS_CONTINUOUS |
 				  CLOCK_SOURCE_VALID_FOR_HRES |
+				  CLOCK_SOURCE_CAN_INLINE_READ |
 				  CLOCK_SOURCE_MUST_VERIFY |
 				  CLOCK_SOURCE_VERIFY_PERCPU,
 	.id			=3D CSID_X86_TSC,

