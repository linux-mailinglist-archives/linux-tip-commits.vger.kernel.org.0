Return-Path: <linux-tip-commits+bounces-4404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C5AA6A202
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3FE461C3A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C1F2206A3;
	Thu, 20 Mar 2025 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KzKC2Y7V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fF6pyNdA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41F1EB9E3;
	Thu, 20 Mar 2025 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461203; cv=none; b=EVwHwCwUa+hpkYmNLLZmug5bLLIZIOl1N068tlYPsw2jYArm3lU1nGiu+AIMuwketyx5JtrCuKpuDnQCQ1YTYBOnaTA1LmJnJYtLxZfXfm6xVOLxu4HF2nogLlxzCPBB/78ty0xZJ0axmiRmahmiUKpnfr6edzovRSFcPUJi0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461203; c=relaxed/simple;
	bh=BOFVwOO95SsGEsi4METdWmctAVwZfBgOUYiSA08UXMM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YPV5x3Ou258gJoUoe4I3FzFSkljCy+B+9eepRonHFJQKVdBxSBFPX6D2qaykjRA50m//GA1hR+RpBHR88rViyB1lAfjeCaOb6+2iMW4CrtLl86SfdmYTCxhOYHXO6eBKM0ePOYBF6vnyidDmJIhsm8D2i+LBsEUa9JSjdt/nWh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KzKC2Y7V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fF6pyNdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 08:59:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742461200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKmyU1nPskBJK46R5/j8BSvy2fFhvZ9UlnmMp7NDS+U=;
	b=KzKC2Y7VcrpAfPaa7hdVgA3g0EsB5Vxwak3UZPrPMZVeLshQnNjVcgAir4YXmUfgHdzg13
	PWgMarrOQFIUQft+Y/LrxyK6L7Il/HALA3ckot9LdEQXdtDK9Tp35+NxVnXs1xzzpTr0mu
	jd+bExX+xJ6SGSzf4UrfM/7PF1jXlHoS5V2gdDZAMYjKchzdqlFt6LaeRCB49cg3nzwmKi
	41f8H+EIhLI1hHINdQlOrKGm2YcMMEU0UzPfgC1VRUxW7B4RLlyEivqobxk5GQelXZ2azu
	XpsE0r40vXCuCVcEyn5EAMxI5ftz8EyacwJsTWHCv/CS3Dr1Qryv4ABpJR163g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742461200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKmyU1nPskBJK46R5/j8BSvy2fFhvZ9UlnmMp7NDS+U=;
	b=fF6pyNdAkf1VpmNWn7ftkTRQprJY2wPvpQiIzEw/sFUeme0lR3H5lJKEkz2j+27ajqiZi5
	Wh0dgVmo6iAr8bBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Remove CONFIG_SCHED_DEBUG
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250317104257.3496611-6-mingo@kernel.org>
References: <20250317104257.3496611-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174246119640.14745.12154097959900766458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b52173065e0aad82a31863bb5f63ebe46f7eb657
Gitweb:        https://git.kernel.org/tip/b52173065e0aad82a31863bb5f63ebe46f7eb657
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 11:42:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 22:23:24 +01:00

sched/debug: Remove CONFIG_SCHED_DEBUG

For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
in all the major Linux distributions:

   /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y

The reason is that while originally CONFIG_SCHED_DEBUG started
out as a debugging feature, over the years (decades ...) it has
grown various bits of statistics, instrumentation and
control knobs that are useful for sysadmin and general software
development purposes as well.

But within the kernel we still pretend that there's a choice,
and sometimes code that is seemingly 'debug only' creates overhead
that should be optimized in reality.

So make it all official and make CONFIG_SCHED_DEBUG unconditional.

Now that all uses of CONFIG_SCHED_DEBUG are removed from
the code by previous patches, remove the Kconfig option as well.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250317104257.3496611-6-mingo@kernel.org
---
 lib/Kconfig.debug |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a..a2ab693 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1301,15 +1301,6 @@ endmenu # "Debug lockups and hangs"
 
 menu "Scheduler Debugging"
 
-config SCHED_DEBUG
-	bool "Collect scheduler debugging info"
-	depends on DEBUG_KERNEL && DEBUG_FS
-	default y
-	help
-	  If you say Y here, the /sys/kernel/debug/sched file will be provided
-	  that can help debug the scheduler. The runtime overhead of this
-	  option is minimal.
-
 config SCHED_INFO
 	bool
 	default n

