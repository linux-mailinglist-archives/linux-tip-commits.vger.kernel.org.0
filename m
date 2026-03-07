Return-Path: <linux-tip-commits+bounces-8379-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLkgHuI8rGkJngEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8379-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 07 Mar 2026 15:57:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47D22C3F6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 07 Mar 2026 15:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F3643038AE4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Mar 2026 14:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F312417E0;
	Sat,  7 Mar 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kfXPyJaz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4LDUtku"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544C7081F;
	Sat,  7 Mar 2026 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772895454; cv=none; b=Z0XpDXFm9nG+YBHQ5VoLlbM+UkXI1sBWJL+JsvC+sR+rkQzFwBa4SjzCgwIHxYVJ34Dhbz5B6pkuaR7AH7LL5GwmwETrWiBYOP+CxMZIh3Jy4ynOMdv5ZL23CGEHoTXinGQUEUDAeFc+mv1Lwlp4woThqaglqot8JG0cQA0aDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772895454; c=relaxed/simple;
	bh=rvgCQdPiHF+7XtuPB0ZVdf2Bx4TQ9S+MYo4Y4UkQLr0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YQ6/0iUgcjGrB79BRL1qtZUmwL0sqqZq978hc9ZPx3g9ydG5KQEwZia3G0Wo3j/wJTh7BowwpgE13+xRh2xOszr0UJI7OZFb+XMeCfkRV9hZ8vr02EXXHySQxiirU0lwCC7pg9TdF2yzrs7K26Xz0JpmXXGMCVEB8ptUaE/ptBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kfXPyJaz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m4LDUtku; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 07 Mar 2026 14:57:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772895445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mlLIa7m3cXCl9lfT5pSteLmJBqS1gTGOMyEL0n/jUE=;
	b=kfXPyJazRNhZMatOZycU7/o//uywp49nH9WTJNM2VtZ9MfK97jNHSpzL00Os/VxT6vANg3
	hj63sjwKb03u1OI1VgV5sxxF+Oa7mSLPkVGFxcXuTLN7Ov8iD3dMRvAsE2idzpjoDUfXac
	DLQ0+bM1TyUMSoWInI05CSgebE3ixRTQsqfZRoR/EpHKlCj+cxyWTZ8nZWxYgEjfWe36jV
	Um04B7ZvbfI3XhCTyQMvW0rXoDPPojU2m0CwFFe0yf4fPSz5ABOTQcEQvcgQYQMDWeyifG
	uBxqQB+opUWAQNu3XBgieP96iPfN7jWBCcm7O87CcOZyv8fb6oDUiJe00D6RhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772895445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5mlLIa7m3cXCl9lfT5pSteLmJBqS1gTGOMyEL0n/jUE=;
	b=m4LDUtkubQteqtb0+SIg1DxZF1BortzvENA3OxVOJchKDGbkrEOe6ThO1DGYFYdRKYtH2a
	ZdHMhVb6lMwTSqDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/asm: Use inout "+" asm onstraint modifiers in
 __iowrite32_copy()
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216105134.248196-1-ubizjak@gmail.com>
References: <20251216105134.248196-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177289544362.1647592.4912429391863565755.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CD47D22C3F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8379-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:replyto,msgid.link:url,zytor.com:email,linutronix.de:dkim];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,alien8.de,zytor.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     09fbb775f1d01945119c4a0be4afacf30cc86796
Gitweb:        https://git.kernel.org/tip/09fbb775f1d01945119c4a0be4afacf30cc=
86796
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 16 Dec 2025 11:51:20 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 07 Mar 2026 15:46:10 +01:00

x86/asm: Use inout "+" asm onstraint modifiers in __iowrite32_copy()

Use inout "+" asm constraint modifiers to simplify asm operands.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://patch.msgid.link/20251216105134.248196-1-ubizjak@gmail.com
---
 arch/x86/include/asm/io.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index ca309a3..2ea2574 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -218,9 +218,8 @@ static inline void __iowrite32_copy(void __iomem *to, con=
st void *from,
 				    size_t count)
 {
 	asm volatile("rep movsl"
-		     : "=3D&c"(count), "=3D&D"(to), "=3D&S"(from)
-		     : "0"(count), "1"(to), "2"(from)
-		     : "memory");
+		     : "+D"(to), "+S"(from), "+c"(count)
+		     : : "memory");
 }
 #define __iowrite32_copy __iowrite32_copy
 #endif

