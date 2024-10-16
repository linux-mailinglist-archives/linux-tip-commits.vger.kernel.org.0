Return-Path: <linux-tip-commits+bounces-2478-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333CB9A1340
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14961F2208E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF4A218D9B;
	Wed, 16 Oct 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VMDi7DEE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMRIrC48"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54B218336;
	Wed, 16 Oct 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109058; cv=none; b=k1mSIdHvRfO1F5Tv7DHlPwkjEu1Xyy2qRCoyI8FqzxpnTZ1R3sWRmMi+eGgaQUc6MLDE4UpkPJgyQ9+piJovh/WXLCARrubdOtCjBXmlCtBP1zT8U/1Mu+s5GZUBHdwJLBL+340KfMrhARiYYoalXdQqOt5I/uabqtkH9J9uwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109058; c=relaxed/simple;
	bh=PiOPwbcOWoyEHjZUUPqjceB1K09WTDrHjl5ikpUliVM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dUJDUT6J8KW6NoMyRrgEqpY9MAmY09tqSwPpOg1VNlkM/hszdl/++zw3nBojpxeZia3Ulk4YF1bSGHhmAepbXgBizI0Z3rp0dmCxgumFA5Svf6t/8+wJ5x37Vb+qrxCGErDDPnQwYXXH7R54Ad5HnFWnwU7mBn4tdMlAOuw0JzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VMDi7DEE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMRIrC48; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8enSnDROvNXJ+YKcz6r0Trl8+xG9DcaWrmxtsO4VQ0=;
	b=VMDi7DEEoo9VMJrM0AhzW7GAvCvXA9ikMJIoJ1cjS+tXqfNorqPh/Abt49U+xL73VkbzjH
	FkdRxDKv2r1XIkmdj2zkYYpGY6CDz99KiIbu4YQ2IKAn3bF4o5CQG9J7NRV75rbLci/Np9
	xMTr/WHbz3+KQ0cz7icisXsNwj+IQRZedAgT5+HDEp5pv8MIA1WJ3Mbtuuc/7jHmNdbjgv
	UAL0W5DTzYofBK6Llw0CVKjfODF2ePr0DuKVbbWfK9Hc1s3n7xFC7DvW+N9v1f44mYO68g
	CP9KMgKwtnDuGExVIwO+nV+JYh1eKciq9bt405l2DpzV9WD0aCYvt5UkV03IvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X8enSnDROvNXJ+YKcz6r0Trl8+xG9DcaWrmxtsO4VQ0=;
	b=uMRIrC48Sa/EuPP3aPeVeEJ5UZ0NRfzrKcE6pt2xQL9Nu+iDBtrDbttDHY6J/N+GT/avv2
	2cc2nlx9xiMi7SCA==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] serial: amba-pl010: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-15-bvanassche@acm.org>
References: <20241015190953.1266194-15-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910905397.1442.5386444123693884383.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3905fb8738ca3474982a4d230e9493a409837388
Gitweb:        https://git.kernel.org/tip/3905fb8738ca3474982a4d230e9493a409837388
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:45 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:58 +02:00

serial: amba-pl010: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-15-bvanassche@acm.org

---
 drivers/tty/serial/amba-pl010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index eabbf8a..c3a7fad 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -499,7 +499,7 @@ static int pl010_verify_port(struct uart_port *port, struct serial_struct *ser)
 	int ret = 0;
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_AMBA)
 		ret = -EINVAL;
-	if (ser->irq < 0 || ser->irq >= nr_irqs)
+	if (ser->irq < 0 || ser->irq >= irq_get_nr_irqs())
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;

