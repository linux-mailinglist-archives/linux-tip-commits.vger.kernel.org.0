Return-Path: <linux-tip-commits+bounces-1327-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E018D7EC6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738A71F28314
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1098286277;
	Mon,  3 Jun 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="163kBzHa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0d6Jow0V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948B85C79;
	Mon,  3 Jun 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407015; cv=none; b=coxcPzrHs1jeiC/wrFdp9W0zsxLoQ5joOGLviPPGmXKIdk0Fqq+KQRtFXl2axn5/+SlzJXkn3jQy2kWx48MsaGZDWesfNmk1gDs5Fl1EruoWH0pqSS/NyUl2FuD6z1+Atr98rXoa3hGoZmFdQaunFKMWT91VoztQb0Q4aWwD1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407015; c=relaxed/simple;
	bh=xtqMtpGQrHB54uGZfp9VBm9z3YM1dzMnaqxTWaWCnOc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MQNG22Y3F+fSfmo3/5DcBzQYKu1M9S6TuXPvYddBhi31xV62bS2lNMFHM15ekz45MHqWgPqFwnxjfOiBndezuhMOc9L82oKt4LADTXoyDDbxSEn5d540+gNv1QRTG6VbOHajIiy9+qwmvFmwdmVFxZsBKj8ubI65k/sZY6n7L/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=163kBzHa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0d6Jow0V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeL1Q/NXa4GQb7N82Z1lfGHGwbb5bIh7X4xoJRM0NNM=;
	b=163kBzHa+bwALxPF3qQLOOkexShIkxR9W7mMAgaDqj4U+CpoYY5KFlhmUqFRRXl+vRVwdt
	q/5FNh69iifWHS3bKSykXF+/x0NapIxwv6mX4B8Q25ZGAyknSTuR72spFhD0b9IT84TRUJ
	iy1K32aBg0RNeSfICvmrSl01f8MbnAqQfGTAMG6SvoKu7BXpTDdBf9a/Q++OTe/ihEo7G7
	qCzLrkXgWRT2tyLqQrqqdBUWaTe18bF4a31OsjqZr6FH+6MFS7wampLHHj7xKDnAm4Vy/a
	PcUQpjb6ZpThrMG9oF3iZfHQTyL6szmMHZ8iM21CaewTXBVAP4+4EdVr9xvWXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeL1Q/NXa4GQb7N82Z1lfGHGwbb5bIh7X4xoJRM0NNM=;
	b=0d6Jow0VIwdl/arVtFx5saa6mJvToDdQRW/U+A1MYNkDhYht46V8VhtZJQ7NYtWJzsXD+T
	UoIpSfa0WGHMEbCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] e1000e: Replace convert_art_to_tsc()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-4-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-4-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700913.10875.14681974045180514880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bd48b50be50ac5678a7e26c39f6779d7fadf128b
Gitweb:        https://git.kernel.org/tip/bd48b50be50ac5678a7e26c39f6779d7fadf128b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 13 May 2024 16:08:04 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:50 +02:00

e1000e: Replace convert_art_to_tsc()

The core code now provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

Replace the direct conversion by filling in the required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-4-lakshmi.sowjanya.d@intel.com

---
 drivers/net/ethernet/intel/e1000e/ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index bbcfd52..89d57dd 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -124,7 +124,8 @@ static int e1000e_phc_get_syncdevicetime(ktime_t *device,
 	sys_cycles = er32(PLTSTMPH);
 	sys_cycles <<= 32;
 	sys_cycles |= er32(PLTSTMPL);
-	*system = convert_art_to_tsc(sys_cycles);
+	system->cycles = sys_cycles;
+	system->cs_id = CSID_X86_ART;
 
 	return 0;
 }

