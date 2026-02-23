Return-Path: <linux-tip-commits+bounces-8231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECdfBe4rnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:29:02 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A64C1174E23
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C52D23049D76
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC533624DE;
	Mon, 23 Feb 2026 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uCFn//2H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w1L/p4W7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC72E63C;
	Mon, 23 Feb 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842333; cv=none; b=O9gJAwLKLFMLcrbxot85s05SYP4u1s71CnNoNda6hsXZiwygFs8GCeFDsOwlmrPo7Sm8SlRDLsdK4uTlxSL1HXYaQiut6rcR8DRNzUXvmRapEKrf9IORFlQCATC9EYY7aEU9QZK7E0p56hiJCMK5FpjweCaBecQEcq9ZLW7pg9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842333; c=relaxed/simple;
	bh=6UFquLn5t/5BnsRxYIITBCJXoRmizDag8hVN+oAgbQg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SRVM9/984ytPDAQAtszuDfpALKwXiPZEHSJhzdFQ1PZYUQ0TriShVWDM0IP1WyGOmYV4e1+8v1vOfSyaQ6eabbfGAntw2aXCJV1mJ7ahqmz85+e2kqWXM1xEtafSkWoGNE0I6CZQRYrt+ENZFC7SolthWWIIn5ak2oVOmf7jgRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uCFn//2H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w1L/p4W7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Coq3+77giBU1dKH4pi+lTDho3k2GAks3exZUdCnjhTo=;
	b=uCFn//2HMEnm62vpecXsyHr2yhJgmKgU/xd73fNC3RBhMgKGNWlLk9dJWDbgG2tYBaebbx
	12hQTRcuir6UytwEJXi8AiJXi9uu7uDjhxDbVvQZOfjLVpeWZLf47bvygwTh9hWiWuyIkj
	RU/VXzQYkp9r7ZQTkBx9ng7gA5LLFqk91ymkhbL7vxa67qBgd2Tx/ZZFd9wDfvNohGz0Lu
	f1etvOBDOmHkUMVXrm3ANyiCe1My/BUaEtEJo3xa19MZ6M88RKBAy05zqCTtMY2orR1u6K
	WdNUAlLFjvJE3819EPKll8cIVEAcj5w0NozGp5PctbfsLqm95eBVu6/PqOwOOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Coq3+77giBU1dKH4pi+lTDho3k2GAks3exZUdCnjhTo=;
	b=w1L/p4W7ljQsX0+Bkt4wnxEX71MFWhZjWKXTwFBEVXGfc2Cscq9Gxr4c04FLIz+Z0HVfMz
	3ft7iw/NebdHnSAw==
From: "tip-bot2 for Hou Wenlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bug: Handle __WARN_printf() trap in
 early_fixup_exception()
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc4fb3645f60d3a78629d9870e8fcc8535281c24f=2E1768016?=
 =?utf-8?q?713=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
References: =?utf-8?q?=3Cc4fb3645f60d3a78629d9870e8fcc8535281c24f=2E17680167?=
 =?utf-8?q?13=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184232933.1647592.3857722794552502662.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8231-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:replyto,antgroup.com:email];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: A64C1174E23
X-Rspamd-Action: no action

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a0cb371b521dde44f32cfe954b6ef6f82b407393
Gitweb:        https://git.kernel.org/tip/a0cb371b521dde44f32cfe954b6ef6f82b4=
07393
Author:        Hou Wenlong <houwenlong.hwl@antgroup.com>
AuthorDate:    Sat, 10 Jan 2026 11:47:37 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:11 +01:00

x86/bug: Handle __WARN_printf() trap in early_fixup_exception()

The commit 5b472b6e5bd9 ("x86_64/bug: Implement __WARN_printf()")
implemented __WARN_printf(), which changed the mechanism to use UD1
instead of UD2. However, it only handles the trap in the runtime IDT
handler, while the early booting IDT handler lacks this handling. As a
result, the usage of WARN() before the runtime IDT setup can lead to
kernel crashes. Since KMSAN is enabled after the runtime IDT setup, it
is safe to use handle_bug() directly in early_fixup_exception() to
address this issue.

Fixes: 5b472b6e5bd9 ("x86_64/bug: Implement __WARN_printf()")
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/c4fb3645f60d3a78629d9870e8fcc8535281c24f.17680=
16713.git.houwenlong.hwl@antgroup.com
---
 arch/x86/include/asm/traps.h | 2 ++
 arch/x86/kernel/traps.c      | 2 +-
 arch/x86/mm/extable.c        | 7 ++-----
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 869b880..3f24cc4 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -25,6 +25,8 @@ extern int ibt_selftest_noendbr(void);
 void handle_invalid_op(struct pt_regs *regs);
 #endif
=20
+noinstr bool handle_bug(struct pt_regs *regs);
+
 static inline int get_si_code(unsigned long condition)
 {
 	if (condition & DR_STEP)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 5a6a772..4dbff8e 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -397,7 +397,7 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
=20
-static noinstr bool handle_bug(struct pt_regs *regs)
+noinstr bool handle_bug(struct pt_regs *regs)
 {
 	unsigned long addr =3D regs->ip;
 	bool handled =3D false;
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 2fdc1f1..6b9ff1c 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -411,14 +411,11 @@ void __init early_fixup_exception(struct pt_regs *regs,=
 int trapnr)
 		return;
=20
 	if (trapnr =3D=3D X86_TRAP_UD) {
-		if (report_bug(regs->ip, regs) =3D=3D BUG_TRAP_TYPE_WARN) {
-			/* Skip the ud2. */
-			regs->ip +=3D LEN_UD2;
+		if (handle_bug(regs))
 			return;
-		}
=20
 		/*
-		 * If this was a BUG and report_bug returns or if this
+		 * If this was a BUG and handle_bug returns or if this
 		 * was just a normal #UD, we want to continue onward and
 		 * crash.
 		 */

