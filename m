Return-Path: <linux-tip-commits+bounces-2006-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE194C0F6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E65E1C20904
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D055619066F;
	Thu,  8 Aug 2024 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="heGD4n26";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1LK5V7FY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CFE190481;
	Thu,  8 Aug 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130505; cv=none; b=s/g9lUxVnxQH2iY3H9hUzYQ5Ln0fY1Hal34g/+ykXt7G4Jmj39HoD8ZhTZrlXhSbXpZM6ps1xhg7HRlsJ6j+W2NncxKs6va392yDfLnvg83tNa87g7A+4q1h82yFz1NrL+U+o+85r1/l3ILS3JEgLDie2hEngOUJjlo/0D6VQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130505; c=relaxed/simple;
	bh=zX/9oI03GKAshK1d0EPf2QOCEnsvcNnws4xWc1AzR/Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Hc0C42b6Wr/Kt9IOrAq9Hq4P8fZvEGaHtDSyKkBXGwjJ4nyDyq6bucWdHw8WwKe/KEbBZPdRE91GuuWZrqnTrMPAjY+gH8i6WW9wYpZecjaYXCL36Q/5diAlAupkf+KTcTbrcZ55MtiEf6pZ7VZtGnGmwMtfvrxB7ip6lvBFJuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=heGD4n26; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1LK5V7FY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NegVKPAZepQvuM+DBeUL78UE7HKJxqiMDBOPLD0cxzo=;
	b=heGD4n26rQ2la2mmyjHfhgu4xJGigpY8s48XAkZXfw1hvbkfU79JAswNAJdaBGZHWaT9IV
	y6K54sKKwJipnq/StMfvkiT7bUcYGv6aaXZL0t3v9RmupA7RQ/be7qCu3JQyY2FL0jlx9L
	3AfdHnd1YGGIOESSWVORGXVyyS1+ev0z+wHzS6vVRzqSdgJpd5l58zhb9fu8gJKf929ha6
	6VPOAvszm8DjQyblWYGl3x9X0JLlVM40oOCwttXcGtg2Jbleiu906fhXI6/9GpPe3FZOsu
	jb2aSjZM//ofFuq3/9y+owdRELcdeb8GdweNRAp/SPsRdTPAMBNcXbPBkcrYsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NegVKPAZepQvuM+DBeUL78UE7HKJxqiMDBOPLD0cxzo=;
	b=1LK5V7FYT4i8qzv1FygHatoJ5K92mQEfRGLZgBNFsyKPQQut/eKlPFx02waXRxPXP1LXXr
	Z8haiy6cGsLtYtCA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use mpic_is_ipi_available() in
 mpic_of_init()
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050236.2215.13782643605464875107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b77c6a73e10ae16b19999bebc6ca1413739dfe86
Gitweb:        https://git.kernel.org/tip/b77c6a73e10ae16b19999bebc6ca1413739=
dfe86
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:41:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:01 +02:00

irqchip/armada-370-xp: Use mpic_is_ipi_available() in mpic_of_init()

mpic_of_init() contains the last case where the open coded IPI support
condition needs to be replaced with mpic_is_ipi_available() to keep the
code consistent.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 4f3f99a..d7c5ef2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -879,7 +879,7 @@ static int __init mpic_of_init(struct device_node *node, =
struct device_node *par
 		return err;
 	}
=20
-	if (mpic->parent_irq <=3D 0) {
+	if (mpic_is_ipi_available(mpic)) {
 		irq_set_default_host(mpic->domain);
 		set_handle_irq(mpic_handle_irq);
 #ifdef CONFIG_SMP

