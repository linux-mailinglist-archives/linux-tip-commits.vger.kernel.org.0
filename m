Return-Path: <linux-tip-commits+bounces-3437-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2504A3984A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B193A6487
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B54E23312E;
	Tue, 18 Feb 2025 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GLigK29w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5IF2MuaY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49B223237A;
	Tue, 18 Feb 2025 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873203; cv=none; b=bJaBkUfWxkwULZVBabGUr0hxHkjwqFgeEzWO7W0uz/I1MWjdUhkGoOpvCAqTY8owvx5/TxFTIKFTe5CRrMgOt2zpU8REQpv5unpxI/iANgKgr0ujzbcYrdhqTaRhWaYd2YdUeHzXitAUX4T0SfjYVRBWm9CU7mGkeBC2IV8hrKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873203; c=relaxed/simple;
	bh=ou7Qbagoelz4wwKgghrYTe5t3S8OYlkMdRYuzVL3XKs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IjT/xDddfkJbpWsGKFcW4holUDgQVeDLJnThmPM2qVMoHudGpNSMETJphiDG4vB6XevAgplhwAMwYxEfLKyyi/UOhd2gxsQL3sFfMqanTW1kMEF6yixFASgQi3SMcZzUunWwnVG42Tt5JTrQEinTnV6Y/eO6P8vKWCAc2cB/lMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GLigK29w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5IF2MuaY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:06:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739873200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vqo4/xqg5fN5q4k/n3IoztSQK3n1jgYnBC7ssZrFAe0=;
	b=GLigK29w2ColilCUo4k4OpleF8sBIRRQ5NlMoBWONarTROWxRRVCZ1cdJl6bethAyQwP9K
	MPkQI7ypaqN4hEOu5X4Lh5O2ybSRv/tbJyAv9TKzeS/iqJugTFabxYbE3zsp/+qHPGRcj9
	/8xDDGourMHJw4LQM3LfrqT6E1/8TbZQgyyHvLmQCdHNyRfUKYRLvuWSZHiEqXMsHHP256
	EODxyaeS8c/gXNLe1PA6CVh/7kxOBYSKQ9+GWgBx2+E+nBn4fkWNObjYc+HoHBvGNEian/
	jU6v067VD1xaYhnemmDaOaT9irjWPre1HQucnd78Gw31yBk627Miw77t+K83aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739873200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vqo4/xqg5fN5q4k/n3IoztSQK3n1jgYnBC7ssZrFAe0=;
	b=5IF2MuaYpjSeK6LYfixYlHE4KCULRa6VUJgGecG325+/fx137FiA/F4XgXWVY/dpINMjpM
	07BnzOj0Opk6K/DA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] octeontx2-pf: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca935bc6ca7933053f9e349578da4a8fb477b7c2d=2E17387?=
 =?utf-8?q?46872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca935bc6ca7933053f9e349578da4a8fb477b7c2d=2E173874?=
 =?utf-8?q?6872=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987319957.10177.14746121360193950381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7b449279f56ac9679b4e5a14ce484953b8deddf0
Gitweb:        https://git.kernel.org/tip/7b449279f56ac9679b4e5a14ce484953b8deddf0
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:43:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:35:47 +01:00

octeontx2-pf: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/a935bc6ca7933053f9e349578da4a8fb477b7c2d.1738746872.git.namcao@linutronix.de

---
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
index bcc96ee..66749b3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -545,8 +545,7 @@ static int ptp_probe(struct pci_dev *pdev,
 	spin_lock_init(&ptp->ptp_lock);
 	if (cn10k_ptp_errata(ptp)) {
 		ptp->read_ptp_tstmp = &read_ptp_tstmp_sec_nsec;
-		hrtimer_init(&ptp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		ptp->hrtimer.function = ptp_reset_thresh;
+		hrtimer_setup(&ptp->hrtimer, ptp_reset_thresh, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	} else {
 		ptp->read_ptp_tstmp = &read_ptp_tstmp_nsec;
 	}

