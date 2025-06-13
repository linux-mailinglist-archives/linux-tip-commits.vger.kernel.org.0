Return-Path: <linux-tip-commits+bounces-5782-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF0DAD8452
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1B6189C3F1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094732E1747;
	Fri, 13 Jun 2025 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bR5TbJ/B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hz9S4b3Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BF82D1F44;
	Fri, 13 Jun 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800230; cv=none; b=rzPJ79FPKqJDD3EOPZ9Q+2IobhVEswIVDg2hrQHGId8NB0u/TnP0YfVRGoChNw1kvLqfnUju/GcRgvMlLePugUwqC+b3Q05yMR5J6WQb5B0kg2ogiqHog/+Hlgucc8entne4fxbXGsE9qYfpdah7YGCWWXdPcEHP8HT0oAIyv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800230; c=relaxed/simple;
	bh=hGrZvh9RuiyPYPdJjerGvo4sum7cMpywOemggSKHfFk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PTL0l4xDLlUaGRhfrqJFC5LIudvuik/LqvDDK7pMJPxc0HHmE8nC8b9ggQDuZ+jg6a8n3XrWpReAbOC7WZyCF/JLIuz3tt8UTue3nFPr44MVeAGedEPloh9wIs1yQi6XpdWP4H6gq2AQmCnH0vSc6gkP3mFOJP3xRTFLq0LSiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bR5TbJ/B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hz9S4b3Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvV1FImmOcvOtduKTHkf2YGU7f8nxeETpwgM9REFggo=;
	b=bR5TbJ/Beent2FA/dFJwm+KZCUj3keWlEiYWFuy15RV+n/GQJCg/16TrKZfJLmq8PJG6nB
	hFe5P2QuUzVaFNOfFLkj7Bz1+S9BzrkR7zQk2I8rK7QfhFVIAhdSxxrDlht1DcW3GfFePv
	0GSv52ZpDBdQsENsthgtpFcXWuKxZdyag2JJDtpIvZ+BWDL3eYpq0ISFrlG8rTTxj4vSAM
	Spd0WkUs9c7fVrybEZXmCK9B4GkzZhZpHvZx0mFKMSR9ip8oGTiimLjT9iMQKQlnF/1YCf
	b9Hy2c32qAFVFKS8RdZlZ2Eg889gWKKFUOEXsHhS1J9K9i7S8iVKZcaUu7qb1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvV1FImmOcvOtduKTHkf2YGU7f8nxeETpwgM9REFggo=;
	b=Hz9S4b3Qo84bJajwPERhCy24W8St2C1ETRm24WnawpJXetA7SY1qUIUajWOfDZ2zPix3dD
	736C/DUnrIuyXeCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of ENQUEUE_MIGRATED
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-42-mingo@kernel.org>
References: <20250528080924.2273858-42-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980022643.406.3953419660007682672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     241c307b05b00478bbb65bf440ece464aeac9208
Gitweb:        https://git.kernel.org/tip/241c307b05b00478bbb65bf440ece464aeac9208
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:23 +02:00

sched/smp: Use the SMP version of ENQUEUE_MIGRATED

Simplify the scheduler by making the CONFIG_SMP-only ENQUEUE_MIGRATED
flag unconditional.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-42-mingo@kernel.org
---
 kernel/sched/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d8c78ee..45245f4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2319,11 +2319,7 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define ENQUEUE_HEAD		0x10
 #define ENQUEUE_REPLENISH	0x20
-#ifdef CONFIG_SMP
 #define ENQUEUE_MIGRATED	0x40
-#else
-#define ENQUEUE_MIGRATED	0x00
-#endif
 #define ENQUEUE_INITIAL		0x80
 #define ENQUEUE_MIGRATING	0x100
 #define ENQUEUE_DELAYED		0x200

