Return-Path: <linux-tip-commits+bounces-2047-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646B95195C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E2E284382
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F31AE046;
	Wed, 14 Aug 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2I9NhJM0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wibfm4MB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475641448D4;
	Wed, 14 Aug 2024 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723632594; cv=none; b=sHpc6DUZ35z7Kj80b5Kmvol1H4jXYM5dH4qmpNLv1CErKqQOSRhyusTJ8Ziz5KzgPkwhuziuo+IQMrIeZLSko1sPgRzpQAX0mVcDiJhLl3XCMQPnpOsJ8HOjxBq8hGyucQCYB96edPeYg3Q9dKO/vU7Q30Kp4Qm1gQZtIODlqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723632594; c=relaxed/simple;
	bh=tnVPkunnRf9xG3ftI4W1TtE+1EjM8xXjCq7Qe5ZreYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ivsBoQAfD6xOduzWs3ah9BgFYY7m376VZhu0eZl9EDZOv3fMO6yPgH698T5slEg7Mee+Du3nPfzt8Vrg0hKUoCe4ngdqDdTX1vsBTeplwcyDhMN86x+UjLe5g9adXiEvr4ODZDY8zXCxsUkov2kWIjteRoJIg6cVfDRsd1NIkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2I9NhJM0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wibfm4MB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Aug 2024 10:49:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723632591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDRnEIPkjZOAINatX5zvU9qUEz/Nc+IxVeKRiMeM/KA=;
	b=2I9NhJM0W4C2XtqY6qg2dgKWezxEQB5LRT1HqRoHknxWhiMpzvcpVMrS8G3O3F14TPyUj/
	7uVemav49ye6yWSYMdDBGefBnJ2J0Fg1BhQvcfp+p6/rke74mdOt1IfjhwJFxnJLQwyVYn
	Cqm8fsHyEarkvwysierxaZHwxYgO79YLNXjrHkaETHoWrv+t2HFq15ZxgA64Eo7xX2v2Am
	1UIsx16j6QaTJXsAzqFRv0CvcoMvvE2d2b5XwxNVJh11pclzRnSBMwGp9EXtHoKeY0S725
	ThMk0Nohvyq8cPAimTl3EPjByUuHveJvI/TD4oup8L2ZU+aRmA22urGlMxp2vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723632591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDRnEIPkjZOAINatX5zvU9qUEz/Nc+IxVeKRiMeM/KA=;
	b=Wibfm4MBQHDBmkNpnznxsRlibmmkA4xXmhe9JeEvhMXut53uQWcIjplR9Xwe0Iw/ETif1/
	gFnMMfbPY7oVEyDg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] hrtimer: Annotate hrtimer_cpu_base_.*_expiry() for sparse.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240812105326.2240000-3-bigeasy@linutronix.de>
References: <20240812105326.2240000-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172363259088.2215.18331777422823383181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     330dd6d9c0fce69718b53ca0bc4f2e3920f7f600
Gitweb:        https://git.kernel.org/tip/330dd6d9c0fce69718b53ca0bc4f2e3920f7f600
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 12 Aug 2024 12:51:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 Aug 2024 12:44:41 +02:00

hrtimer: Annotate hrtimer_cpu_base_.*_expiry() for sparse.

The two hrtimer_cpu_base_.*_expiry() functions are wrappers around the
locking functions and sparse complains about the missing counterpart.

Add sparse annotation to denote that this bevaviour is expected.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240812105326.2240000-3-bigeasy@linutronix.de

---
 kernel/time/hrtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320..f56ef23 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1351,11 +1351,13 @@ static void hrtimer_cpu_base_init_expiry_lock(struct hrtimer_cpu_base *base)
 }
 
 static void hrtimer_cpu_base_lock_expiry(struct hrtimer_cpu_base *base)
+	__acquires(&base->softirq_expiry_lock)
 {
 	spin_lock(&base->softirq_expiry_lock);
 }
 
 static void hrtimer_cpu_base_unlock_expiry(struct hrtimer_cpu_base *base)
+	__releases(&base->softirq_expiry_lock)
 {
 	spin_unlock(&base->softirq_expiry_lock);
 }

