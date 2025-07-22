Return-Path: <linux-tip-commits+bounces-6154-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20ECB0D5BE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2A7176229
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 09:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2702DCF43;
	Tue, 22 Jul 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fBBqhM69";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XfUk3igr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA24D2DAFC1;
	Tue, 22 Jul 2025 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753176009; cv=none; b=lRqHdpu5sWkcYCH9QDQr5P2HGR6yVupOgeJPsDAO5p1IAZkht8CjC6FgARnbvQHKWuN7+/J39+yBfng+IcUWSodbNCCEtwI8TDpErKQ0tnFn5HGz6o1rnMisJX9eA86z5dSLWsl+SXn3PBjWOrvlg82omSPurOSsjgVftYQv3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753176009; c=relaxed/simple;
	bh=GQ7aUZteCZupCARROJAkrgkzAlNnwNkip843/jexfGI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F2T5BBMKZq85jGqI+8o9DvbqHr9Tc0Wr5x2Pm1eDsARYsqA33ZumT3KD5KTpM8kE4Ve9YvrHbH5lKcC0o+rMqFsThNSMA/fJVGaUfQkBgd8J8bNUJgNHohQmBpgACoeMjA5KnkwGG6Pg0yRpPjUz07YxYYA8sL5LOrHzPtfg29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fBBqhM69; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XfUk3igr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 09:20:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753176005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhY9yHhrsUq8+kCfxK6mh8qD5dOSU1tprBc8CHj94Zo=;
	b=fBBqhM69oWMZ2GgTxG3eNrcZTOlQ5KiwKgatWtBgIM2biD4Ix1qU6ruX9xs/NE9HE8rCbT
	NhAsuRESGSgx40AGkAVP3C6owJa6Fnh5M0FZTv+egrqpizrqeItTFJ1PK8xhFQxYysoF0n
	qhxbBkqOmumc4bbaYGltynS0bg2sO5KZQ/eLWJsDxPT10+BKVYdMzBy791YyNqOmEVjNJx
	9CNbogKK1wStIojE1AB+HCz6bGNlfV//lACh5TJGqp5mrf3qj0/0Jx29VtuOqW+tSBr+Tt
	lehs9FwNSWnNRkI8IAqktdf2FnlYkxsc78eYowzaoLHUu7qwnYRhTmQhax9MVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753176005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uhY9yHhrsUq8+kCfxK6mh8qD5dOSU1tprBc8CHj94Zo=;
	b=XfUk3igrmCNsG0wNRShz/GUCbC8Q6reHCrGcWa76E4EcGX/jBZ5wffO98YuRBvniA4eMZB
	7Ryf7U5rZaJvygDw==
From: "tip-bot2 for Feng Lee" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/idle: Remove play_idle()
Cc: Feng Lee <379943137@qq.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_C3E0BD9B812C27A30FC49F1EA6A4B1352707@qq.com>
References: <tencent_C3E0BD9B812C27A30FC49F1EA6A4B1352707@qq.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175317600420.1420.1846913174693376674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1b5f1454091e9e9fb5c944b3161acf4ec0894d0d
Gitweb:        https://git.kernel.org/tip/1b5f1454091e9e9fb5c944b3161acf4ec08=
94d0d
Author:        Feng Lee <379943137@qq.com>
AuthorDate:    Mon, 21 Jul 2025 16:04:35 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jul 2025 11:10:43 +02:00

sched/idle: Remove play_idle()

play_idle() is no longer in use, so delete it.

Signed-off-by: Feng Lee <379943137@qq.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/tencent_C3E0BD9B812C27A30FC49F1EA6A4B135270=
7@qq.com

---
 include/linux/cpu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 6378370..8b1abbf 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -187,11 +187,6 @@ static inline void arch_cpu_finalize_init(void) { }
=20
 void play_idle_precise(u64 duration_ns, u64 latency_ns);
=20
-static inline void play_idle(unsigned long duration_us)
-{
-	play_idle_precise(duration_us * NSEC_PER_USEC, U64_MAX);
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 void cpuhp_report_idle_dead(void);
 #else

