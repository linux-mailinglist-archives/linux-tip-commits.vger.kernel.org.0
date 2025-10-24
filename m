Return-Path: <linux-tip-commits+bounces-6987-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F39C056BD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 11:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0583AD523
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F0430BF6C;
	Fri, 24 Oct 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHAdZgDI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BTzqbrYZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2A2D322E;
	Fri, 24 Oct 2025 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299093; cv=none; b=dEDMK/o4rlI0bcxa3j4Lo0xUT68+y+n+usQ2wV3nmx55kR7mjARkVebNSKYaBWrIpOUNruL5X7MWvuxmiNv/Zs25hwMimaz94MASfLeknZkSHUJAHV9+K3VYzTgTxdFEDc+0GQNhqW5h+CQd645NleaX1ZJbb2KmUcFr1nyC9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299093; c=relaxed/simple;
	bh=gnI5PiyGdGC/6DCBE4sF5zLKqsw13zCniK7MyQGdQZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rqTQFg3CB7/jtXZwKtR0hwnRwKzUftlX6evl2OlL75aEAM/UF8xEVX9w3v9VQhv2QO91hz9Y7gbzslN5g68I1yD3+1dQ/hEe0ExNIGAES9ZYVVMdrHIUG0go5p2YAMNqKyRDbYTG1OGr4YF1FM2Id3TbWto3LIbFft92tRiDeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHAdZgDI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BTzqbrYZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 09:44:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761299090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdXmD0XBABrMgLSolqvp+7gxlKW2dmBGndfHL36EDwg=;
	b=dHAdZgDILmnypg4KUMlur7DKLLdnYuwDxMdZSTfNzFYA5xyH9eQEJ637L6SMdHTMbKrgWy
	4KrG3knrTzWwkN3gB69RzT5IQ2slItYTdMH1Ztw3HYdEXT3alXbOQl7PVY/Pg9+EyJ9p7/
	Edj++J0/Qzg7ksYCOJQyP1Ai7wpcU4Iy1Nbu8TDAR3PJsNYa+PB/904hbnQphHBDtMCevn
	pdvvIfDJZ6JpcCrZZArj5g/DuOqDCV6wx8rz4b7z2fMQMmym01IsE+3boP14JMZkv4Te90
	cCD/XEcDkKiUHxsIns8T8bOgavksrkxQ+6XsscRebH6HYdk0FN5+f8t8TWb5MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761299090;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wdXmD0XBABrMgLSolqvp+7gxlKW2dmBGndfHL36EDwg=;
	b=BTzqbrYZI6+rL35EcYjGk3tanpqOyD3s0il6PnxkPl4DolaEo5ev970cs/G0oAbS3oI54W
	mt0vl3FVRA3bSlAA==
From: "tip-bot2 for Charles Keepax" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] genirq/manage: Add buslock back in to enable_irq()
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251023154901.1333755-4-ckeepax@opensource.cirrus.com>
References: <20251023154901.1333755-4-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176129908889.2601451.10785928796558063212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ef3330b99c01bda53f2a189b58bed8f6b7397f28
Gitweb:        https://git.kernel.org/tip/ef3330b99c01bda53f2a189b58bed8f6b73=
97f28
Author:        Charles Keepax <ckeepax@opensource.cirrus.com>
AuthorDate:    Thu, 23 Oct 2025 16:49:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Oct 2025 11:38:39 +02:00

genirq/manage: Add buslock back in to enable_irq()

The locking was changed from a buslock to a plain lock, but the patch
description states there was no functional change. Assuming this was
accidental so reverting to using the buslock.

Fixes: bddd10c55407 ("genirq/manage: Rework enable_irq()")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251023154901.1333755-4-ckeepax@opensource.ci=
rrus.com
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7d68fb5..400856a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -789,7 +789,7 @@ void __enable_irq(struct irq_desc *desc)
  */
 void enable_irq(unsigned int irq)
 {
-	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
 		struct irq_desc *desc =3D scoped_irqdesc;
=20
 		if (WARN(!desc->irq_data.chip, "enable_irq before setup/request_irq: irq %=
u\n", irq))

