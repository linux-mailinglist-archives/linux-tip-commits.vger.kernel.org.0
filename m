Return-Path: <linux-tip-commits+bounces-2482-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD79A1348
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41E61C2227F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7044C21A6FE;
	Wed, 16 Oct 2024 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oHT3JhHd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JewUKcN8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4552219498;
	Wed, 16 Oct 2024 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109063; cv=none; b=m5UacutmH/GOhGD/4QIvAPVRjVkTc2CRwJToiqJapzA6bQLHw5hIYRrYPexj2rIP7rjRS4WHUxz85O9Ds8DkvfyP0/HhSdgPhsCehEBd4MG9DzcZrW7h8fwcqRV/XPsDPBVmWcNBYXsJ+1Djtnd6KjzActTEWHyM4mD0l8bStF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109063; c=relaxed/simple;
	bh=dBblgA81ayXexdlynWDthspGKXU23KJMhD+J7j/T7L8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ky6nP0in8QDVA1SJtxSID5ieELciACs9w3/kzWeAshaYPpmgrWuV+2yEtfeGlmTdms5JEuWIVodvfAQCP611blL6ln/EpUrMuejZR5vJIVqeNHAuduLbP0eSq/n2KQcrpXd567AobTYUWjArIRdVwsxM2yDYE/ORXd4D2chUP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oHT3JhHd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JewUKcN8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDU/jwIsDNdnQuxpVf4xCdXa6esi1nVfAgW9ypzTX50=;
	b=oHT3JhHdNaQo2mZIviF1vcdP4kVRBrUcpwqV5V3oanZ/YpvcDvJer7nmtrKlZQcH4J7jQK
	+YnZh8/CaOrgd0Eqq4ZmDFrr3oOV5WjXwcwhjYiIz0ShGp+Ml9owxMgk7zd98SF0sY2L7I
	OBV7lTEbce9QoVH7rRtltGXh0PSiLvrB2MCuuauwQr8uRleuBLituN2ym9K/FxFcMMIhyb
	lFJxlyLqm9/xM5BVYwb2W6kpLHYAKDkFCbdZHaFVufOiYksrTDDiU8OpUpzaS7Uq6laCPS
	9KmB7mPEF/3Ijkj5rzmSQqxIm7DfXLVQwTOCU2H00+ndKUGH9v9dST1NMfMn4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDU/jwIsDNdnQuxpVf4xCdXa6esi1nVfAgW9ypzTX50=;
	b=JewUKcN8p1zZ+Rjq3Lxie4Ce9bU+EdctFCg2OsHdqkIs/fX6qgQJLW8IT9qFHjM3j+VSme
	0kViAJKygk+c/yCQ==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net: hamradio: scc: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-11-bvanassche@acm.org>
References: <20241015190953.1266194-11-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910905883.1442.10437903381497971673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4e69f13167f5618b5d487aa88db4800d0934a994
Gitweb:        https://git.kernel.org/tip/4e69f13167f5618b5d487aa88db4800d0934a994
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:41 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:57 +02:00

net: hamradio: scc: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-11-bvanassche@acm.org

---
 drivers/net/hamradio/scc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index a9184a7..c71e522 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1460,6 +1460,7 @@ scc_start_calibrate(struct scc_channel *scc, int duration, unsigned char pattern
 
 static void z8530_init(void)
 {
+	const unsigned int nr_irqs = irq_get_nr_irqs();
 	struct scc_channel *scc;
 	int chip, k;
 	unsigned long flags;
@@ -1735,7 +1736,7 @@ static int scc_net_siocdevprivate(struct net_device *dev,
 
 			if (hwcfg.irq == 2) hwcfg.irq = 9;
 
-			if (hwcfg.irq < 0 || hwcfg.irq >= nr_irqs)
+			if (hwcfg.irq < 0 || hwcfg.irq >= irq_get_nr_irqs())
 				return -EINVAL;
 				
 			if (!Ivec[hwcfg.irq].used && hwcfg.irq)
@@ -2117,6 +2118,7 @@ static int __init scc_init_driver (void)
 
 static void __exit scc_cleanup_driver(void)
 {
+	const unsigned int nr_irqs = irq_get_nr_irqs();
 	io_port ctrl;
 	int k;
 	struct scc_channel *scc;

