Return-Path: <linux-tip-commits+bounces-8172-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMdeMeuJf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8172-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:14:19 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E97C6A88
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 857C930022D5
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174427FD62;
	Sun,  1 Feb 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hmIVdUfN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlLk4YAt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDB284B54;
	Sun,  1 Feb 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966035; cv=none; b=kTPp1oPUaGkApRKp50D1/cxF2yQQkYnpz3h7ZFefyh7YLZUmZxx2rMHnk+xw96J2yfEqBzxk4UWwwV2ZUmljGijMKms0qcEmjzo7L96IIScOrfagDLqa3rjbhmowkKgatYi2Lvd/AjciaHv3fBil0h9pU2JBdxGBHYFhG0DEWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966035; c=relaxed/simple;
	bh=3z3Iy/OcPzV2DpONKOtt9qnmFMhxsCJWuSkmgFKBpfE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MNqm6i4SlPFt2tgxba8z5aChqV6xPaXK9uK9hNTbwG+InyH2Dl6lP6RQwOKfNH83jMpag16UEBlNRy46ejFGm3UkvGQsBK1cXxEkcY5+oidLjRGwtOy5T49xwqxonu8DVvQMbqMi0A2jrdYE7xDYCmZ3PCJOFdMSt4DAFw3tEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hmIVdUfN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NlLk4YAt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SUhGG8dglHSp2d73it4H0ScAigND4rPnqQ5fUqBd1w=;
	b=hmIVdUfNiFcC7irwQ6t4VckrHIjUv0PPj1s7s5rptXJB70gkpFHAtJBUH43lV6x049ICDm
	ARpWq6gCj4hYryAz4FuEzWpGku8+HQQJ13CZyXgaO7zVMpoxrmHKLvgo3cjPTi/GNyBjfR
	Qff/y15vLJwQcd5eiH3xFJvc6Zr/+Wn+nQ78SJuVo7otPfo/RCkxr5oNnJVdIHL9LOfUKt
	dElFMecSG6m9clxFel1W2cG8pgQkUN2/lTY/s/VbVQ3MYRzGOMgDBJ0wWZYGmIxP2qmO6l
	xp07s7xc0vOLcFU0rONPDqirylsRe+CIrxcAxEVehpZHQXcQI4SbDfO8YxrKyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966027;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8SUhGG8dglHSp2d73it4H0ScAigND4rPnqQ5fUqBd1w=;
	b=NlLk4YAtyboMsqod1boJOpgjhYCmGZFMGqI9t053j3ra7QNSmipBU5ZMfWuFiTgK7cBjaq
	/QcdP0Sd76OUeJDQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] ARM: versatile: Remove IRQF_ONESHOT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Linus Walleij <linusw@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-9-bigeasy@linutronix.de>
References: <20260128095540.863589-9-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996602610.2495410.688137039274239134.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8172-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim]
X-Rspamd-Queue-Id: 94E97C6A88
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     a82bf786500a011c0ecc63ce1511b7fc471137cd
Gitweb:        https://git.kernel.org/tip/a82bf786500a011c0ecc63ce1511b7fc471=
137cd
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:28 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:15 +01:00

ARM: versatile: Remove IRQF_ONESHOT

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

Revert adding IRQF_ONESHOT to irqflags.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-9-bigeasy@linutronix.de
---
 arch/arm/mach-versatile/spc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versatile/spc.c b/arch/arm/mach-versatile/spc.c
index 812db32..2d27777 100644
--- a/arch/arm/mach-versatile/spc.c
+++ b/arch/arm/mach-versatile/spc.c
@@ -459,8 +459,8 @@ int __init ve_spc_init(void __iomem *baseaddr, u32 a15_cl=
usid, int irq)
=20
 	readl_relaxed(info->baseaddr + PWC_STATUS);
=20
-	ret =3D request_irq(irq, ve_spc_irq_handler, IRQF_TRIGGER_HIGH
-				| IRQF_ONESHOT, "vexpress-spc", info);
+	ret =3D request_irq(irq, ve_spc_irq_handler, IRQF_TRIGGER_HIGH,
+			  "vexpress-spc", info);
 	if (ret) {
 		pr_err(SPCLOG "IRQ %d request failed\n", irq);
 		kfree(info);

