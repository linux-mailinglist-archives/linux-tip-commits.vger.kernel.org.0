Return-Path: <linux-tip-commits+bounces-3490-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5DFA398FD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EDD18977DE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A852D24419A;
	Tue, 18 Feb 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EDB7ulkQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5OHwEQw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A3E24BBED;
	Tue, 18 Feb 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874404; cv=none; b=M6ORQpezYPviuaNLLkxCUa+E7h71cAFsUxkK8atRt7V6PAaQ3BWON8pMZ9Egog0yEh9miWw7cojXuYOtB8fh9ECvATHPuPPNhhUlcZnpIKpw11xuotu1OoLJW/LdofcX7GZqRU2VRMCFChiQrNwvjXL8p3q4pDuDAyuSCecTKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874404; c=relaxed/simple;
	bh=hm0b4HrN/h7gh87hBq/UvO2Fcce8zw+8lb+LGIBiM1Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GRi9eFXx0yl25tQ3V7xCl1xUBuC/RuGTZi7SgAgxV6JSeeHIV+cwYQvqUBGOKqFU0AAidZxS1AB9q/WM8OPe/YbRZb6FvZdXSCmV3KP+85Hp4aAN45BbDpMQX4lY6Jn+BVJIuFiGewpxLb91gLVJkj6ZTK+Ovdd1HBkFKR/oHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EDB7ulkQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5OHwEQw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xIRTDFtn8drkTPoa+DXe2nzrLF9HOIbBQVFg/6E6dU=;
	b=EDB7ulkQFvMjKj5iKH/VRuIOh7sQgfEhQmrS9qUEfg7P1kRDbupoRfP0TWTRq+YBHtcOu8
	unRCkdtk9q6yT6ix/6qMgn+wxHLOX/a9WCMGAmBmxiRn+aWTD4Czn1wQohWVqDg5eG9gLP
	Jss5vrzgnbNBN+t3KNEeLL5uq88jQeGDAQ5VsbIEKKiWi2iUa/Rih+/aUVIlKi1Y/AffKh
	ECG8sr+tvh8LmfRXEW/gzToduRumfcDCZ1UXEiNeMluMl0fozVNyzNH0c+9iu9hfjxueS6
	NX/+7a9BSpQPxLEI92PZhkhXOxTl5Kj6fZXfXY91ylLaOQB8+9AXLzvgbneWuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xIRTDFtn8drkTPoa+DXe2nzrLF9HOIbBQVFg/6E6dU=;
	b=R5OHwEQw+Xpq6wPBdIw65bC9oocnsei5tOkIF6/YzrW2GYqmTAZLO9K0ZYt0lpwXd1FSQs
	57zp+nVtn0kMg5Bw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] serial: xilinx_uartps: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4a028a23126b3350a5e243dcb49e1ef1b2a4b740=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4a028a23126b3350a5e243dcb49e1ef1b2a4b740=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440081.10177.18370206598180763150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     0852ca41ce1cf1559764cdc7bf17c68e8042daaa
Gitweb:        https://git.kernel.org/tip/0852ca41ce1cf1559764cdc7bf17c68e8042daaa
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:03 +01:00

serial: xilinx_uartps: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/4a028a23126b3350a5e243dcb49e1ef1b2a4b740.1738746904.git.namcao@linutronix.de

---
 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 92ec518..efb124a 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1626,8 +1626,8 @@ static int cdns_rs485_config(struct uart_port *port, struct ktermios *termios,
 		writel(val, port->membase + CDNS_UART_MODEMCR);
 
 		/* Timer setup */
-		hrtimer_init(&cdns_uart->tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cdns_uart->tx_timer.function = &cdns_rs485_tx_callback;
+		hrtimer_setup(&cdns_uart->tx_timer, &cdns_rs485_tx_callback, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 
 		/* Disable transmitter and make Rx setup*/
 		cdns_uart_stop_tx(port);

