Return-Path: <linux-tip-commits+bounces-5625-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD4ABA428
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4449D1C01AB2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF6328A719;
	Fri, 16 May 2025 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ppeMq5d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="da/0SYyu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E128A1F0;
	Fri, 16 May 2025 19:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424272; cv=none; b=EwooTq660VIc4yLAUxo5/jUCYT6F823SVQMfeUSB+t7a5n0wJuIs8euY5xgtx2VmmmuK2YKTXxSmZ0zK+EzBriP3UJB+ReExmf4fMmdjP+bMPeXnWPrGaIWNvl/5f6dZxuU4SqxUVMu2laFhPE3xJHTWWRACzDDIIouxlJMD7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424272; c=relaxed/simple;
	bh=TuwcxbR64HUVL5ckcMwDs/IurmmgHycXdY7VGxpFVUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PRn8Fbo41KAF7UtfiCLKtBb4BSQm8cYkwrulS7MHAZlfmSdlGeRpWCKBBBqc3hCGceyEpwpCHAZwWcYWx6/vHYoKR8gGpWJSRfyafRY0qvCLDOqAMOqj4l+gB06lPbV0HJIb3w9RZ+THHdMLrb0TfG3JgFbtmGkGn6OQaWU09rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ppeMq5d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=da/0SYyu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRKyPwQRNX1H4OjOzI5p4LzsdWRQKg+55/Y8vsNzuYg=;
	b=4ppeMq5d4o240uIJsMz1M7R2uphqL4C3SPhWBr2X2IRCocdMPEafRwXNL7dN1OUETc0Jjj
	crrNtuhTkMYur99nBiP/Vp36XlCZW1VJEJaiKJ6VsB+MM0Q5sT6A3Ux8/Z+fidBnu32C61
	mrU11Xt2LKmcBTM+38IwKuUXwRDkXa2gVgkYWg5i7/egRvrpohbtypyUq3kOgjLvghSlII
	TZ6GK74Gz4bbEaVfxEpReG9bshuou4eWJ082CBTxZam5p7f7CI1/c478Tk8Gd+S0Znpgb9
	JzvpiEve28q0OGqgPBok3w8pRUTOHF87cqMZt6+09G+yJ7TE8AoRzTaMZCSJ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRKyPwQRNX1H4OjOzI5p4LzsdWRQKg+55/Y8vsNzuYg=;
	b=da/0SYyucG61B9CjC1r0NtHPbfwXhzDEV3H/m1ewE3R2CEni9kwtJfm44CPhT2upakdmS2
	psqmUHFHyR4AZZDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] x86/io_apic: Switch to of_fwnode_handle()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-11-jirislaby@kernel.org>
References: <20250319092951.37667-11-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742426811.406.7338059150562475205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     b712918091c9c712a77f1c85c29e5bb750e9e281
Gitweb:        https://git.kernel.org/tip/b712918091c9c712a77f1c85c29e5bb750e9e281
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:08 +02:00

x86/io_apic: Switch to of_fwnode_handle()

of_node_to_fwnode() is irqdomain's reimplementation of the "officially"
defined of_fwnode_handle(). The former is in the process of being
removed, so use the latter instead.

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-11-jirislaby@kernel.org


---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index eebc360..487992c 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2225,7 +2225,7 @@ static int mp_irqdomain_create(int ioapic)
 
 	/* Handle device tree enumerated APICs proper */
 	if (cfg->dev) {
-		fn = of_node_to_fwnode(cfg->dev);
+		fn = of_fwnode_handle(cfg->dev);
 	} else {
 		fn = irq_domain_alloc_named_id_fwnode("IO-APIC", mpc_ioapic_id(ioapic));
 		if (!fn)

