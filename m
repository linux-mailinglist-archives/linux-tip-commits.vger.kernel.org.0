Return-Path: <linux-tip-commits+bounces-3471-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8F4A3990B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0EB3B8A49
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3592405E5;
	Tue, 18 Feb 2025 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3seChiJs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Zao58hX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925C23C8B3;
	Tue, 18 Feb 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874392; cv=none; b=lGwN7Z7xYrtMC0KZnj66Jer2KysRq76SsJsQOP9Wx9ZvfzeoM3Jc7SuquDPzQMBkzEZ1RGtJiiEdwzltibR5ohKSaF4kC7ax+9Rmqt8mWe2DXF/e1r0FfUc0eMVwRVwSs2xUt0EtittIVoYGSA1zTLDIjLw0MdYZ9Tb982O2Qrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874392; c=relaxed/simple;
	bh=4y2P//LxkG9P19SiB1ZGE5GKuI0FJvg+E6JBQi92xko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NbvcdHlich4faNeKJdbzyXd4NkZABrJd6chvRDiOdO35BKviXH6krDplC25GiCKxSdbTKuj4MpiFd0yiY5+PAvmxRIIWwiR83KqJMU+wW6oEKT9kJ5WTlEcdk684eOFFrTksAFOcIECr/GrChvMAncsJx2DOe7vd1djvdQbyHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3seChiJs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Zao58hX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysCU+FaARJe9Z3D9b+A9cBXKgpJwj+rjy7yWGdmjOtw=;
	b=3seChiJsC+dFqdMFPWFWo6LUmRPMKQSnmT+r3gFa5LyohnO+evrrtLKHuTMH1I6QEMFsFs
	i8K8TqkQAlUCzgLqU37b0qfy2G5l7wUZLElT/bgoavLkRLP+f/YhkIWc7t0zPiBgrYXIty
	gNgyOLa7lcgZsZhzPk2+MFfHeQbiYi52xcAznsWZtaMufr9l6A+aHbGxYKD2VsKtf88gtF
	cKeAIOoC4m1qdDM/m+0/+Ms0ww8gjeAtEAYQ+ODjzchUwgx3182Syb0wlk3mT9/+7VUPgw
	rlScpktaCtilyYViXXCbUlgQgbCXnXoqrjBCStJHHLa0SvucULbk3oaPhCj/FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysCU+FaARJe9Z3D9b+A9cBXKgpJwj+rjy7yWGdmjOtw=;
	b=1Zao58hXquDm8KH5xndnrpJaUWfdCoiNhXbrh/NpBf0Ve7dNvjTLliafdw/WONK8uFd2B0
	NPIQuhzmdpZVldDg==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] drm/i915/gvt: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, Jani Nikula <jani.nikula@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9af55b7d0918bb3642c6392fbb4800d8ea7c9c50=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C9af55b7d0918bb3642c6392fbb4800d8ea7c9c50=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987438882.10177.13574390170813635415.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     9892287897ca0c267a3071f7f6fa5d82126e29e9
Gitweb:        https://git.kernel.org/tip/9892287897ca0c267a3071f7f6fa5d82126e29e9
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:05 +01:00

drm/i915/gvt: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Link: https://lore.kernel.org/all/9af55b7d0918bb3642c6392fbb4800d8ea7c9c50.1738746904.git.namcao@linutronix.de

---
 drivers/gpu/drm/i915/gvt/display.c      | 3 +--
 drivers/gpu/drm/i915/gvt/sched_policy.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/display.c b/drivers/gpu/drm/i915/gvt/display.c
index 95570ca..f668cd9 100644
--- a/drivers/gpu/drm/i915/gvt/display.c
+++ b/drivers/gpu/drm/i915/gvt/display.c
@@ -581,8 +581,7 @@ static int setup_virtual_dp_monitor(struct intel_vgpu *vgpu, int port_num,
 	vgpu->display.port_num = port_num;
 
 	/* Init hrtimer based on default refresh rate */
-	hrtimer_init(&vblank_timer->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	vblank_timer->timer.function = vblank_timer_fn;
+	hrtimer_setup(&vblank_timer->timer, vblank_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	vblank_timer->vrefresh_k = port->vrefresh_k;
 	vblank_timer->period = DIV64_U64_ROUND_CLOSEST(NSEC_PER_SEC * MSEC_PER_SEC, vblank_timer->vrefresh_k);
 
diff --git a/drivers/gpu/drm/i915/gvt/sched_policy.c b/drivers/gpu/drm/i915/gvt/sched_policy.c
index c077fb4..9f97f74 100644
--- a/drivers/gpu/drm/i915/gvt/sched_policy.c
+++ b/drivers/gpu/drm/i915/gvt/sched_policy.c
@@ -286,8 +286,7 @@ static int tbs_sched_init(struct intel_gvt *gvt)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&data->lru_runq_head);
-	hrtimer_init(&data->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	data->timer.function = tbs_timer_fn;
+	hrtimer_setup(&data->timer, tbs_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 	data->period = GVT_DEFAULT_TIME_SLICE;
 	data->gvt = gvt;
 

