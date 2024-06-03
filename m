Return-Path: <linux-tip-commits+bounces-1322-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035178D7EBC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B305A285A33
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187748593D;
	Mon,  3 Jun 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hpaSHvg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbkHnkWZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1598592C;
	Mon,  3 Jun 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407012; cv=none; b=Uguc6nVJH7jXSg+acY5ooCesGkZORXFX6/jxr+M6iq++SBK+ieasfRPXy2pZ5VxocYlfcLRl9TYiu/YwvP5NJLU2ff6WRHNMgAdGr5ZHUA3j8jYd9eHaPEqI3OGT15HEjLdqW6qczl3mOplJxZwweC2y8luk1YN2MnYMB7IcLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407012; c=relaxed/simple;
	bh=HhuIosCNoexClEssSxNK79UUt256uY7hhE51/TFdEKc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gf9SkNEMhKfDF4/ftmwjMb+SHBR4IC98enPRuWGFLon50zBRWY3JaXlrM2JKxvZ8Kp24+NV0PLwtjfzBsb9sddXbgh36Rg3+eQAhTErs8alC3goVwvUNSqNp7Pr9PM6USK91/BXZRjGA9K2+tDgIn2Kkg8A6xSS7pJ8MZuoimlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0hpaSHvg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbkHnkWZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKB0i+Xw0s34V0VaCOLycKmnkXW0NpNteJ2EfwZ5fkU=;
	b=0hpaSHvgI/PkT1wC4xaNJ2OR/dH/MoxWZZ8+Q41K1TyGo2nIjwoup4zJV/NRXYwql+lBI+
	PDw5tyJskf+2iAh/JvAcfXha8bKxc+tE7ojF7Kb9fJUaztZeXVwI6S+iQOsBJdZCvaexbB
	owEruktiA3oW9lXjNa3iUfiU/LGcE1dRo9lfk5cl2Mjz6stono6tQMII3k7AXID5mc1pUh
	Bqyf2cCOfVAasrvXYrPRJ8cJwTKBef4ekB/wvNbZa7ns5upiuCFw1odFjKay29QJ+/3Uzy
	xDxatLiTabgIqKxWDykZt54m0O9lSx+8AgrthWIEqROJvk7nFhno4M6yJPUFOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKB0i+Xw0s34V0VaCOLycKmnkXW0NpNteJ2EfwZ5fkU=;
	b=KbkHnkWZvcx7KGd2kOMyLDVqRLzemCesEV0tEH7r4C9l1ldzjp1f0racZ7Pjp3WD0aLBUm
	vWYm0QDkrOwWCRBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] ice/ptp: Remove convert_art_to_tsc()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-8-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-8-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700839.10875.14505632188201193249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d4bea547ebb577a4b4c545a4a81d495cec7eefe1
Gitweb:        https://git.kernel.org/tip/d4bea547ebb577a4b4c545a4a81d495cec7eefe1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 13 May 2024 16:08:08 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:51 +02:00

ice/ptp: Remove convert_art_to_tsc()

The core code now provides a mechanism to convert the ART base clock to the
corresponding TSC value without requiring an architecture specific
function.

Replace the direct conversion by filling in the required data.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-8-lakshmi.sowjanya.d@intel.com

---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0f17fc1..15ca440 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2091,7 +2091,8 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 			hh_ts_lo = rd32(hw, GLHH_ART_TIME_L);
 			hh_ts_hi = rd32(hw, GLHH_ART_TIME_H);
 			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
-			*system = convert_art_ns_to_tsc(hh_ts);
+			system->cycles = hh_ts;
+			system->cs_id = CSID_X86_ART;
 			/* Read Device source clock time */
 			hh_ts_lo = rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
 			hh_ts_hi = rd32(hw, GLTSYN_HHTIME_H(tmr_idx));

