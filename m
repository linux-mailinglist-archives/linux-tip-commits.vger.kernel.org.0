Return-Path: <linux-tip-commits+bounces-6121-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4ADB06673
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jul 2025 21:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EA513A54DC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jul 2025 19:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103822BDC26;
	Tue, 15 Jul 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BLtGfPAX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+9o1Pyn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD541EDA3C;
	Tue, 15 Jul 2025 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606325; cv=none; b=cXRy5tnKT+nCnY0h4O2W/Fy1vU9uU+JXsQcAP4vRad2l+akco1onIcR0me8jyYZF1IdhEvNUGjzW5OWFQbRoQYA0iXcQndq6eR2y1j3D3IAgvKxW73J7GYxitYmfE79asKd6q+TdsMvcGArsSlrJjU2H2oTJyMX/o5+BFhpueyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606325; c=relaxed/simple;
	bh=wjdRpswHmtuuSekrUHEnJopvDFSQpmQTMOlNkP242XY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qENVXD2Z8lzjTEuDVP5KsMeaxp0af+5FBZ/7JjYoGs7JEtbMvKlUan/eXqINts24yR+Biq+EBTULOgVyhfoz1SA0WA+3ATZAf1GoGHire3KPwPLe0DSUEfTE3Egv5Ld8EgsE3bJpJQ1IYq3WF2eaosGomb3JjxoH6qPIsM0NtBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BLtGfPAX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+9o1Pyn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 15 Jul 2025 19:05:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752606322;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGctkq543BlHDxWhFOm3lGFLQ4WNDkyKQks0G7ymCy8=;
	b=BLtGfPAXz6wtITxMMfEdjvcBRIL2sMgVfAgLUyVPOgJXEZjXLFsXPk8/s1xd71nCEjOafa
	pxTWSwWY/TcwmDx0Ig1AakZAiVocABx+jVR73a3/8ZSDVaFUZzWqCcsMT//7IRGx4SU3rx
	q5fW8JziPxQrDk+Bvm4eubVxhOAa4meiCkRnP3VY/srzp4Onwl/NXMJeY47P1UTCVZSYz0
	JK6b/FTS3O8Wt0yRL6C4BJtmHY3Q+lr/B5FUAK+F7aKDPqvYr4Dw+9nt+8iwV0p9SflOGr
	3On7iIpNOFgIYnES39KoZ8L9ZjDXfjAFyTFBHl68Nkhqqf4GwmK6RGFiurothA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752606322;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGctkq543BlHDxWhFOm3lGFLQ4WNDkyKQks0G7ymCy8=;
	b=I+9o1Pynlfzu+KBbN8W1BBu3Bc451ziAGy68VhlLlXXQwUF/tBfZeiakLbj2qouY/GRmDc
	4y2Ry5sw4GhVNlBw==
From: "tip-bot2 for Khalid Ali" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/boot: Avoid redundant %cr4 write in startup_64()
Cc: Khalid Ali <khaliidcaliy@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250715181709.1040-1-khaliidcaliy@gmail.com>
References: <20250715181709.1040-1-khaliidcaliy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175260632075.406.7445047355425559021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0149fff886a62465b21d80fa53615ee7de3d72f1
Gitweb:        https://git.kernel.org/tip/0149fff886a62465b21d80fa53615ee7de3d72f1
Author:        Khalid Ali <khaliidcaliy@gmail.com>
AuthorDate:    Tue, 15 Jul 2025 18:16:10 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 15 Jul 2025 20:52:56 +02:00

x86/boot: Avoid redundant %cr4 write in startup_64()

When initializing %cr4 bits PSE and PGE, %cr4 is written after each bit is
set. Remove the redundant write.

No functional changes.

  [ bp: Massage. ]

Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/20250715181709.1040-1-khaliidcaliy@gmail.com
---
 arch/x86/kernel/head_64.S | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 3e9b3a3..5c4be47 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -224,11 +224,7 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 
 	/* Even if ignored in long mode, set PSE uniformly on all logical CPUs. */
 	btsl	$X86_CR4_PSE_BIT, %ecx
-	movq	%rcx, %cr4
-
-	/*
-	 * Set CR4.PGE to re-enable global translations.
-	 */
+	/* Set CR4.PGE to re-enable global translations. */
 	btsl	$X86_CR4_PGE_BIT, %ecx
 	movq	%rcx, %cr4
 

