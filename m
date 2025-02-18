Return-Path: <linux-tip-commits+bounces-3480-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053ADA398E3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DFE1897238
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968C2244192;
	Tue, 18 Feb 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r97MS0tU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NWCsw01A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1426235361;
	Tue, 18 Feb 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874398; cv=none; b=psFPTv/J1tUUoFqZD+Wf53giHSJhof7ZlE5yRGaiSjAmKvXvIurV5cWQZ35nSgsJUe4rlJOlHLcOKAr7oNYs5OS6T5Z88iiMWhJaRuAcgBfRLWS1tCmAo+5NAuU7Su02BIAbXk0bbTeXf+5RNRCRE33I6PK6JyTXABRBGOAY6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874398; c=relaxed/simple;
	bh=U5g0NhHlY4bhLTF7RLGyxZWEP0azG00p3ca4FS6HB90=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jf6u89mUtm4lZltwsoIVkTaG2Z94VKj8/Al5V3Vv5fKXEXEA2tLexyysePcovzWgV97OKY5wfAvCP60V8mTeOUAjO7+dmmv1/8Xq6l6H9ZXef6vrNajTLVfwRtGnqkVdSC6H8YOURR+vx/8+x+xGop2Om1R4TUrJuwabXlpf6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r97MS0tU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NWCsw01A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2sz8mWyPbcAaLmLbcR7XB2qiApREMFT6QY3OmtaG0g=;
	b=r97MS0tU1UyCUcOXCBMfMarqrFgkqtz1L8sMF0MN6n86g+fHxsjBHL+9V9UPMYMH/8ZzmB
	r+F8u1EN9drnD8CBpp+IeKRLgqoke2LA2HjSJSw8Y/lskuOgkd7Vv/Eih6YFUQxIkeh/8Z
	RM3h2P6XvKHUcwY4DJZpBb/ESsun5UZnI9uPcS2ahu/ubVdTD9LaKFpC2Ry6qlTRyw1ywf
	ktXSteCt+Bo1jhHXMR9kb+VSibBuME6vtmfc1T8gxwiEYZqzKuw/T44blawpEPgQh7rmsY
	YOy2f68ZoiHEkCNueXipcSQgKM86vWcG0LXQTaRxgT4sVyY0BYvWyJhRrcBFUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874395;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2sz8mWyPbcAaLmLbcR7XB2qiApREMFT6QY3OmtaG0g=;
	b=NWCsw01A743EXIP6MgYmUgfiVbk4edvL2llisDjbx9aXa1jQcUNuC+9QVrUplvDmv0izKp
	TtCfGm4bofi6WDAA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] misc: vcpu_stall_detector: Switch to use
 hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca1c984288c6e47d956c07339ced486a8ec95f8d5=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca1c984288c6e47d956c07339ced486a8ec95f8d5=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439454.10177.77590937026959584.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7f657ad0948257d131bca6953b3b553fe9f238d6
Gitweb:        https://git.kernel.org/tip/7f657ad0948257d131bca6953b3b553fe9f238d6
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:04 +01:00

misc: vcpu_stall_detector: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/a1c984288c6e47d956c07339ced486a8ec95f8d5.1738746904.git.namcao@linutronix.de

---
 drivers/misc/vcpu_stall_detector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/vcpu_stall_detector.c b/drivers/misc/vcpu_stall_detector.c
index f0b1fc8..2616635 100644
--- a/drivers/misc/vcpu_stall_detector.c
+++ b/drivers/misc/vcpu_stall_detector.c
@@ -111,8 +111,7 @@ static int start_stall_detector_cpu(unsigned int cpu)
 	ping_timeout_ms = vcpu_stall_config.stall_timeout_sec *
 			  MSEC_PER_SEC / 2;
 
-	hrtimer_init(vcpu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	vcpu_hrtimer->function = vcpu_stall_detect_timer_fn;
+	hrtimer_setup(vcpu_hrtimer, vcpu_stall_detect_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vcpu_stall_detector->is_initialized = true;
 
 	hrtimer_start(vcpu_hrtimer, ms_to_ktime(ping_timeout_ms),

