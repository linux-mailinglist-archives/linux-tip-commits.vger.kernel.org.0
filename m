Return-Path: <linux-tip-commits+bounces-2480-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014D29A1344
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA901F223EA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42E219C8E;
	Wed, 16 Oct 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ffEE9ag9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yrrh3JrZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F38219491;
	Wed, 16 Oct 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109060; cv=none; b=jAxxuEOGX0QojOqWXwtE/atPVxP8c0XNsgZmLPzV/PlMwE8PW9RgNd/5FgN82JJw7E/qdDI3IKiY+YAsbnlcsozGHlWsolhkJPDofHjQQ/aKODNx2ceZ0goGwqKtNdqoAKxiJcX3vcqQ9g+d/w9H2JHEa4zVJg2zgebd7IWwkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109060; c=relaxed/simple;
	bh=lAxk0xXgG2agR4mnUlTzV0g/QCYV8WgfsufdaJI0yas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M3eC4IkTtmU7LKD6eBfAUzLP0a4xAqnqjn1nWbAJ3WbCGHonrpyag2Hr7cNAj7wPBcOcGjItcNdQxL6adeYss7q2iAPJlLcAltD9Gk5thWIWZB56wxb10kCCoAwgl4JvUIZOPQc3vHsftEd7X5zOMqhptGDkNSqq+DinsbVexi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ffEE9ag9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yrrh3JrZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LZIEUwPw1L8c71huEZcWgntBUIuCfQWrsLdKZFQ4Og=;
	b=ffEE9ag9vXtPtRwqtrtseGysXJ20t3MMxencXG9nI0l2mOHdEyMB96sJEP9LV2QoK3mCFZ
	7e5Wx2luQtzU+H/ETOPlZcGUS6pOK9DHBBOS0rtpk1M+w6zBYuVZccVkE/ceS9qMGs6W2U
	ArvTwmf1c/WyE4IHHywOHnSDh9cSA1tOawL++L7qxFToPwA4VG18Ddy9Jh3gBlSBIwMPCA
	/daF6wzP/DmRiJGtzzpZNjkysxN++ciX2NxfH7neomFRkaSI80EsPMdYBdrK8PV2sh2NaG
	y5UCDKeM76r+Riu7UCPDYzyhTA4+UllV9YqrmzuFXI0Q+ZMF3b9BluCG0bjmTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3LZIEUwPw1L8c71huEZcWgntBUIuCfQWrsLdKZFQ4Og=;
	b=yrrh3JrZnoR82GJ/nqvDvLXO2WMz27IaE3icykgyk/zZDKKZ4+/ZHJg3smFkTdb07dMmrw
	b7xwbj6j1DxXi0Dg==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] serial: core: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-13-bvanassche@acm.org>
References: <20241015190953.1266194-13-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910905644.1442.12506879975397264238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5732a63bada9923b4edcf90860fb8697d7c1231b
Gitweb:        https://git.kernel.org/tip/5732a63bada9923b4edcf90860fb8697d7c1231b
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:43 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:58 +02:00

serial: core: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-13-bvanassche@acm.org

---
 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d94d73e..74fa02b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -919,7 +919,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	if (uport->ops->verify_port)
 		retval = uport->ops->verify_port(uport, new_info);
 
-	if ((new_info->irq >= nr_irqs) || (new_info->irq < 0) ||
+	if ((new_info->irq >= irq_get_nr_irqs()) || (new_info->irq < 0) ||
 	    (new_info->baud_base < 9600))
 		retval = -EINVAL;
 

