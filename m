Return-Path: <linux-tip-commits+bounces-5308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 877E3AAC608
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E2E1C067DB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A8289351;
	Tue,  6 May 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s6ykpuj8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4+o7wdoh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7B288C86;
	Tue,  6 May 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537645; cv=none; b=Rz+/zWV29Ya+coGw58ZkTIfU9kj0PfIdm6Zvp/+X0HW5w6s8YnNxvTEadQb4/BV+2qRpzqJ6/eVx0kQy+BzSiHUcPIwbGS/3ldrswqjxJ0QGOcEy4E8w5hRCbgysfSZqMZ57CBzUvalnyXtJJrru0QUY/bOLbfNxo0GULaJECJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537645; c=relaxed/simple;
	bh=7frndUiWX3xEb//oZhV5N7x2Jz2z3kVJx1oRSTa/M6w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OYEpf6i/2v5YiXI2GKPRnJ7gUey2h1tJ2pI6HB047FloYydDM9uMG3qfJs6K8OcvzknwuK/qRppkkRNJAZEvHvAb1e7DgmpW+EAYHSY3/0v4i0SSj7USeTVCnSt/g/3Fb14wv31fK+KCTtUp1Oe/MKPAo5YurM5QIG0ubuL3dSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s6ykpuj8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4+o7wdoh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+w3I1YsvPI7inganiPMaFq/E14FcFp06JSVUL2t7pZU=;
	b=s6ykpuj8kYzWAtwa3Z+XTYN5ktdIqrd2CJuMeg3mzQag/N86ew79Wd7yjcR9XHYlTLz88V
	WCmq3U+zEv/PraBAPjGwCITDTXioZKIJ6SKJWuPrEcK3M0oAVxynbPKfeW+vQXIvb9mbbs
	fN2LI0F28pinSoKCEEBV6vrKuZoxmvq7TZ1HWrOUTMg7Rc/RKqs6WpmfYTZpOOTYeLrKzW
	9zbEIoTNwcxeBTycSBdz0HLoo0e+gCueEE5FUi7cNIrHDhcCEMbXqlo6eaoxlRn1notxWC
	WdegGU5wF5xXV6odPlFFSfh4u67j9pv4pqRG6L3964jNdR0aS+wgo7LaRAfOng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+w3I1YsvPI7inganiPMaFq/E14FcFp06JSVUL2t7pZU=;
	b=4+o7wdoh57Z+Q+n4v5XepIiQIGW9IqpCtGE/GA9ZB8Y7Md+4j9IcRD/DkITrmcEDouOZvm
	9xr0dBVw56jkCbCw==
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
Message-ID: <174653764148.406.11053477800522298924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     51cd7f0bee520df4dbbee6d8f813f970e3d57edb
Gitweb:        https://git.kernel.org/tip/51cd7f0bee520df4dbbee6d8f813f970e3d57edb
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:03 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:04 +02:00

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

