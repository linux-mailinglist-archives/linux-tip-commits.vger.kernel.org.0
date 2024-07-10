Return-Path: <linux-tip-commits+bounces-1671-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C092D6C0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBA8280A94
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0A0190472;
	Wed, 10 Jul 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VtmD9CfX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nx4AwQk2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E4257D;
	Wed, 10 Jul 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629772; cv=none; b=szfJo5UTyAB55WFPimNgnYOR4Y+/SEqiZy7FOrCyXtMYGabJMDAxHwxUGZvbbnUrZRwf0Xq1RsYqr/q77zYdKyQEPYa4j48TvC/cnzsvTUPLv2kHqZa664UwpfEo2dRssDmZRIO66X8kz29vH1upL/96S9GPk6Qhm1Ewkfc1Sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629772; c=relaxed/simple;
	bh=/1oWCfIvJFjuRn9+47gvJnacFQlwfqKD1dnUe/VlJsQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NYcvNMkhbkX9cEH2x5L+zQT98KU91taD5qpQ3j1sRl6IXnllQe0d0TO0kTIr96eCSGr32Uz+uNtVVsA31rOnx3qMyL4x1WRIfQ5eUBW6APIkif+bDjaz6h9VaobM62gQiWX7DNOcHaQnluvTAE0efgxa2r58OY/pmcJ52/BW0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VtmD9CfX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nx4AwQk2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:42:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720629768;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvvfRNj1fyA+nVzATmN6LnFP0ryqwfakowdbEXD88dk=;
	b=VtmD9CfXPjBsVMRkf5k3KdlFs9GcD59nAptvs/o5tv/ntP6SxeOjVS3OX+hxA4dfMNF3Bx
	msk3o5l359ay9c/zUuiA10whgFFHdNiyhtghRsKgQ5UjY54R45jytiVICrEOUiNxhDPOMs
	yH2vcUkCyJDBQIH0c1pAEGHNbdLFM+OuX7u6Ukb11Osd+sEbxss6PaQFI8Of/kMnq5M8A/
	I23ZXMFHVf2pyTS+EPtpg6oH19pJsX2owznrvEBSIjLhvyZ+2dAUFSwVAsJ1+P4ninCbV4
	pcM71T5hiWbxB8QO9rLAc0K63anzkXx/R8sJm2u/hSuaz/eoNlauZuB1AV9whw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720629768;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LvvfRNj1fyA+nVzATmN6LnFP0ryqwfakowdbEXD88dk=;
	b=Nx4AwQk2OztmGSQ5W1YRXfLhzV/MGOaKvMRm6hcbhmLhYXFc/DsIqx7VQHiYD3m0PuzwKB
	jjAEYuM0FlLR47DQ==
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
Message-ID: <172062976827.2215.13751837315425176918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9fceb7a5e829e6c8de4f018b4c37a5a3a4504447
Gitweb:        https://git.kernel.org/tip/9fceb7a5e829e6c8de4f018b4c37a5a3a4504447
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 05 Jul 2024 10:31:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:40:10 +02:00

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
index c85826a..1a97391 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1811,7 +1811,9 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
 		for (i = 0; i < vm->nr_vpes; i++) {
 			struct its_vpe *vpe = vm->vpes[i];
 
-			its_send_vmapp(its, vpe, true);
+			scoped_guard(raw_spinlock, &vpe->vpe_lock)
+				its_send_vmapp(its, vpe, true);
+
 			its_send_vinvall(its, vpe);
 		}
 	}
@@ -1828,8 +1830,10 @@ static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
 	if (!--vm->vlpi_count[its->list_nr]) {
 		int i;
 
-		for (i = 0; i < vm->nr_vpes; i++)
+		for (i = 0; i < vm->nr_vpes; i++) {
+			guard(raw_spinlock)(&vm->vpes[i]->vpe_lock);
 			its_send_vmapp(its, vm->vpes[i], false);
+		}
 	}
 }
 

