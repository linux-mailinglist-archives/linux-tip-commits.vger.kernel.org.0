Return-Path: <linux-tip-commits+bounces-3466-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60969A398FB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E913B61EB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBAF23A563;
	Tue, 18 Feb 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FpDCCZnL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JvTtyoPh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9123716F;
	Tue, 18 Feb 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874389; cv=none; b=D+uwzNyS8FzF1OeAjlXGss5mxWXO4x4AH9AcqB3HEYRYmA3CGnZ6E9bFfbUiY96mZWRYfW0LJkppKhqaGEHTltT1aI0GW4B/pT+Vun9DcQmRr2a4I4UTX+PCHxfXLA0CTKA1kRGXlksePGPb8xrHZuY3MoTpFtyrJ+oae6GiW8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874389; c=relaxed/simple;
	bh=FAr2qlHZzmQG56oUEsNOfCWy49Z29yadUqaRdzi1n1I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MKLl3du9ZS8ZqhCY0hLrDShkWPxqQzOjVNm32FsyxaaewS3yO80nCKJ0C0H1iD6A7mtP4/QGHkHyCUQKjvbfqaYfZbnSdLr37jT4wNp2FyYYPK6YmEkyBckIGzCE67p4CL8vArZtmN9IJBJb8FN7JG5p2BzvP/PAdnhsf+aJxi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FpDCCZnL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JvTtyoPh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxkVZClAw7heyjzengDc2k5RZwpJ/bRJ+RLA9Qv2If4=;
	b=FpDCCZnLr4CZCCuUwpBLc7DsJoZQq0HnNdhJbi7o0TjXu9LJsStq4MxAHtDa5RP8f8IkZ2
	RNKcHfXJGektwmOGVKVY4fvi4mmEnvwjs2qy1OLENWII7ZypcVqK8tDjwXcS5MrGrERRqq
	8kdnocKKpjM/JCbusQSdcC4QpinrnfgU4HQe0s1tXrHIkdZqOgdlEmpjrqUmaxfPDMT6ru
	Vlvc6+abjl4odWjL74X8JvuF0OYEnio+ILhZ156uqnkWdioHjhcRcZM9eeOXJRhxgLSKji
	ePgMQvB/yTO3EYMnXwQcg9yxLIoBwMVoJvCWSgGf9KnejXGMsNabnD7y5MES0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874386;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxkVZClAw7heyjzengDc2k5RZwpJ/bRJ+RLA9Qv2If4=;
	b=JvTtyoPhab23gFj9rBhLvgnYfOx4ZyYgNuZZalCmbDNDuUtiuyoY5bwMtAW2Ke7kLv4uM8
	zEWBYpyqwrNKdICw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/msm: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2689e1ad4105f415ce8cd9e426873d9ac479dc36=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C2689e1ad4105f415ce8cd9e426873d9ac479dc36=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438547.10177.5043362399856293336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     58ac3c93306ec588a6dbb8d3e02ac1109b32df6b
Gitweb:        https://git.kernel.org/tip/58ac3c93306ec588a6dbb8d3e02ac1109b32df6b
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:06 +01:00

drm/msm: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/2689e1ad4105f415ce8cd9e426873d9ac479dc36.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/msm/msm_fence.c    | 3 +--
 drivers/gpu/drm/msm/msm_io_utils.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fence.c b/drivers/gpu/drm/msm/msm_fence.c
index 1a5d4f1..d41e5a6 100644
--- a/drivers/gpu/drm/msm/msm_fence.c
+++ b/drivers/gpu/drm/msm/msm_fence.c
@@ -65,8 +65,7 @@ msm_fence_context_alloc(struct drm_device *dev, volatile uint32_t *fenceptr,
 	fctx->completed_fence = fctx->last_fence;
 	*fctx->fenceptr = fctx->last_fence;
 
-	hrtimer_init(&fctx->deadline_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	fctx->deadline_timer.function = deadline_timer;
+	hrtimer_setup(&fctx->deadline_timer, deadline_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
 	kthread_init_work(&fctx->deadline_work, deadline_work);
 
diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
index afedd61..a6efe1e 100644
--- a/drivers/gpu/drm/msm/msm_io_utils.c
+++ b/drivers/gpu/drm/msm/msm_io_utils.c
@@ -135,8 +135,7 @@ void msm_hrtimer_work_init(struct msm_hrtimer_work *work,
 			   clockid_t clock_id,
 			   enum hrtimer_mode mode)
 {
-	hrtimer_init(&work->timer, clock_id, mode);
-	work->timer.function = msm_hrtimer_worktimer;
+	hrtimer_setup(&work->timer, msm_hrtimer_worktimer, clock_id, mode);
 	work->worker = worker;
 	kthread_init_work(&work->work, fn);
 }

