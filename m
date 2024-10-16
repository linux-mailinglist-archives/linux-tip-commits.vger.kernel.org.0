Return-Path: <linux-tip-commits+bounces-2475-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1299A1336
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05911C22132
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E43E218310;
	Wed, 16 Oct 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ysDzyQ7n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fjcXCs7g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674D21790E;
	Wed, 16 Oct 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109055; cv=none; b=e7WBi6hIVx1mE7CSktqJL6Xqq5WI2zhan0McFH915R2bLalaOULJw+CLpWDCjg5r8tJXLHxNW8FIAWVSsJbcHN7bBcHrPUIp9qCpr5BTTwGl3I3DteHTy1IUilA36/Zh7LOBgykt4T8iMuhD6ypx9dojbDXqsiRZPk2UI5ddDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109055; c=relaxed/simple;
	bh=YCW/FyE+MEXnRy3cSC+2HQBPf+XdeDH6a3SYFAG2da4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u4Y4es1wfgnpgVbEqV6jzvURS8xgXUlTEoHOJRTh46EgojLltWnmB9q0SMOQHooKfMRGdKOXVMw2TjIz6QFhDUC00h9iUhn6KvobCDQGLRnZZWISu19NAmtNzvKvyb4smt0+mIkrSDoR+TNdCYc/hOWUxQH3TvSC45rWnDWvQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ysDzyQ7n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fjcXCs7g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcFedrqDkI8wwFZDW/dBfDngudHE5n8mPyXdsi0rbX8=;
	b=ysDzyQ7nGsy64MHrsgyBMCYD2YmVWnh9XJlXDi3lGDyoecg3PMK+KY805Qe2lZdc+QuhxH
	NFWqgWMCtpwTuny3jQDVlWl2Kv4jxgR1ovOZypx38P4UO9zsuuDuxw+oBy1GpQgw+8UjQU
	G5brtAQslD0SKq04rFulSufBuNYrerpN1NrrtvVQyV2mWsE278DXICZy7CvIWUKVgIencH
	fNsHt1gIuzEpx5v+/5cWI4QGQ3f5oS7bPoxeNjgkuW09yyRIPYJsSDw6axZHZBDkHJ/ZH9
	y7O2113cznERAfIH9J9NoLOrsPFWjl9zc3LmQBeVeKSp6KB9t56sFqMmUxPDoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109052;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qcFedrqDkI8wwFZDW/dBfDngudHE5n8mPyXdsi0rbX8=;
	b=fjcXCs7gMXD+JgZj2xS/9JgvKKXcCA8JhkQEdAL6iaQEXsCpAxT1XF4MqaKxQ1+t0sl6WS
	NH3xU8TZzpcASvCw==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] serial: ucc_uart: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-18-bvanassche@acm.org>
References: <20241015190953.1266194-18-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910905110.1442.4954960197604665168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     18444d339914a6080d832d9e8998ec243f7c3e9e
Gitweb:        https://git.kernel.org/tip/18444d339914a6080d832d9e8998ec243f7c3e9e
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:48 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:58 +02:00

serial: ucc_uart: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-18-bvanassche@acm.org

---
 drivers/tty/serial/ucc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 53bb8c5..4eed909 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1045,7 +1045,7 @@ static int qe_uart_verify_port(struct uart_port *port,
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_CPM)
 		return -EINVAL;
 
-	if (ser->irq < 0 || ser->irq >= nr_irqs)
+	if (ser->irq < 0 || ser->irq >= irq_get_nr_irqs())
 		return -EINVAL;
 
 	if (ser->baud_base < 9600)

