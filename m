Return-Path: <linux-tip-commits+bounces-8004-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C204FD202C4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 17:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2840307DBE2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 16:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78B91D5170;
	Wed, 14 Jan 2026 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P7/9r+fy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tCLymXl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAFD3A35D9;
	Wed, 14 Jan 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407435; cv=none; b=P+1gD1H2SpjzdKknNvCE3HUmvVU1V6+LOX4EDZhsoA8eqlmsw8/jN6IaattzoNpFslZdaJmqrXglSU4Itm4l6TD0M6CQ8tUG70rJA/QAg1H+GHuR1dgVBbXpCq1ewy6TtbYdEAcbDvDqm2LX+SJIhRF3QydQRRp5TrGx+c93XT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407435; c=relaxed/simple;
	bh=4y2F/dl4GafMRr00NnnDGpiyxx+Nl0cx3eaPaovgs1c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jtBVjYW9Y+DJx0tHjx8ftHxWF2Lty1U0oIXPqJRimhLhSaWihh3fS/gyYTzPMMDKQwr2mQA/wMW4a/zQoUAQl/s9NWGR0+H9HcLUP8G9Khzy9afFC2dUt7zESqNrE8E9StD2f7iwtRc0RofZNueqc+jdOFYKjF8ceU0LI/QasWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P7/9r+fy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tCLymXl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 16:16:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768407421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkt45m6x00TuJV44udxO1XkigVjnoVz0bB3yAe+W2Sw=;
	b=P7/9r+fyBomupPwn3FNbzLByn8p9PQA+uPYULJKSFppuImFLlo1UnpKP/Qe76/7gGPrpAG
	UG11GGkYqRop5rHrtZ5+gYNsefPLAvedjLDor+JDMztSdQrtaaHzvwzm7sFv8DpylenN4i
	RhksrSXjY3a4ZWLPdFJOYsgWsTRkNxYRBigho6lphpMV76IXhBROC5Uo/elTpUvpNw+jjg
	CqrZeXKpcUyO/+AAuaRzwL8fjEMU11/S6AU3uLTf9ZMgvei+0uapXWRVML0RRPGXi9vGiS
	Zp/sOjH4xJ8r5y5e5PAvSmQbbiU1xoSG2LC5opjDpIqukCkthknj+xJbB+eZ1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768407421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkt45m6x00TuJV44udxO1XkigVjnoVz0bB3yAe+W2Sw=;
	b=2tCLymXliY4NwRX1kQHyrA0CD1BwBeEHdWX3WE5S7M2648/W3E1eDmQRVadTHMsHgt5kdq
	qPDGlGOeRtS6BFCw==
From: "tip-bot2 for Ryosuke Yasuoka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/traps: Print unhashed pointers on stack overflow
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251224070735.454816-1-ryasuoka@redhat.com>
References: <20251224070735.454816-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176840741930.510.13867270177839334217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     6b32c93560cb194e10279bd3be3c1d0fa30df3e7
Gitweb:        https://git.kernel.org/tip/6b32c93560cb194e10279bd3be3c1d0fa30=
df3e7
Author:        Ryosuke Yasuoka <ryasuoka@redhat.com>
AuthorDate:    Wed, 24 Dec 2025 16:07:32 +09:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 14 Jan 2026 16:31:53 +01:00

x86/traps: Print unhashed pointers on stack overflow

When a stack overflow occurs, the kernel prints hashed fault address and the
stack range using %p. The actual addresses are required for debugging and
hashed pointers provide no useful information in this context.

Use %px to print the unhashed, raw addresses.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251224070735.454816-1-ryasuoka@redhat.com
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index bcf1ded..5a6a772 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -549,7 +549,7 @@ __visible void __noreturn handle_stack_overflow(struct pt=
_regs *regs,
 {
 	const char *name =3D stack_type_name(info->type);
=20
-	printk(KERN_EMERG "BUG: %s stack guard page was hit at %p (stack is %p..%p)=
\n",
+	printk(KERN_EMERG "BUG: %s stack guard page was hit at %px (stack is %px..%=
px)\n",
 	       name, (void *)fault_address, info->begin, info->end);
=20
 	die("stack guard page", regs, 0);

