Return-Path: <linux-tip-commits+bounces-2002-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09AE94C0EF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A974E1F22563
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB1B18FC86;
	Thu,  8 Aug 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zTsb4ldf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYOPps13"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8519047C;
	Thu,  8 Aug 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130504; cv=none; b=hW8pmgS4yqV7nu5vE2sE9/q0pkT+rKmNFU/3re5a7WtNCX7cescVTmqxxIQDZ44zDVy/vV7LeMbHM41entlDNXeeJCdPxF7w5x09WMRROTGSqSXixD54UPy80hn+Ba4XgXSzTEJI34f1Su9C9gvqQjcxEBICBDArx2eVYX8vvAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130504; c=relaxed/simple;
	bh=B3IEZburdXRbVjKORykweHV4CyGZ+49UAJgVYd+1LTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iSPa2oYeZew6mVteAU6GXb0yP9QwD749a3PgRvyVGkOtNBDbkfunJDD+5oflJFewVve8JvcqBeur19r/YKM9gTBHaxrVUessqQ15PTzD0ooBhphTUbVhfgut3hK61h9YKa0ZIdVRq+5gw0PxmoV8YD81WcsDGJuWOPRQaBa7ROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zTsb4ldf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYOPps13; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufvkXlRabRsnxi02YUwH/S5HRRlOg8JPBNPCkvRDNNg=;
	b=zTsb4ldfvtqZF/l8ywnCn2NCrKRB9bbUKD6L1om6/CxskqaeKbMdYwxB+dEZIq2l3qZ7gj
	sH1jAc9Rt7BrrC56VjrxAtWSiQn2Fbapnd4/2VIvnZQGo5opvPyhib8C2qVLc4MuhPXyUu
	l978rE4gJRaNKo1JIoHETRbJvrm1oGTanw68jHphFRC4YhgbKnBv0mjClVoyaC7c1pqOXm
	2A6wxj5SvlqhQQE8RIzsPHu7SFKCGiJWVeoDMwBvVpMXHfoh6Wz/Mo1+0CXi8K8CRiIZ6K
	QGiZle9X31BR2IixMk8dV8QGNUoo657nqSRppoOYfPHsaR4dvnDTiOU/Cn0tzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufvkXlRabRsnxi02YUwH/S5HRRlOg8JPBNPCkvRDNNg=;
	b=uYOPps13vCAgXqJff++XXJDUNlAGuQjWNn5CB/qo405FWR5x70Q5Bco3717z2cjtQmw6Rq
	izeWjfiHncBsOnDw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove irq_chip_regs:: Polarity
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240808104118.430670-3-jirislaby@kernel.org>
References: <20240808104118.430670-3-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050036.2215.12559364319026801910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     60029162a0458832ab2bcfc6fd4986bfd9ca0f55
Gitweb:        https://git.kernel.org/tip/60029162a0458832ab2bcfc6fd4986bfd9ca0f55
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Thu, 08 Aug 2024 12:41:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:02 +02:00

genirq: Remove irq_chip_regs:: Polarity

The polarity member of struct irq_chip_regs is unused. Remove it along
with its kernel-doc.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240808104118.430670-3-jirislaby@kernel.org

---
 include/linux/irq.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 00490d6..fa711f8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -991,7 +991,6 @@ void irq_init_desc(unsigned int irq);
  * @ack:	Ack register offset to reg_base
  * @eoi:	Eoi register offset to reg_base
  * @type:	Type configuration register offset to reg_base
- * @polarity:	Polarity configuration register offset to reg_base
  */
 struct irq_chip_regs {
 	unsigned long		enable;
@@ -1000,7 +999,6 @@ struct irq_chip_regs {
 	unsigned long		ack;
 	unsigned long		eoi;
 	unsigned long		type;
-	unsigned long		polarity;
 };
 
 /**

