Return-Path: <linux-tip-commits+bounces-3488-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F14A398FC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06151885197
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6222594BD;
	Tue, 18 Feb 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lNcNZfaT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FL4TwU0I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64528248187;
	Tue, 18 Feb 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874404; cv=none; b=VxjtjgikxYkycGziHHJElkXicY24pWAxToFdTBsHTsW50e7MzIAeB6emR6x1L1MTcrsOueoIYCrKz8fE31l0IsBlBmbdDRPrPKKS78tokTdgCRfNNb7tSEpngruR5+UslBfuZ9/+T5wma2CC+AI2ymx57qATnSH6p8yxdMn+ak4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874404; c=relaxed/simple;
	bh=QrZ94Ql59TpZIhqOJL9ftg2JeqlaZ5W31wg+jp3hJkM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eYEsrqk9QNmY8hufJ4fmgokuOl1Qc9NsZL7taOnC3lQP+PWR44LssFWzzYz5yGENt+s5DUdmD1eGAF5kC2T362SANMToxhaEoOBCElPWp9UvejhMBjDTqvyFiFvzPg5y08oVi8Kx1XwVc/10503/cw95q5KPZ2Mzigawmnundx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lNcNZfaT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FL4TwU0I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/HWwmofKWNt2oDx0ST285v/TpoHjBe47O5DWAbkiiA=;
	b=lNcNZfaTT3HCeZYpspJDl7OJm8ljJ4MKgb2se3W3lBRw8fw869J7gaLjk6sorKu31J6EAr
	t7cTFnviN4xsPdx3FYUjhOmbb0NCz4RZceMDlgB2xsRr6fjkfxtC+j4mXqneaPQRzeCANO
	nmvJbHARbYU/UZPb3uu4J1d2Ie2TEgvzGLAoSJCGFk0T4FqArcf38NPfSm7ZRhPjlA6SB3
	vLFijRr9T5TidLEqP7FQNSK0xybbaz3joz/czTnQvgrcryyw2yAIz/PFEWCIO93HRQIbEV
	YskVqu3tJnjoFGUyWupdbWpHvTCoxXRWpwfL4jYxTpFVgIRQARI+UUoxSgi5cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c/HWwmofKWNt2oDx0ST285v/TpoHjBe47O5DWAbkiiA=;
	b=FL4TwU0IOoNzOHH6wPhF4T899O5AYT8zUdVpVqewSJXnEr9/w0MPajEMq3+NVRLHvhHpFl
	pDJrDE87hFnhzwBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] scsi: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc951a5966e134307b8e50afb08e4b742e3f6ad06=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cc951a5966e134307b8e50afb08e4b742e3f6ad06=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987440021.10177.890985533032094309.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     b7011929380d2fce41e9fa7050a1f7f1eb254c2d
Gitweb:        https://git.kernel.org/tip/b7011929380d2fce41e9fa7050a1f7f1eb254c2d
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:03 +01:00

scsi: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/c951a5966e134307b8e50afb08e4b742e3f6ad06.1738746904.git.namcao@linutronix.de

---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 4 +---
 drivers/scsi/lpfc/lpfc_init.c            | 7 +++----
 drivers/scsi/scsi_debug.c                | 4 ++--
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 16d085d..9e42230 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -2922,9 +2922,7 @@ static long ibmvscsis_alloctimer(struct scsi_info *vscsi)
 	struct timer_cb *p_timer;
 
 	p_timer = &vscsi->rsp_q_timer;
-	hrtimer_init(&p_timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-
-	p_timer->timer.function = ibmvscsis_service_wait_q;
+	hrtimer_setup(&p_timer->timer, ibmvscsis_service_wait_q, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	p_timer->started = false;
 	p_timer->timer_pops = 0;
 
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index bcadf11..d1ac1d1 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7952,11 +7952,10 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	timer_setup(&phba->fcf.redisc_wait, lpfc_sli4_fcf_redisc_wait_tmo, 0);
 
 	/* CMF congestion timer */
-	hrtimer_init(&phba->cmf_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	phba->cmf_timer.function = lpfc_cmf_timer;
+	hrtimer_setup(&phba->cmf_timer, lpfc_cmf_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	/* CMF 1 minute stats collection timer */
-	hrtimer_init(&phba->cmf_stats_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	phba->cmf_stats_timer.function = lpfc_cmf_stats_timer;
+	hrtimer_setup(&phba->cmf_stats_timer, lpfc_cmf_stats_timer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	/*
 	 * Control structure for handling external multi-buffer mailbox
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 5ceaa46..fe5c30b 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6384,8 +6384,8 @@ static struct sdebug_queued_cmd *sdebug_alloc_queued_cmd(struct scsi_cmnd *scmd)
 
 	sd_dp = &sqcp->sd_dp;
 
-	hrtimer_init(&sd_dp->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
-	sd_dp->hrt.function = sdebug_q_cmd_hrt_complete;
+	hrtimer_setup(&sd_dp->hrt, sdebug_q_cmd_hrt_complete, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED);
 	INIT_WORK(&sd_dp->ew.work, sdebug_q_cmd_wq_complete);
 
 	sqcp->scmd = scmd;

