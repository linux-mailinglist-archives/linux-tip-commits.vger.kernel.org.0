Return-Path: <linux-tip-commits+bounces-1702-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE029315A4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 15:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9BE1C2132C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 13:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B1E18F2C7;
	Mon, 15 Jul 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xWWI9kjh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RyNH27L8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375418EA81;
	Mon, 15 Jul 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049645; cv=none; b=YXryOL27Z8Jc03sUhOW9qqPpJFrUYuNNGXhINfupPH3YwFvvfQGFhyb8ViF8g8SOmeeVnl95beTG/0MsV5dVZKDeANhH8dkgc/l5tAtcGKGXPSTcxUkFbvYHk2k1PPzcc+KGfR8dI2OegEdK5xzET9aamHMwMk+YUpg+gE6uHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049645; c=relaxed/simple;
	bh=mSuzfIIVELuWQOxT5HmM4VijFTDVNozokt2scLmY0sM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BbeTSzqQ8fgWSb47pIN46bpg4Ms9dRGyVs+uxUFgR4tvNHk+TYsHd/S2GYOCvUbBdZ3cW764drolDAsiS1Wp3pLUZdiIuT36egzVluQU7C8x9ewsGhIA1Ox73NX3P1W5skkUsBABFZWm6s1V1fDjkIipJt6RwhR06SIVARMnKAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xWWI9kjh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RyNH27L8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jul 2024 13:20:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721049639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myl2TH41alCre5NE09vEruv/3VGqC7WlTNo5kaPmIss=;
	b=xWWI9kjh0YwXBUHOemlmU7OSV7tb00OmD78EOHX8VCR70W50sX584OO9eH9lZ6+lhmSwCH
	LxCBrovj9EOaJ2PcUSzuTX64aLbmTsbhSaQRT7jXKp4ZvPdTl/WpDdNX0AEvKL4dSQTjpB
	k8tCfTvNT6kTyW9Q3//rBAmeI/9fG58aTaOQS5lnGST8pWZgMfSyp4WSdsO7fQ7fVu/Rsb
	+1m13ar5u9Z6bdrgq5CoBA4XH6ZIztqnMG5w96syoXErlFOITdOECJ589fCPCTQ5woSl6m
	irxmROQRRBcwBUS4XklThWu07EVCmxbCgrwZVWja0vf4EMzSX+h6ilgqd12D9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=myl2TH41alCre5NE09vEruv/3VGqC7WlTNo5kaPmIss=;
	b=RyNH27L8tR+fjfkD3yM2uxa29jh9t6CYXhl4h8LcZ+LlPK1dCVysQA8e9W4Z0na+WSuZxL
	YLvHazTPRlfmwlDQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4: Make sure a VPE is locked when VMAPP
 is issued
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Nianyao Tang <tangnianyao@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240705093155.871070-4-maz@kernel.org>
References: <20240705093155.871070-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172104963892.2215.4356155837871772907.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a84a07fa3100d7ad46a3d6882af25a3df9c9e7e3
Gitweb:        https://git.kernel.org/tip/a84a07fa3100d7ad46a3d6882af25a3df9c9e7e3
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 05 Jul 2024 10:31:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Jul 2024 15:13:55 +02:00

irqchip/gic-v4: Make sure a VPE is locked when VMAPP is issued

In order to make sure that vpe->col_idx is correctly sampled when a VMAPP
command is issued, the vpe_lock must be held for the VPE. This is now
possible since the introduction of the per-VM vmapp_lock, which can be
taken before vpe_lock in the correct locking order.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nianyao Tang <tangnianyao@huawei.com>
Link: https://lore.kernel.org/r/20240705093155.871070-4-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 215c7ab..c23a64f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1810,7 +1810,9 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
 		for (i = 0; i < vm->nr_vpes; i++) {
 			struct its_vpe *vpe = vm->vpes[i];
 
-			its_send_vmapp(its, vpe, true);
+			scoped_guard(raw_spinlock, &vpe->vpe_lock)
+				its_send_vmapp(its, vpe, true);
+
 			its_send_vinvall(its, vpe);
 		}
 	}
@@ -1827,8 +1829,10 @@ static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
 	if (!--vm->vlpi_count[its->list_nr]) {
 		int i;
 
-		for (i = 0; i < vm->nr_vpes; i++)
+		for (i = 0; i < vm->nr_vpes; i++) {
+			guard(raw_spinlock)(&vm->vpes[i]->vpe_lock);
 			its_send_vmapp(its, vm->vpes[i], false);
+		}
 	}
 }
 

