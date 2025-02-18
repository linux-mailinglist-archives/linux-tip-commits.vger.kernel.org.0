Return-Path: <linux-tip-commits+bounces-3461-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2830A398F0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A283AFE06
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B523498F;
	Tue, 18 Feb 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZAlS+9SR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bg0HVDXI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FAC2343BE;
	Tue, 18 Feb 2025 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874386; cv=none; b=B4i7Ugkb5y1dkDku+5eLXuJ2CDuHSmw1tYE0I2uLQ/5okjcqoxvUVCQc+mLtgPNDOD9a7LEXLEbmEN9yFWallG+1u27Af3R1JPiXIVB80ql8bsSpaZel06c1OHrJnw2p/nIR3hco9NmkQWiXk3LBrAowvpWtXoLHDNSBCSprzJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874386; c=relaxed/simple;
	bh=WilmIa+OqsK1DtOzU5SOzTQCtgHATK0NnTsy6II57Oc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=stgVKsZS70pH/tf/LdVkAu3oNJAUKyN7kvmpxGkFumcmz+KdXpqD8X6OrWa1zqNkYQDl4EO/66rwVwKYTJA/Udzy/A1katx9Q3tc3uWQaFjFSZ50UIyGZyik/lDOMtiNYbscEZOV4no46K0QV1XqrLdW0R0OLYrjApyJofvpetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZAlS+9SR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bg0HVDXI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAvehnsu9Eqg3lg1sfK+CajYcHaHH4h27Ylmg+7H36Q=;
	b=ZAlS+9SRxcrD5uBW1urq1EDCgTDFm07MOOEKoT2SbAhiwyXiyd8U+zNFCxVXALF1lCTZFN
	sVJ63SJlRCqGFpCWK7z38uXrXH7sxVrZeDph9uBY759/tYO38CJKuY+2tA/bPUkLqb79mY
	Kxeaf2x/wGVgM30QaGTlnMDZHplP0DxOIFL5D9mfBO+abzyX1+0/kvCQa9JbWMPiAZJ4Pr
	ppLDMjRFACy2U55TrGie74sCZtJm2wzujkC5nf/rgEWVYt37DkzeQD01KoE4wPT1G1UKvW
	+VDHmcN1H4D2qHfGAZ30CWhWrJMcC4zJcRQPW3aB5gNsI2Qw7KNrCOFmrpSBOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874382;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAvehnsu9Eqg3lg1sfK+CajYcHaHH4h27Ylmg+7H36Q=;
	b=bg0HVDXI8T2wobax1cRiBnrtTAz2TJGfu1m7HSDAN157o4FkJz1JCFwHbmvtSNEs9PyoP7
	p605kl6C6BXqfiCg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] RDMA: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C37bd6895bb946f6d785ab5fe32f1a6f4b9e77c26=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C37bd6895bb946f6d785ab5fe32f1a6f4b9e77c26=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438200.10177.69686175221005552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     bbdafde7c22018a4a84db98b11eb8f8ab26d7731
Gitweb:        https://git.kernel.org/tip/bbdafde7c22018a4a84db98b11eb8f8ab26d7731
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:07 +01:00

RDMA: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/37bd6895bb946f6d785ab5fe32f1a6f4b9e77c26.1738746904.git.namcao@linutronix.de

---
 drivers/infiniband/hw/hfi1/init.c | 5 ++---
 drivers/infiniband/sw/rdmavt/qp.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index cbac4a4..d6fbd9c 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -635,12 +635,11 @@ void hfi1_init_pportdata(struct pci_dev *pdev, struct hfi1_pportdata *ppd,
 	spin_lock_init(&ppd->cca_timer_lock);
 
 	for (i = 0; i < OPA_MAX_SLS; i++) {
-		hrtimer_init(&ppd->cca_timer[i].hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
 		ppd->cca_timer[i].ppd = ppd;
 		ppd->cca_timer[i].sl = i;
 		ppd->cca_timer[i].ccti = 0;
-		ppd->cca_timer[i].hrtimer.function = cca_timer_fn;
+		hrtimer_setup(&ppd->cca_timer[i].hrtimer, cca_timer_fn, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
 
 	ppd->cc_max_table_entries = IB_CC_TABLE_CAP_DEFAULT;
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index e6203e2..614009f 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1107,9 +1107,8 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 		}
 		/* initialize timers needed for rc qp */
 		timer_setup(&qp->s_timer, rvt_rc_timeout, 0);
-		hrtimer_init(&qp->s_rnr_timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		qp->s_rnr_timer.function = rvt_rc_rnr_retry;
+		hrtimer_setup(&qp->s_rnr_timer, rvt_rc_rnr_retry, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 
 		/*
 		 * Driver needs to set up it's private QP structure and do any

