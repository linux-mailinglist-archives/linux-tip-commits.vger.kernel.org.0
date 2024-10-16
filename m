Return-Path: <linux-tip-commits+bounces-2477-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7C9A133C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EAF282177
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0B218334;
	Wed, 16 Oct 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rFtbCGy+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wYkIG8rl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88F218315;
	Wed, 16 Oct 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109056; cv=none; b=jY3XjTqpsYqlZ4b3L2ZqvlSH/yLEBs1hLXFgRUAXIr3iN6G5/155RdIdK559YPgz3v5wtX2pezDYAplsbE7yqEj3ihyma/Xs8HmC8P86PR3EpvEvxCoVJvIoZiD47ku6CEm5+k2IgifztnU7AlLOFO35L1yL3MOk9nKHUdzWZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109056; c=relaxed/simple;
	bh=j0oPT/7tDv50aKYZ0KtAeBsijNzxiIK7WgyIU4FZIjk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bFSIhCY4T1Fe9kkvR4Bjew7/2P+xRaEOTP19Ds85+/NJ95fmF/55Eu97RsfjSbN0YQwgX1dB4o/wUwvhAMne5fFbYGf33UwzkRrSfHwJyz/N02kBRx0/eRoU3zoIyImnyhSRNxvqi+IVHuFYzZWXo1VmD2CTHR9XuWAjlnoQALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rFtbCGy+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wYkIG8rl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e183p8y047tVpavODgEWYRFFjXvaOOdeY15Xdzq48+k=;
	b=rFtbCGy+az+XH7qVWbMeETI+EzEoZh4hibfOsU/JM2VRnnJsR0GHedtfBWmn5JFbHrahyo
	Kz7Wr8KsOsUChce8W0ZjYCs99DCempCpwStPy1Z76Dnd+HufuqnySPHXMCQZambXLojv5H
	ufU3zRgvJDKUkQTvEr++9SdhOaCfYxtBpmXuq/DNQGtQit9J71+ShStR/ulNBbuZQnKfZL
	l+nJiKpTqOTuq9ckRAG3khcodvsPuYyLZodaq8qQdUgXeHVkTzwoB4pkFcLcE2QueU/eu2
	zTAoCpnUJqnG8ava5/D6cOgVl8PqoEYMmzC4D4gf345gDlcD0rw+BWB2fR0INQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e183p8y047tVpavODgEWYRFFjXvaOOdeY15Xdzq48+k=;
	b=wYkIG8rlW7aGHlKEDmTWN0A1RzUVuXubMe2prN4J5oy7iitEWIkW1olksrXw3tOk5jjLYY
	UtGXgpKt/pfSW0Dg==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] serial: amba-pl011: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-16-bvanassche@acm.org>
References: <20241015190953.1266194-16-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910905302.1442.7547198591855990991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d1a9a2f4ca62c35cc0ffab653241ef686a6a7526
Gitweb:        https://git.kernel.org/tip/d1a9a2f4ca62c35cc0ffab653241ef686a6a7526
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:46 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:58 +02:00

serial: amba-pl011: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-16-bvanassche@acm.org

---
 drivers/tty/serial/amba-pl011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7d0134e..1c60850 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2202,7 +2202,7 @@ static int pl011_verify_port(struct uart_port *port, struct serial_struct *ser)
 
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AMBA)
 		ret = -EINVAL;
-	if (ser->irq < 0 || ser->irq >= nr_irqs)
+	if (ser->irq < 0 || ser->irq >= irq_get_nr_irqs())
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;

