Return-Path: <linux-tip-commits+bounces-2207-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C647970954
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 20:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F8C1C2109A
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Sep 2024 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0E1178CF6;
	Sun,  8 Sep 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dtf+qdrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3YRG+w9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D2E17836B;
	Sun,  8 Sep 2024 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821891; cv=none; b=OQ8TEXeULMCtN46+6i2TlhgfpYwwFIxREpJJh+tDuZvtlHI8bGxwtjRwpXg4RrMkZCsTFEmzsdlVH5808lkwt3LuXQ648H10Gbqdoi0dzZzlBhiqGVCAS05YV5R2NqjrjvhWF1AYcaVm98AN1hwkrhWmLTdI60RAJLhqpoJV/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821891; c=relaxed/simple;
	bh=9jpEaOCzYP7Jjaro8cwo3eoKGl7kAiS7Upv2VZ5o7i0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MNohfVjTeNWeWEvAW6xuz8G6zsm0iLKUh3udiNf9ESNJkF7rbFhnyjbd0E5d2cP39Yw0noeIgKHZu8u/KstQXEIt2WuKZHd6KRE5FW7RLd+jLLEhZHhD197icesS/EaTYkGQW3c2cPsQExUS743cF6Q5iXW+Nxr9I2OdS4XGQHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dtf+qdrF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3YRG+w9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 08 Sep 2024 18:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725821887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4cQbDfhRMyXn+VUYbFpBhKUrV9gK+4X7JciN1CuOos=;
	b=dtf+qdrFRd9xawcI+PD9ojbRgOFCtqyGLo0cm2vao3LF0gUlIBhByfhEBRVp992Z+YvfLv
	xjZEdXp4N6GedA90melbCLLxR5pi/gkfr/L9oxhKep7PUZ1N6L44yCyxwR86Z/k8CnnoVx
	tJPVY+oSrSKT7xc1L/d/szBiOS7ws8a6MjHSlvwrF+pYy6ZWNid1G954Io9s55YP2M45d4
	Gf/lzOVmsKOZxhlo1G0ghqDf4gGyl7UXZWt/ZR/RWTGi/3LesEOqQAeB9ZyMf4S0zVdQpq
	GHvGTn8HhQ50RlSmF+hQmcKXkUIw6T1s3FzlFd0sYKhbwARPWjkh45MtXdPiEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725821887;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n4cQbDfhRMyXn+VUYbFpBhKUrV9gK+4X7JciN1CuOos=;
	b=H3YRG+w9EOBTSXVifhK1qvlI96rM5sfp3PqYmwtVO40zZDfLrpZsCxYM3R/ckunZ9L8BTn
	jWY2/PFZRqCWFpBA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] cpu: Use already existing usleep_range()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20240904-devel-anna-maria-b4-timers-flseep-v1-2-e98760256370@linutronix.de>
References:
 <20240904-devel-anna-maria-b4-timers-flseep-v1-2-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172582188694.2215.15911663561301882771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     662a1bfb907cd850da4de9b871640ad47a355bc0
Gitweb:        https://git.kernel.org/tip/662a1bfb907cd850da4de9b871640ad47a355bc0
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Wed, 04 Sep 2024 15:04:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Sep 2024 20:47:40 +02:00

cpu: Use already existing usleep_range()

usleep_range() is a wrapper arount usleep_range_state() which hands in
TASK_UNTINTERRUPTIBLE as state argument.

Use already exising wrapper usleep_range(). No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20240904-devel-anna-maria-b4-timers-flseep-v1-2-e98760256370@linutronix.de

---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1209dda..031a2c1 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -330,7 +330,7 @@ static bool cpuhp_wait_for_sync_state(unsigned int cpu, enum cpuhp_sync_state st
 			/* Poll for one millisecond */
 			arch_cpuhp_sync_state_poll();
 		} else {
-			usleep_range_state(USEC_PER_MSEC, 2 * USEC_PER_MSEC, TASK_UNINTERRUPTIBLE);
+			usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 		}
 		sync = atomic_read(st);
 	}

