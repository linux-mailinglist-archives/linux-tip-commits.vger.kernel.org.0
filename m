Return-Path: <linux-tip-commits+bounces-3523-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC76A3A358
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45BD1891213
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 16:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4D126FA4B;
	Tue, 18 Feb 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dMGVLeKL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Co+MejYH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC3126F460;
	Tue, 18 Feb 2025 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897866; cv=none; b=kIzUBEOr25vpK54tnBTIi84MCreWEGzX55hvVJXUYRMHz+5MzfF6BdBJaocG/w5duabEmUT/KcNB3tg0hCvKFQ4D1LPRygtUO5wSYS9xITgEew99cPnIgAeWUrbi15kwoVeGjRLpp+npT05ZSgFQXVCYImBFLanXDcjnYvZM8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897866; c=relaxed/simple;
	bh=oyqzA8Xd44P0ljrLs8wNjVBJiNsX1f5Bj+77HNozeGc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bMt3wT89OYwDFnXSYZdyV2RVQUg12/c5klXLN8ht22m8eNz+TmTg1JpqLRH7fE3R/kqXv01biquxm7bZ7LXIIAemydZHdJLs9Qzr4J2CFwYowo/vC3pqNOSVmFf3hShb2febhZUYSTIgd5VpdTcmyVPWt0RmdSbHnW83QCSys1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dMGVLeKL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Co+MejYH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 16:57:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739897863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfvPDKrXS4KCEfF9dGsZ+6TWqt9pSJK9cIlX1OwUZiw=;
	b=dMGVLeKLFcP0mBPp4NrfqQyI7h798AW1PHGiMnoLRcZFgeYmpI69COFh30rWYlWdmLcUnS
	jNkWZJISpM2e38+i2n/9kJhm5SQ4L4EazQLgDZk56OeFbLc5Mp3pgEUGVKyF1BtYDl/Joe
	zBJgeQuhDdPG5RLMSljtc7mj5m7rFoMZYHglWcHyfyl9xUpbzla/a+c3yL2R/UekksZX0L
	CZYM3QtTNNQt0QT+Alu+DNIuEOmEKD6tvWJyd6ietZhDJBUD0za81RSBqr+5ZS3RuQtR+l
	yYxtC0mKj6Al/KrlfU9/MQ+QlNGADLt9+hLkbwBDCrIGX4YHWPOpFIfa54C6PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739897863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfvPDKrXS4KCEfF9dGsZ+6TWqt9pSJK9cIlX1OwUZiw=;
	b=Co+MejYHfSyP38OF690ATyzFEQJxGprnIpLrFJTn7KEo8ZXI6OmEupZ/F8ePYcdLecoJyp
	x7CNS2Ho49cesmCA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] serial: xilinx_uartps: Use helper function
 hrtimer_update_function()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Caf7823518fb060c6c97105a2513cfc61adbdf38f=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Caf7823518fb060c6c97105a2513cfc61adbdf38f=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173989786241.10177.5773540237425190718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     eee00df8e1f1f5648ed8f9e40e2bb54c2877344a
Gitweb:        https://git.kernel.org/tip/eee00df8e1f1f5648ed8f9e40e2bb54c2877344a
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 17:41:35 +01:00

serial: xilinx_uartps: Use helper function hrtimer_update_function()

The field 'function' of struct hrtimer should not be changed directly, as
the write is lockless and a concurrent timer expiry might end up using the
wrong function pointer.

Switch to use hrtimer_update_function() which also performs runtime checks
that it is safe to modify the callback.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/af7823518fb060c6c97105a2513cfc61adbdf38f.1738746927.git.namcao@linutronix.de

---
 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index efb124a..fe457bf 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -454,7 +454,7 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
 	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
-		cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
+		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
 		hrtimer_start(&cdns_uart->tx_timer,
 			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
 	}
@@ -734,7 +734,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
 
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
 		if (!cdns_uart->rs485_tx_started) {
-			cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+			hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_tx_callback);
 			cdns_rs485_tx_setup(cdns_uart);
 			return hrtimer_start(&cdns_uart->tx_timer,
 					     ms_to_ktime(port->rs485.delay_rts_before_send),

