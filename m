Return-Path: <linux-tip-commits+bounces-6855-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 626E9BE2846
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECEB84FDA11
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D275C31B11E;
	Thu, 16 Oct 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJ7YB8ia";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s5XOdXAR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205831B12D;
	Thu, 16 Oct 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608326; cv=none; b=d9welNUr060QJXqwwwRSkyS8w1DIuQ2GYoI5VkCQnAeXl44ykpHwVgYcR43TFvgVR2jVZCqHknycjZsZWcfh/ME/Zu+48NQ4Fh7rBPe19GFRy00rzy60+bzSSny2MTe1mL3Gui55fpug7d0y1MZOc3jTIIx/WjD//1ZBpJFWwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608326; c=relaxed/simple;
	bh=2HDOX8YLAA0LsB1liRoJXaWuzALMRnZM9SH0JSMfGOs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lkqPmqTeENAGL1EVzOkNiQ9pyVg/a0hCcfwx2inDs5tU1dRPHUYxk59GXj/iRhmr9T3wUydMMNI3U8B22I8djFjgFOsRwK6fk4S+hM5n5vX/o4THkPQ5AVJ02q4F3XCBUkXyoAkwFNWkaZaCs+ZBI26EsvsnBAQkhmjoA9ayfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJ7YB8ia; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s5XOdXAR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI+J+SHget8HotCDeosAQgdvcKfSPjujAkTp0+Mt2gQ=;
	b=MJ7YB8ia9kyEGJEEGQXIQ3HYIbtoVoNDL26GmjLkVvItiSzLWqaRdwgTaVlVw0OW9U6ryV
	FvVCtMgW2AeIlcgMK383p4ZHe+mBd7TBD2fevN65sNjZzo2WjNT9VVDAzUnJn/1f7HJJ7Z
	8rxFyBZzOK/Y8O+zYx/7EJ/eglvdXwJ3hCA8/imEi3dGCjvkJDsGME5O/kaCzQFmpAmGVJ
	ZyLqCo9T+QsyrpeDgfMKjJTOWMOUThdgNR9iG1byrvD5VRqvNfmB7Xs3PjExITTBmu7efu
	UxIWJij7poPeZNBGwMHCsivTiLMn1rczwIDXnaeGb4WSfkAHId6otj5e5QpMlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608298;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dI+J+SHget8HotCDeosAQgdvcKfSPjujAkTp0+Mt2gQ=;
	b=s5XOdXARY01cv80gQ3FZ2x+znbaAGpigXn8aviV5vZgP0R7/pD1qcCueLMshEh/f3EEnqC
	/PhxPoSYgRGdAPDg==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzg2l: Fix section mismatch
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013094611.11745-8-johan@kernel.org>
References: <20251013094611.11745-8-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060829664.709179.3855779268746550942.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     5b338fbb2b5b21d61a9eaba14dcf43108de30258
Gitweb:        https://git.kernel.org/tip/5b338fbb2b5b21d61a9eaba14dcf43108de=
30258
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:46:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:30:38 +02:00

irqchip/renesas-rzg2l: Fix section mismatch

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callbacks must not live in init.

Fixes: d011c022efe27579 ("irqchip/renesas-rzg2l: Add support for RZ/Five SoC")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 2a54ade..12b6eb1 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -597,14 +597,12 @@ static int rzg2l_irqc_common_init(struct device_node *n=
ode, struct device_node *
 	return 0;
 }
=20
-static int __init rzg2l_irqc_init(struct device_node *node,
-				  struct device_node *parent)
+static int rzg2l_irqc_init(struct device_node *node, struct device_node *par=
ent)
 {
 	return rzg2l_irqc_common_init(node, parent, &rzg2l_irqc_chip);
 }
=20
-static int __init rzfive_irqc_init(struct device_node *node,
-				   struct device_node *parent)
+static int rzfive_irqc_init(struct device_node *node, struct device_node *pa=
rent)
 {
 	return rzg2l_irqc_common_init(node, parent, &rzfive_irqc_chip);
 }

