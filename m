Return-Path: <linux-tip-commits+bounces-6940-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCCBE454F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC3D402CA7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 15:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939873570A7;
	Thu, 16 Oct 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bb3/Qw+m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gq7USqQV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB6350D5B;
	Thu, 16 Oct 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629601; cv=none; b=pT9SoXshzTatBaYl+6cEcMKxoRi5iYESzDdMbOxHvh0+5N/Aee9EtN01LdjdFRimA1Mlw359ttAe0cmSfrX700Cc62llvYKVJAtIdNdUCNKXc7SAxnk/h9u4h5QS47H60MSb2BfPPh40uzp/X6JEFKFE3br1058prfUnQ1+s3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629601; c=relaxed/simple;
	bh=3Y83iF4POwF0uDPvckFo5xxvFoCgZEH+OknoJdtr0xo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jnQTGjaRKskw9+L8NNJccVAQNnkUQIhlI4lff8Xj3xh0K443ZAoAJ5GOxXuCOGxT5q4WQXxcbj9cFpgV5G3hpC5byMavzltn5a5L6Lguy5P1USSlVreD2yUNIii7eSXOKHdDkFwKMnpgZ4X0MCNHj4ZAGnUV9V2fY0Nm2u7LEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bb3/Qw+m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gq7USqQV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 15:46:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760629597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjq7XkhVYkKU7XjsLdniAvSrl/xCcigWgttnf/r7jgQ=;
	b=Bb3/Qw+mI/OLSCuYB5cEbQRHTdUUaYMT/BN60RBx4Y1GhzX/OYhq87z4qjWT5xXh9dvWBB
	/9rj8ffN14YRgnUybgdMtfUHbbEFBdrnQJxTniMjMDukUaS6eLTzQqwprRVUU0pQlZ3x0J
	kbGL2ygZDmKowRhanWeCMstA8y6b7sUXC6eS+U4FtcHwI7hUKXmdt7w1+i96Hf8y/MFLko
	W2tkf4XmqmHoVk26WOZLTY7RufQahktKEG8gvUYAPKtyditoXNGGaxoW9e/6rvhY4Ztt6q
	tm0ZRHsSNpVFn8kGDGzoBtiUjjXQmy0/dRJMOd1/OrtZlYKKvid/YOjXQdwWZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760629597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jjq7XkhVYkKU7XjsLdniAvSrl/xCcigWgttnf/r7jgQ=;
	b=Gq7USqQVEX3TpkUUTIe/mxlqoToj5zN/ockTvw1ydPfbG24bpBM44qSQtTh8cWcFEAclk6
	EBaH6ud8sTX3zFCQ==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/ts4800: Drop unused module alias
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013095428.12369-4-johan@kernel.org>
References: <20251013095428.12369-4-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176062959664.709179.14661406350116777047.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     87a2a7341f669a6c2a7a9cd356429758ac23d848
Gitweb:        https://git.kernel.org/tip/87a2a7341f669a6c2a7a9cd356429758ac2=
3d848
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:54:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 17:26:35 +02:00

irqchip/ts4800: Drop unused module alias

The driver has never supported anything but OF probing so drop the
unused platform alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-ts4800.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index 1e236d5..2e4013c 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -165,4 +165,3 @@ module_platform_driver(ts4800_ic_driver);
 MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
 MODULE_DESCRIPTION("Multiplexed-IRQs driver for TS-4800's FPGA");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:ts4800_irqc");

