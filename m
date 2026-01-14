Return-Path: <linux-tip-commits+bounces-7987-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE675D1E25C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 11:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE77B301A4EE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2341394478;
	Wed, 14 Jan 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xf84FFk7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Amk/wTyW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0BC393DE2;
	Wed, 14 Jan 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387216; cv=none; b=EpE71bEbumvD6fqDYzv2QYWoa9bJSen/au5V+JaPwnzfiP35tmk8w4SroUrqgKnCA7GfS1MLmshe+hNy90VSlPbzJk5TCoyveO+bStZPefgZlHhjzD9GCTJIsUIpjwoJByCSmXZw7+QoAuX4vypUecNTSB2/R+MBkHzqugO9N98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387216; c=relaxed/simple;
	bh=c0EFPr3hzc2I/+nqrYhO3jhVkclwkuwbote04bB2ZX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EZLrJdzHYdrKT2oljtN5ziW33fnkhBbrV4w1eOjUu6Ql3mz3epy/pBTS+oJN7UZYhdsHE5AQ6BWP19L3n3+p9ZrNTGutcSNatLez4RNLg0zvYqE6oJvgZT+UYuMlybDIWKaLKGyziuHMoRQEI8/RTYfVHQ5VcGE43dhAl9V/ZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xf84FFk7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Amk/wTyW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 10:40:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768387208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWycsLg+lqPYjp9jNW7gGoUmqRXDFLy4e1mPqU/b+90=;
	b=Xf84FFk7BETd0f8XyikzstGh7yy4V4uK9OMqtLjhEjysQECCHKX2UDIsdRF84496+y3+d3
	s/zfZ+lTJKb2LHItxhDGNhWmqVjz8bo/+K2LXzQxMlVLXwLnMLVGNcZmsJP0mISxJcG1NV
	I55Hh7W47CQVqTPAd2QuGhGY7LwWJHacyz8WWHUNniqNzZiARvBzHVyJDO75tAwJudna5A
	Mvw95FAz7CAmG9tEmdQB3Mr4G+lzkLr1YOvSZbmlLz8UeH5SUFYAz77c1vutBjLPWIYQcQ
	BlSVbtC38tJngur2+FiPEoHIGvx2O5s/3Bc3OGG58f2pqV1Mir3e+ViV/XY+hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768387208;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWycsLg+lqPYjp9jNW7gGoUmqRXDFLy4e1mPqU/b+90=;
	b=Amk/wTyWFtkZw2tikssPLVgHJEYWGGY76JGiHzqvuR6zuz8LhrhrrfDpVXl035rZs+izQ/
	8KdSK+WPZBv/onAw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/xen: Drop xen_irq_ops
Cc: Juergen Gross <jgross@suse.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260105110520.21356-16-jgross@suse.com>
References: <20260105110520.21356-16-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176838720740.510.6791553332245814020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     bc5e8e2fa2e28ef6c2a55ae294d04100d4b1bffe
Gitweb:        https://git.kernel.org/tip/bc5e8e2fa2e28ef6c2a55ae294d04100d4b=
1bffe
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Mon, 05 Jan 2026 12:05:14 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 12 Jan 2026 19:37:38 +01:00

x86/xen: Drop xen_irq_ops

Instead of having a pre-filled array xen_irq_ops for Xen PV paravirt
functions, drop the array and assign each element individually.

This is in preparation of reducing the paravirt include hell by
splitting paravirt.h into multiple more fine grained header files,
which will in turn require to split up the pv_ops vector as well.
Dropping the pre-filled array makes life easier for objtool to
detect missing initializers in multiple pv_ops_ arrays.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://patch.msgid.link/20260105110520.21356-16-jgross@suse.com
---
 arch/x86/xen/irq.c    | 20 +++++++-------------
 tools/objtool/check.c |  1 -
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 39982f9..d8678c3 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -40,20 +40,14 @@ static void xen_halt(void)
 		xen_safe_halt();
 }
=20
-static const typeof(pv_ops) xen_irq_ops __initconst =3D {
-	.irq =3D {
-		/* Initial interrupt flag handling only called while interrupts off. */
-		.save_fl =3D __PV_IS_CALLEE_SAVE(paravirt_ret0),
-		.irq_disable =3D __PV_IS_CALLEE_SAVE(paravirt_nop),
-		.irq_enable =3D __PV_IS_CALLEE_SAVE(BUG_func),
-
-		.safe_halt =3D xen_safe_halt,
-		.halt =3D xen_halt,
-	},
-};
-
 void __init xen_init_irq_ops(void)
 {
-	pv_ops.irq =3D xen_irq_ops.irq;
+	/* Initial interrupt flag handling only called while interrupts off. */
+	pv_ops.irq.save_fl =3D __PV_IS_CALLEE_SAVE(paravirt_ret0);
+	pv_ops.irq.irq_disable =3D __PV_IS_CALLEE_SAVE(paravirt_nop);
+	pv_ops.irq.irq_enable =3D __PV_IS_CALLEE_SAVE(BUG_func);
+	pv_ops.irq.safe_halt =3D xen_safe_halt;
+	pv_ops.irq.halt =3D xen_halt;
+
 	x86_init.irqs.intr_init =3D xen_init_IRQ;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3f79993..0c32a92 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -571,7 +571,6 @@ static int init_pv_ops(struct objtool_file *file)
 	static const char *pv_ops_tables[] =3D {
 		"pv_ops",
 		"xen_cpu_ops",
-		"xen_irq_ops",
 		"xen_mmu_ops",
 		NULL,
 	};

