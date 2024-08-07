Return-Path: <linux-tip-commits+bounces-1978-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2B394AE04
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEA82844B7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB813C693;
	Wed,  7 Aug 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qaiF+ypM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FfmoFWQr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D913A3F3;
	Wed,  7 Aug 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047931; cv=none; b=AxiB9cIcqiurE544uUU+J/pSly89xtFTt5VVlf48eqGy+EUDarXa94OZdHYB4w5jYhW5Pq677HeyaRpm/Iz+xxMHDkEF73vSYRKR6jmUyUch3fsRC9yohDmueTY1jm5PTMTamXYJLY+lYjpm70dk7ruSDdS/R2zye58MedbQXx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047931; c=relaxed/simple;
	bh=ZEVi3sZUukVnYaj1crtY+u7TigDEanX+q/lhyoSzako=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ubdZcUjtUR/KUkdW1ODRTr3+BqxHOS/oZCwNZswGCHWMdoLSjLLb9jan+8hFwxjNPp2SQbazdBxhzByo/syzAsILWnRX8zPIhhF5XVbvmzNaydPq2GtBD0CxbAs8v4PLA+Pc2PdwccW2FTqvL/k7CrSC2gRUvLAURkOh56VXjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qaiF+ypM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FfmoFWQr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 16:25:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723047928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwGmRVnO0DaHq9n3XhIQml3a7U8SIIo3BzpSwB2WIho=;
	b=qaiF+ypM7sqMXQnPpu3GBOuRAp853xVv52a0z8eHgYemvkGlJfzVRWcxPUFzcRnEoeIBqX
	2QUSyNHIQhi7nU69wN2/89ZJ79vtp9N7dBAsHpBPbWALhRRpQb9j1ilOebnCNNnbjqAQ2q
	xkDWEy1kwlxvUoTDdyjk+mmPuJZBkviGp4hNWqEn2L8tU6lafLazhNLGHhxOGLZ1OcHx8t
	y7BeuDLYV8CaTGe4QqtSFCAyaEKTyYwr7TkLuR6KgwI91xjhR6KB9835RvuDNuBWJI3pNl
	1qqOzKBNmk6y39PvQLQwXAByNCx0EjNMxrMCWeufqwEoWdqe+T+JDSG2113Mbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723047928;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DwGmRVnO0DaHq9n3XhIQml3a7U8SIIo3BzpSwB2WIho=;
	b=FfmoFWQri4uhioPfIHx6SXG7S15IHc34a2/VW2Arn1VjOEvvOv+k5VQgOFS0ek5t3VKHlU
	zU+0nuCAGE8knqAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/vt-d: Cleanup apic_printk()
Cc: Thomas Gleixner <tglx@linutronix.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Breno Leitao <leitao@debian.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802155440.843266805@linutronix.de>
References: <20240802155440.843266805@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172304792769.2215.10738538971676709893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     48855a2c92203389cb215c86ee3d2f2df5aa4024
Gitweb:        https://git.kernel.org/tip/48855a2c92203389cb215c86ee3d2f2df5aa4024
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 02 Aug 2024 18:15:45 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 18:13:28 +02:00

iommu/vt-d: Cleanup apic_printk()

Use the new apic_pr_verbose() helper.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/all/20240802155440.843266805@linutronix.de

---
 drivers/iommu/intel/irq_remapping.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index e090ca0..7a6d188 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1352,12 +1352,11 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 	case X86_IRQ_ALLOC_TYPE_IOAPIC:
 		/* Set source-id of interrupt request */
 		set_ioapic_sid(irte, info->devid);
-		apic_printk(APIC_VERBOSE, KERN_DEBUG "IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
-			info->devid, irte->present, irte->fpd,
-			irte->dst_mode, irte->redir_hint,
-			irte->trigger_mode, irte->dlvry_mode,
-			irte->avail, irte->vector, irte->dest_id,
-			irte->sid, irte->sq, irte->svt);
+		apic_pr_verbose("IOAPIC[%d]: Set IRTE entry (P:%d FPD:%d Dst_Mode:%d Redir_hint:%d Trig_Mode:%d Dlvry_Mode:%X Avail:%X Vector:%02X Dest:%08X SID:%04X SQ:%X SVT:%X)\n",
+				info->devid, irte->present, irte->fpd, irte->dst_mode,
+				irte->redir_hint, irte->trigger_mode, irte->dlvry_mode,
+				irte->avail, irte->vector, irte->dest_id, irte->sid,
+				irte->sq, irte->svt);
 		sub_handle = info->ioapic.pin;
 		break;
 	case X86_IRQ_ALLOC_TYPE_HPET:

