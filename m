Return-Path: <linux-tip-commits+bounces-4713-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B88EA7D65F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C10E7423D66
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9063D221F35;
	Mon,  7 Apr 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDKVarx4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iz9eGnbK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE4D1A238A;
	Mon,  7 Apr 2025 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744011135; cv=none; b=H7u+CzFNe0HVYAQ1XXlCUcUrc0FavNS7AJ4tqm4+oEwBKwqWAQrYS43pwYoOtEDV7uAmirJFuTHAG7RsvCDbdgWD9bwatYeRPobVaTxAHcxiVWAhVj84veIgXKlmjndsSu8dkaZnz9fjdrBPXFiWjcM/Q6sExGEZks1xCWeE1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744011135; c=relaxed/simple;
	bh=8MLOUBHPZC2MbjSghE5jkWGcu3uy5RIwzxKc8jXLiIU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jolf3grIatTFrECxxsWaFwVIK3h5ViJRVKwp2pNs+1hALJ+kJyAaw12tVug1MeRn/TzrN6ZAqgYUeG5yjCSFJRDo7oQyvShwvRrRoPbCSNqx4yljuMShaonnH11jcogW6a6A6SIxNqpAZQtjScPnyPMIXD+TGDm1WhkRT4jf/PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDKVarx4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iz9eGnbK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:32:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744011132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPohzg2O6EanjcJ+6wjo4VYDXa6mgLYgMZE1Ap7kpFQ=;
	b=bDKVarx4paCG05sg7/P8187hTUqRFwKQnp/W1cJY1fkJG7uXU/9aXBqlNVwgUGDDUnSG+V
	jjyHWe9mpy3Z+n9Ub1kAUXlCga9XMQcCff9z7Sd1VprbjgjFUaF+bIFSuhe8xNPdNVIUI0
	K8kSJuf1HgR77Y+9U5eloGF55ZC+6OjPH0YLMlMYCxQ+C69PYPVHh/c7Xl359gu8T+9YoE
	c80VVG9V125VjkOSbcOSOEsb2wEX6Tj/5j2JE5GojxyRWumEKRwadpJgL7yMHbmN3zkac4
	MH/TxjEsq3ZtpRS2CHerbd5P3NJqj7XfWuL11D+ap25u5RKwr2Wd3Bd7HdB0ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744011132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPohzg2O6EanjcJ+6wjo4VYDXa6mgLYgMZE1Ap7kpFQ=;
	b=iz9eGnbKbx3euMvHZ/QI5vSrZ2s1cjG8xeeZGLwBy5/klnHJZr2/D7BodWhy2jkqJH7Fq1
	Qd91vIk2mZo7OzBQ==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sg2042-msi: Add missing chip flags
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250405055625.1530180-1-inochiama@gmail.com>
References: <20250405055625.1530180-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401112660.31282.10731182221763237853.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     305825d09b15586d2e4311e0c12f10f2a0c18ac5
Gitweb:        https://git.kernel.org/tip/305825d09b15586d2e4311e0c12f10f2a0c18ac5
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Sat, 05 Apr 2025 13:56:24 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:23:55 +02:00

irqchip/sg2042-msi: Add missing chip flags

The sg2042-msi driver uses the fallback callbacks set by
msi_lib_init_dev_msi_info(). commit 1c000dcaad2b ("irqchip/irq-msi-lib:
Optionally set default irq_eoi()/irq_ack()") changed the behavior of the
fallback mechanism by making it opt-in.

The sg2042-msi was not fixed up for this, which causes a NULL pointer
dereference due to the missing irq_ack() callback.

Add the missing chip flag to msi_parent_ops.

Fixes: c66741549424 ("irqchip: Add the Sophgo SG2042 MSI interrupt controller")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-3-apatel@ventanamicro.com
Link: https://lore.kernel.org/all/20250405055625.1530180-1-inochiama@gmail.com

---
 drivers/irqchip/irq-sg2042-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index ee682e8..375b55a 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -151,6 +151,7 @@ static const struct irq_domain_ops sg2042_msi_middle_domain_ops = {
 static const struct msi_parent_ops sg2042_msi_parent_ops = {
 	.required_flags		= SG2042_MSI_FLAGS_REQUIRED,
 	.supported_flags	= SG2042_MSI_FLAGS_SUPPORTED,
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_mask	= MATCH_PCI_MSI,
 	.bus_select_token	= DOMAIN_BUS_NEXUS,
 	.prefix			= "SG2042-",

