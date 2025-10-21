Return-Path: <linux-tip-commits+bounces-6966-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74361BF4C3E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 08:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3413540826F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 06:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2105F26C384;
	Tue, 21 Oct 2025 06:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17oh9UUk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m8kChcHl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63221CC4D;
	Tue, 21 Oct 2025 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029689; cv=none; b=pue+/ZB/C3KQV0fHQbSTlvlmcMEhG8U2TCe0hE8nx2HJLgYuDK8Zzh+9VIyAu9IvOs2tkSL5r3OwoHS5dXzeR3MV9S0212TIMSStSXdUoLISJFoP4I224qr49rp4KMTRKq8RMEdZ4wrVtyJ6Iziu2b+YenbbcvTCV+Ae8/w77zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029689; c=relaxed/simple;
	bh=vUVQbOfYmpXVNliJ8ltzcAHcsj2pzeSgxsCuE1Z5P44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NcBoc08zOWWWPQ1ejtOITm/kfLA7BZHnt2Wq4tXx5Cs5JBkbwh8Eit8dMdc7cVSIOMMX4ECh+HpYSk6VPBJZuDN2aH5Din0CZs8V3SaG8D24E8rmgkIsNO24FWxp0XGAitGu2LzPZgSyzLL8WoOR6qHz+zeW+qx4zMNBIGdBsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17oh9UUk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m8kChcHl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 06:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761029678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/ChWnlMCc+/U7BqPT0kmt9rVElzF40BK+wKYBkt9QQ=;
	b=17oh9UUkdJEu9e/UPNmSsmjy7SeRSNNad9nMvcwa40u7fvs6PfIxF3q/FsZulX2kwlzAzp
	5acS/4eTUm9zcX+KlY1GF9o7KIQkDQlMhks9rtK11H2qeG0YsDft5IQ68mLQmWYR/+kWzT
	oaOyEnl7srRXvEumuJF3q0OpdIY7B4Vv9hSBi+VpCiZqNEmXxEorUJpHzrOWNxRELsreOE
	TfwzcyXCJTeiAOd56AlTo1kJhWwOcvOqL7m09EiexKfOJw+rDV7U0uCWw/p7y41yblXOz2
	25LM+g5q/sg5qJmtFZRJR0qVRu45DnTizr/GULS19tiSqVI3D+Tka+p7iFs/VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761029678;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/ChWnlMCc+/U7BqPT0kmt9rVElzF40BK+wKYBkt9QQ=;
	b=m8kChcHlSk3HF9ohf7IKd2NLRlb7NsqzG2WXW5yMRqZB1o8QoUgHoi/eIhJ75Cz2zBPnn6
	Ls/n6iitvEoY9OAg==
From: "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Simplify mp_irqdomain_alloc() slightly
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-janitors@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ccb3a4968538637aac3a5ae4f5ecc4f5eb43376ea=2E1760861?=
 =?utf-8?q?877=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Ccb3a4968538637aac3a5ae4f5ecc4f5eb43376ea=2E17608618?=
 =?utf-8?q?77=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176102967712.2601451.1941450016815014156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     27d2afa3b4eab5fb2a03b6ad8b74a3a700e92dce
Gitweb:        https://git.kernel.org/tip/27d2afa3b4eab5fb2a03b6ad8b74a3a700e=
92dce
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sun, 19 Oct 2025 10:18:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 21 Oct 2025 08:47:33 +02:00

x86/ioapic: Simplify mp_irqdomain_alloc() slightly

The IRQ return value of irq_find_mapping() is only tested
for existence, not used for anything else.

So, this call can be replaced by a slightly simpler
irq_resolve_mapping() call, which reduces generated
code size a bit (x86-64 allmodconfig):

   text	   data	    bss	    dec	    hex	filename
  82142	  38633	  18048	 138823	  21e47	arch/x86/kernel/apic/io_apic.o.before
  81932	  38633	  18048	 138613	  21d75	arch/x86/kernel/apic/io_apic.o.after

[ mingo: Fixed & simplified the changelog ]

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Link: https://patch.msgid.link/cb3a4968538637aac3a5ae4f5ecc4f5eb43376ea.17608=
61877.git.christophe.jaillet@wanadoo.fr
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 5ba2feb..1e0442e 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2864,7 +2864,7 @@ int mp_irqdomain_alloc(struct irq_domain *domain, unsig=
ned int virq,
=20
 	ioapic =3D mp_irqdomain_ioapic_idx(domain);
 	pin =3D info->ioapic.pin;
-	if (irq_find_mapping(domain, (irq_hw_number_t)pin) > 0)
+	if (irq_resolve_mapping(domain, (irq_hw_number_t)pin))
 		return -EEXIST;
=20
 	data =3D kzalloc(sizeof(*data), GFP_KERNEL);

