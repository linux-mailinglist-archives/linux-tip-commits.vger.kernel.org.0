Return-Path: <linux-tip-commits+bounces-4405-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB550A6A1FD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 10:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AFC189E610
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED0B221F2A;
	Thu, 20 Mar 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Keklyo6M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="stEjfJlH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4198221F03;
	Thu, 20 Mar 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461204; cv=none; b=LmiEOqxRXNjxDZSHmFOMe6G3O0SjFUzkverJ2xiforkklqgpFEdZ4Y18nde0saRHU2f5NLF41v/kWQDc2chDSHuoH10HWE6lBlepamcw2iEVYHg8kMN6va1hyTeGQh/MAbYEOqtFf7U8PH6TnCUCVWXD3i+pkfBNRftSGPg0NDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461204; c=relaxed/simple;
	bh=5rUFrlAoHQK8O9NJnZyCqRn3HktwL42bujx9iLvLRUQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eeQFuPavritIurfDgyavfrXRw6madLveG0ASFmC7de5eir8NEJMzXv79ZI4fbSE2gSCN1XjZCeO5MGu3IaoO0gCQfyEUSWo6z0kYk1hNtIc/JNgYSZOcKhbrUdrK15l62hxVZancIm5aLzFw2PQDTodncVGtbBQ0nE2zksNI1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Keklyo6M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=stEjfJlH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 09:00:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742461200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzOFFXDhsF47mrY3GuXtO4pTv9pqF2M9/JA6SfpXFi4=;
	b=Keklyo6MIr4fxaKegQ/iL+rcoIA8E6ri9AaFgZyv+78i6Sephy6VBB1xAYTZtw9xl2Q2po
	YVsglcW4x0EMi74NDkCbW1wZTLKz1j+Npn/2FMpMFQF72HyPZkwbyfzA3EdNhJtrxD4/aR
	9wuvyDyOioH7JJU6dNud1dk/TjhFatZDF1rrfNcgqu2rciKpem44dUMI0+hMEa8BiBRN8r
	/axHt5Dz3WjDH8xHeo831HFcD8HK7TgyUmDoDRldJr8dY8hgrbpx1lo9Xzxh2bBI1reosl
	9GrrwVO2pyYENAg/N5PvQIxYvSWHCdPA6hNtKoXJkWkkrCOXaMgjYDcOfT8KCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742461200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pzOFFXDhsF47mrY3GuXtO4pTv9pqF2M9/JA6SfpXFi4=;
	b=stEjfJlHwjnK3p9IIDnm35q0zIsrM6qI+UwmJcTehEAsb2x9+pwnSJJW67MIg8q8oohzb4
	O+gLnMUafGNk6JBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Remove CONFIG_SCHED_DEBUG from
 self-test config files
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z9szt3MpQmQ56TRd@gmail.com>
References: <Z9szt3MpQmQ56TRd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174246120021.14745.12429331797813150442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     14d281db78b2e5af1bdce793910ce1ea74520d05
Gitweb:        https://git.kernel.org/tip/14d281db78b2e5af1bdce793910ce1ea74520d05
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 22:13:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 22:23:24 +01:00

sched/debug: Remove CONFIG_SCHED_DEBUG from self-test config files

We leave most of the defconfigs alone (there's over 70 of them),
but let's remove CONFIG_SCHED_DEBUG from the scheduler self-test
Kconfig files.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/Z9szt3MpQmQ56TRd@gmail.com
---
 tools/testing/selftests/sched/config                | 2 +-
 tools/testing/selftests/sched_ext/config            | 1 -
 tools/testing/selftests/wireguard/qemu/debug.config | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sched/config b/tools/testing/selftests/sched/config
index e8b09aa..1bb8bf6 100644
--- a/tools/testing/selftests/sched/config
+++ b/tools/testing/selftests/sched/config
@@ -1 +1 @@
-CONFIG_SCHED_DEBUG=y
+# empty
diff --git a/tools/testing/selftests/sched_ext/config b/tools/testing/selftests/sched_ext/config
index 0de9b4e..aa901b0 100644
--- a/tools/testing/selftests/sched_ext/config
+++ b/tools/testing/selftests/sched_ext/config
@@ -1,4 +1,3 @@
-CONFIG_SCHED_DEBUG=y
 CONFIG_SCHED_CLASS_EXT=y
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_SCHED=y
diff --git a/tools/testing/selftests/wireguard/qemu/debug.config b/tools/testing/selftests/wireguard/qemu/debug.config
index 139fd9a..c305d2f 100644
--- a/tools/testing/selftests/wireguard/qemu/debug.config
+++ b/tools/testing/selftests/wireguard/qemu/debug.config
@@ -27,7 +27,6 @@ CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_WQ_WATCHDOG=y
-CONFIG_SCHED_DEBUG=y
 CONFIG_SCHED_INFO=y
 CONFIG_SCHEDSTATS=y
 CONFIG_SCHED_STACK_END_CHECK=y

