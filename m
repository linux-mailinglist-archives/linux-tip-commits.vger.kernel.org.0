Return-Path: <linux-tip-commits+bounces-7118-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F89C270C7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 22:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E002B3BD012
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A846913635E;
	Fri, 31 Oct 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="310DFkdg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pDpc3ekJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F0199939;
	Fri, 31 Oct 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946267; cv=none; b=ubolxv38Dcf6/EZYtxZe1jb7+S8betbS8d5WToMKfiiYIAKczBtvWs5Mk6Z2X/8rVM38IsbrHh44C4kpBCd4zKHxPk2lwcud3PS5cJD3g/qu57s0Elx/P+bJ/oDk9q2pTgUjEeeM61tNw+MREY9tvvbJkkbO7oP8ZNA1G1+sfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946267; c=relaxed/simple;
	bh=RVJa4CIzdulGQpmpQOOcrgAZzPi/OWAHk7HvFHoks2Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Md3XcpbDDNNG3+/4er+fkNzTZ0OtTXd8ahOldkLCC/Ph55PIRFPIhytHvFgbkYD07xDHLB3a9n0/1UHR0xW5O6SYXgB4GVe0aWXnMMMTEgOZ2xtQBT+biCWcYrSocQsacPZw0jm4y/H8lEmPRQzF2TPkK7vyVkDVGSU+nRmi4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=310DFkdg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pDpc3ekJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 21:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761946262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y9+KIVuwdKPcReZfxTenFgbg5voSsJ77ocpFGj7if4=;
	b=310DFkdgyC6rdjrP1njKqBeT2xzPTcjEa4rgrmcNwpip5Oc1uEgSh9qQukfB7m8q0kGx/5
	Daw6+cuEVXxkjUCcY+rPkz80W4BAj4GEF/ILvsOpnPDjP9VYjeZdji+/k0i+vlLo8tvuoz
	V3dpldc0aJeN1FpshrLo5CMV7C2pahrR3nR1qwpGNqHLfzyQIvG5Pb70tNEfm+EKII6CO2
	AEEtGjq7Yg/mYeqXE1946k7MO9fzsfVtMOoL6iL4iSC0IFJ3A+8HDJ0FGCbkWSRaHdeZOm
	uwYEZwgf91c+RBRM3WCrvXs3G/kXylM1YR2kxzB5oD9GhMycagHmuaj1skAH2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761946262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Y9+KIVuwdKPcReZfxTenFgbg5voSsJ77ocpFGj7if4=;
	b=pDpc3ekJwIUX+Q3/J677Bqezqcnko1Q6mw/B7mF0gSkryWcG2B6YTbvxl9rJPnSApLREi+
	nxFXiaG5qISdHSBQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix percpu_devid irq affinity documentation
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251030143032.2035987-1-maz@kernel.org>
References: <20251030143032.2035987-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176194625897.2601451.5829284082042961218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     68c4c159a0db4409a5d6b5f4703d71b89a96f06a
Gitweb:        https://git.kernel.org/tip/68c4c159a0db4409a5d6b5f4703d71b89a9=
6f06a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 30 Oct 2025 14:30:32=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 31 Oct 2025 22:25:34 +01:00

genirq: Fix percpu_devid irq affinity documentation

Stephen points out that some of the percpu_devid irq affinity
documentation is either missing or not matching the data structures.

Address all the issues in one go.

Fixes: 87b0031f7f73 ("irqdomain: Add firmware info reporting interface")
Fixes: 258e7d28a3dc ("genirq: Add affinity to percpu_devid interrupt requests=
")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251030143032.2035987-1-maz@kernel.org
---
 include/linux/interrupt.h | 1 +
 include/linux/irqdomain.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index fa62ab5..266f2b3 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -109,6 +109,7 @@ typedef irqreturn_t (*irq_handler_t)(int, void *);
  * @name:	name of the device
  * @dev_id:	cookie to identify the device
  * @percpu_dev_id:	cookie to identify the device
+ * @affinity:	CPUs this irqaction is allowed to run on
  * @next:	pointer to the next irqaction for shared interrupts
  * @irq:	interrupt number
  * @flags:	flags (see IRQF_* above)
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5907baf..952d3c8 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -48,7 +48,7 @@ struct irq_fwspec {
  * struct irq_fwspec_info - firmware provided IRQ information structure
  *
  * @flags:		Information validity flags
- * @cpumask:		Affinity mask for this interrupt
+ * @affinity:		Affinity mask for this interrupt
  *
  * This structure reports firmware-specific information about an
  * interrupt. The only significant information is the affinity of a

