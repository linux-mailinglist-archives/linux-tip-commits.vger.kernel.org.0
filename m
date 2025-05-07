Return-Path: <linux-tip-commits+bounces-5365-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFECAAD98B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BBF17EF56
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04E0221DBA;
	Wed,  7 May 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QIU+hVIp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WXoy+BoV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F5221DB2;
	Wed,  7 May 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604700; cv=none; b=fnWrTzdQxKr3EtYcnwrKSkR57KsTDVnSeS7vOb7NYlSmP0WN6GrGxzcmQU0UR+kiHnAw4llXQh8Kn4TJDN8OzhY/gJUIpUTk1/NhgOBCyEfJwUwuhZ6BWCTHzUuW4Hqz73Dy7lRERj1Y5LPRAsOnIoipVBG2UtbmeHC9uodQsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604700; c=relaxed/simple;
	bh=/CA2wRXmd9QRjouZ5bpvj9Lter1b2zaaompOiAUkZuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kkEMpZhvTrJf7gFj45YcxNsO/untYqaYWm8HxTPRtMumubvMpoLFLPCY9cc3fVHW3mOt8wgoT7ifkSnfTD6vUB0XO6IbGHQi75V854k3IC1xNGdcgzCqH/PIWxtMjWn4gV/p6hRrOOBwF0hZmKpXjecFRUKGIg/x0eiuiZizqV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QIU+hVIp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WXoy+BoV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkwicZIO6+q8EIXJL3H09GDABrLaWA3pum3ayG/bXWs=;
	b=QIU+hVIpZ55pyTlEuSd1q9u0Y/LG0ROMd/FzK5ebCrCojDcXA3/R6aw2ZNOjzcHEXf4uRx
	RJ9AtJL/LW2hICBR5MWSSdWzDoUdU41h9PBYiAD0cqnB8TYRgMPT2PUJpeollwDz5Nmozh
	CDkk08zxq7W8f6EN0gOtFj+0hm8hx16yU4NYH0jofB7+CuVwSy5bjLCW5/+bI565bQ5w4Q
	NO3RKJu6UVUz3ALhDI3CdeiD3K3eTxpxWaNRNjpeh9S5Onz8FfbeDDfliq4WCU9LSw6WKX
	hjlTqpHXOOJ7nkL2uNNSMpAgQb1F/ZT4Jir6tW2jq/CXfjPjHGuvX4x/Pbhtsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kkwicZIO6+q8EIXJL3H09GDABrLaWA3pum3ayG/bXWs=;
	b=WXoy+BoVs4BiA5WK38is2cbtSdKFq97gAenKjm1EZavN+ODbtzzVzzwBst1nKENht+CcNf
	dwAkefND1/cPcTAA==
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
Message-ID: <174660469650.406.2516302492664269760.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     bd7833adad5037ea3690e64b11892f90f1b50878
Gitweb:        https://git.kernel.org/tip/bd7833adad5037ea3690e64b11892f90f1b50878
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:21 +02:00

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

