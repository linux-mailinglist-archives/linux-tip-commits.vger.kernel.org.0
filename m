Return-Path: <linux-tip-commits+bounces-4027-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232ECA5491C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 12:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512543AE47C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A92054E6;
	Thu,  6 Mar 2025 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b5pmka83";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hw5Bw5bP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373041FFC70;
	Thu,  6 Mar 2025 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259998; cv=none; b=gFYgzFlQ+g7j0Mvm97KbGczlhQu7ZIlw1o3pREC5lsqwbUCuYjSv4L+fzz0AbE4M/Q7beR6EjH6Hh4tKGHmXOOjI7sh8KBfR9QMM0JS1PC0NSe+cWtk0m0m+pbycEzXk9/kurNPCqqgrHynw7SOnNzhfxCclC0WLKUx9w47/rKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259998; c=relaxed/simple;
	bh=DAzeSdGir/Agm3/6Tf+eErGODMjLgt+Jy6aZTLhUa2s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J77fteiSS7X+wNcxfUsUXiCbL1qD1/Zycl4RFro+TNlyicaz8t0aucWDlcoklmguwpviLbzOz55nWQAmsbEGdfrhxSuCJukyPZsaGLoNMUVQYtutVhxDBI2Zy4NQK+pzxinSqHnR4xwh0Rnevytxbq1M/5uJfN14lJ6J0ddEhnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b5pmka83; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hw5Bw5bP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 11:19:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741259994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqp3WVvDd8BApeifH6aQ9DFtLSfHKh0EmkD+paa3xws=;
	b=b5pmka83f4Bun91cYiuWzUKxI07xOZGdvM4rgNKnm/vlfGRZ56dTODggr4zLnhCK0KqaEp
	uxtJwG8AlX1juk83AFemmXvWZJON1HRy2rhZdBTeSeHzQbQdK9z7QzFYjxD2Q7BCrule0U
	Q38ln7H4U6Kh7A68ObbSoWf3v9tJK//oJI5NPnQxF0dKSw6tu/5RPZitfb+xGlPKp9WOgA
	nxrTcH7BLMl4szE9R1B6h/WCI7Sdy08bAHef/W7WHZBXj2Ogdiu2rfIAB1o9vnwLzmpDx4
	MdwfVMYb8hfI2KPZGeqRVPTb2Idrl44mIWwoqbJsx9j+sb1knLHEv83wqCI6RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741259994;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqp3WVvDd8BApeifH6aQ9DFtLSfHKh0EmkD+paa3xws=;
	b=hw5Bw5bPbcikp9ioMq8uSSRPKB4nslQu/9gj+B4bpvTjtHxEfEvS5CiD8/CjKme3uKQU4C
	yWjrNqAulZI2azAw==
From: "tip-bot2 for Li Huafei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] watchdog/hardlockup/perf: Warn if watchdog_ev is leaked
Cc: Li Huafei <lihuafei1@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241021193004.308303-2-lihuafei1@huawei.com>
References: <20241021193004.308303-2-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174125999340.14745.5633520821144529020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     05763885e327f0e257ee8b96b30ac1b95f7dd532
Gitweb:        https://git.kernel.org/tip/05763885e327f0e257ee8b96b30ac1b95f7dd532
Author:        Li Huafei <lihuafei1@huawei.com>
AuthorDate:    Tue, 22 Oct 2024 03:30:04 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 12:07:39 +01:00

watchdog/hardlockup/perf: Warn if watchdog_ev is leaked

When creating a new perf_event for the hardlockup watchdog, it should not
happen that the old perf_event is not released.

Introduce a WARN_ONCE() that should never trigger.

[ mingo: Changed the type of the warning to WARN_ONCE(). ]

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241021193004.308303-2-lihuafei1@huawei.com
---
 kernel/watchdog_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 2fdb96e..a78ff09 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -144,6 +144,7 @@ static int hardlockup_detector_event_create(void)
 			 PTR_ERR(evt));
 		return PTR_ERR(evt);
 	}
+	WARN_ONCE(this_cpu_read(watchdog_ev), "unexpected watchdog_ev leak");
 	this_cpu_write(watchdog_ev, evt);
 	return 0;
 }

