Return-Path: <linux-tip-commits+bounces-2664-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 791309B77F4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AADB263B7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A40A198A22;
	Thu, 31 Oct 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WyvJFqqu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B4gxn+Kw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43328197A88;
	Thu, 31 Oct 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368277; cv=none; b=Rt/fZTZ3syXcbs/Y2wnd7NaKkyD9gipMcEmWEN6rH88OHBOQnLZee/WDcIOzdXYEscQeZfV36zAimoOSvAARNuC0bbFH77jVYwQCCs10lgpxgPaedOZnnUe3bwksyGGBDRa6QAcUrny1ApapB0wyvBWC06BUZHGvSf4blTGXzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368277; c=relaxed/simple;
	bh=3IonWf8VYD+NzxzUSLO0X8i0sFpS9SZ0ImRtDJWU9So=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JHxXuSUGjezF+GLHaaSOD2OUdGrdz7TxqelBZMOJpeKMxYR7r1kySVUGGE8J+6qsPXjIEsMlVRbkbZgHZ1GXQ5AaHY6QDc5BGMgwpuRpomLcl2qKHAyLSKXMRM4UbnSHRIwTE4XcZBNZduFE871SXhJD7qgJNZht4A2HWooYB8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WyvJFqqu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B4gxn+Kw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+aiz2sxkCrZOaXT8e5RGVL91OxXBvaTzNtmNsurrOc=;
	b=WyvJFqquCDP4eBVq1ZzxfVSpoQ6cQH8W6sMuPMAicX22tYH1BEZSQvZo7sGIybXO9S2SMP
	/ENwimsR0J7X2BIsMu69TAVKvVk9XSvRJAOk1KwsrazuoaP5YnDwgjqCJvEOe50EjHE3lf
	BHmegd3NYkKvqn1d92AynRncBcipgqFCXY9ROW4AD834KxDqj3nD/rQzW4xtS52GYMbN42
	rRPtVPx56msOrQxFA0D97Lu2192Jr7SeuPSMVBXadhHMtPKOhNkLzXCoq3C4YpLV5vSI70
	lBLMUdzefBQaXS4Nk82+9LtRrJG6b/KpsOVSQH1bHYlqbN1Dh2b0VVzNQPHapA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+aiz2sxkCrZOaXT8e5RGVL91OxXBvaTzNtmNsurrOc=;
	b=B4gxn+Kw757x7zgA5PQtHa6qlcNpA+Taa8szUVx5s7A7d+BTtXXkrDX6RzUCj4DFBlNBJl
	XdaR3R7Tx98KHdAQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/qcom: Remove clockevents
 shutdown call on offlining
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-10-frederic@kernel.org>
References: <20241029125451.54574-10-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827286.3137.17308116779721994984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cd165ce8314f8b91b171c1f0d4cf144c0f88f757
Gitweb:        https://git.kernel.org/tip/cd165ce8314f8b91b171c1f0d4cf144c0f88f757
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:43 +01:00

clocksource/drivers/qcom: Remove clockevents shutdown call on offlining

The clockevents core already detached and unregistered it at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-10-frederic@kernel.org

---
 drivers/clocksource/timer-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-qcom.c b/drivers/clocksource/timer-qcom.c
index eac4c95..ddb1deb 100644
--- a/drivers/clocksource/timer-qcom.c
+++ b/drivers/clocksource/timer-qcom.c
@@ -130,7 +130,6 @@ static int msm_local_timer_dying_cpu(unsigned int cpu)
 {
 	struct clock_event_device *evt = per_cpu_ptr(msm_evt, cpu);
 
-	evt->set_state_shutdown(evt);
 	disable_percpu_irq(evt->irq);
 	return 0;
 }

