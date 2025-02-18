Return-Path: <linux-tip-commits+bounces-3481-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FE1A398E4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F06321882F24
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5FB244E8B;
	Tue, 18 Feb 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJRZw/46";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nfWAI/q7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13428243387;
	Tue, 18 Feb 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874398; cv=none; b=Z4euzD8wICtQonsHmvQmi3opbgLb/JY5dedCqunKgQsiD2mnaeSBHP8wzO6rqnSvFxC16fO25SjceTPuZKP37r7zQSBrhnpb65SebRdDuWVK6GXSG010qeOjmpwSjxT9qVx28oAm7Mre7Hjy/B4xnJoP58b9NibiHjP6HvFPj+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874398; c=relaxed/simple;
	bh=V7lx586Hl3Ew2XYDbdXcQD6Gvv6L1uXwerY28Q9wOMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EIRjeBtJYDzfGLI1Y95AGO6+g5czk1Qqc79r2/JzMoSIk7uSUpXYLVxop5OSCWjrLi61y6V6QfAfQovdoAh8JfLWiq0PEv7ArPkVMaWyR2lRgJ0bJBSJBHHRy8iefmP2FdbEnn/z0fp+t1ctfv/7TRhFJUCfwtC+OCbscBToohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJRZw/46; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nfWAI/q7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ev3Qa3CuS5lbwpANh06rf4DQ0Wcq/IPfl8xBg421nQ=;
	b=xJRZw/46jTQhp0V6EHGTfLA5Lp2toTXqQuZu01jQ+vjWD6V73hHaGE0bQ77UREwMo3YGn3
	VvCa098qKVLIfprwdImQJ033y+rfOl2enKwh0DCid9LipCz/fefRVpHrLPD5voL0Xjjepi
	oWugWAkig3KiRPXsYaZ2WAuMyg8ou8swR5tprjbglOAixg9BGbX28fq3BJRajLVkkP9r74
	+yIoo0b3Tqtj3Rc6eatcobA/EvtD8QN384z4iJLZo67vY8qIIAqCuHXfxfZBx7VtIQzBQi
	Li8E2uPVUoyrmVG8SPUV/yQ1mF1RwNEMwEwE4l+yNm422hu8CjfghAkUB8z3cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ev3Qa3CuS5lbwpANh06rf4DQ0Wcq/IPfl8xBg421nQ=;
	b=nfWAI/q7A476giBbu8emOL/3oNUo/N3StMiJ9+XJOnXUa9mlurFHuopzfOFzAk38qXZ/pr
	cWdeGwQ4qzCD9KCg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] mmc: dw_mmc: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4dec579387ced5e97bb25739fad2ac852e5a689c=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C4dec579387ced5e97bb25739fad2ac852e5a689c=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439520.10177.14655968456492402526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     3a1ed018e9950f49232600fd0d96d460e07874f9
Gitweb:        https://git.kernel.org/tip/3a1ed018e9950f49232600fd0d96d460e07874f9
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:04 +01:00

mmc: dw_mmc: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/4dec579387ced5e97bb25739fad2ac852e5a689c.1738746904.git.namcao@linutronix.de

---
 drivers/mmc/host/dw_mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3cbda98..31f40c0 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1875,8 +1875,7 @@ static void dw_mci_init_fault(struct dw_mci *host)
 {
 	host->fail_data_crc = (struct fault_attr) FAULT_ATTR_INITIALIZER;
 
-	hrtimer_init(&host->fault_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	host->fault_timer.function = dw_mci_fault_timer;
+	hrtimer_setup(&host->fault_timer, dw_mci_fault_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 }
 #else
 static void dw_mci_init_fault(struct dw_mci *host)

