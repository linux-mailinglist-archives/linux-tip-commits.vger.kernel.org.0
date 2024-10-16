Return-Path: <linux-tip-commits+bounces-2481-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2688A9A1346
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5947E1C21DDF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A135219CBC;
	Wed, 16 Oct 2024 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QZquNkHK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+CJj7Dcq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3A6219C91;
	Wed, 16 Oct 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109062; cv=none; b=ZFbYib5M0GLDgurvY1eD7MINxPy40nf1vFhtUpwVXjUCq8n3ApBmixaDa0CkBJ+6MssK5h6YHnPj8h/u42Zctk5gXN/iNnDEJGQ0+r/sm2/cyTtig4KCzQbHNNkgY/+B+3tSygpWuK+OWV0UL8WNuWgz/oGNgY8x5eVAg9qMah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109062; c=relaxed/simple;
	bh=TxoAPmXtV0N320YDlCrTz1ts4J61Pgh1ov5avG/7t8Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pjACK1Kz9xFmACSFBGtaiXnKEyjR7gxvEBFjUiHKjM3tyi8KEYlIslzI7ecR7axYxtCKXj2T28Z4lwcYDzsI2f0p5yBjDTr+SdvgeOinBLTdznB04vfnx67cxfsXyDp99sB4DywUUBSHdx5bNcl0qfIZGdFE0ahsMbxYaFZTMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QZquNkHK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+CJj7Dcq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+y0gIiRgEHHcoxQUHrIsdimaAcx5PwvGHyVYDlVWk=;
	b=QZquNkHKaFbksLEUjYKJOQK/bnTGzeN5atn8CUNzMbjo8f1PYbf+uW8+EP+LYacI13xXUv
	aAnsyxHUdAoDru70isWNbZb/eK/Y45OgMRmzgFZx7g91OG4VcD3D+oWy0cqp3D+Ee3jbEp
	2H/Zc2zgpPVJrH1fGZH3w38rGCWzxgG32GYYQu8WLmPaUtdiMcWSMRrJpHNuyh+yP9HKiA
	TtDxWKc4hzO2DoIvp6erOoL7sEovjCiVM93FwHFlVaVw/5h1hj5qAy7la+Tk7qDZsmVAEw
	X7L/kZRGkjqGLvnUOyxWEIQPacz7K93x/ngMs9bnKxKoA1xrCFkSl3YOlwxHOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mp+y0gIiRgEHHcoxQUHrIsdimaAcx5PwvGHyVYDlVWk=;
	b=+CJj7DcqloBF2NbjGkGkb0A1wUcujbiZeHLflAr7Usw2pzVMFV8aj1DNuA3hr5SBL7Vhm2
	dB5uUD7uctoJ1NAA==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] scsi: aha152x: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-12-bvanassche@acm.org>
References: <20241015190953.1266194-12-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910905733.1442.12473133893885291547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     03f039def8332fef5efd93795291ad13cb187d65
Gitweb:        https://git.kernel.org/tip/03f039def8332fef5efd93795291ad13cb187d65
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:42 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:58 +02:00

scsi: aha152x: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-12-bvanassche@acm.org

---
 drivers/scsi/aha152x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index a0fb330..4276f86 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -295,7 +295,7 @@ CMD_INC_RESID(struct scsi_cmnd *cmd, int inc)
 #else
 #define IRQ_MIN 9
 #if defined(__PPC)
-#define IRQ_MAX (nr_irqs-1)
+#define IRQ_MAX (irq_get_nr_irqs()-1)
 #else
 #define IRQ_MAX 12
 #endif

