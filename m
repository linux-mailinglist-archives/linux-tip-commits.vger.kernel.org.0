Return-Path: <linux-tip-commits+bounces-5817-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B50AAD84A6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE2D7B0DBE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAB926B779;
	Fri, 13 Jun 2025 07:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U41+CuFL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8VpRbv6r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8F1A01B9;
	Fri, 13 Jun 2025 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800263; cv=none; b=i98FDcnJZVEoAMB2XTGZPhBJuzOoDWIDp24zd+w7q/Gq+s6QsfaRB7cLQEBNDsxNcB4FHD6h4As6jr1qmVpm2AB40U1HHBl34pAWqJkxKVPXMAOa7uqYWXhN5UG77G/8VlY/pQ1+k7e52hLBCYEsmmhQpwG9YRsokplaFWMoSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800263; c=relaxed/simple;
	bh=1CGfO/6gdA3uL+9NwZDa1fxrQnlneqYdzyG3Ha0E5+o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lTuwB8jwDoAXUSgS/sp0iCNhCYRZGGjbpP9y0kPdP2auSFzDgVT4t+GbgeB92+BhN/46SG57uElMfmP30E5zUTA9xBElvZKjpMiPG0qP4cgydcsLEgF92w3WsE/GkHhJgeqHOFtKEw+BZjMRjKQvmkCbUqVUa2D7+SN9BGeRYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U41+CuFL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8VpRbv6r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziwRrunBKYZ0QY+rtmihe7qN/Cxza3xQdd2VhMcmumk=;
	b=U41+CuFLMLceAT7RV4OIN6kUwql/AtrZe4fuzeci0J2CvO/783eTCRGXsaVpSauDNevfgP
	khavbbtqbF6Y0XusFENWCRtQWRegjqM9EsLD/6JE4PZi4EowSD1ZfakQg5WKJTZn2ScKVw
	MbJMy8HpnmljADNzblBhPvt5dWDGenLNiMmabdrcZThJ30xAqpKTiudh2rpHAHWbngilyl
	6wJXuGrVzmk7PynnZi+tfJmQQ5Es3Dpg7W0sEhZbujDY9t/UGtdcZ+nEaA2EfP2hxuPqZW
	Az4lG9RTRLH1hwzZmiIZmQvMbb9kXhoipS3Cbvab1kJaq5KX0dw5FHl47XOY+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziwRrunBKYZ0QY+rtmihe7qN/Cxza3xQdd2VhMcmumk=;
	b=8VpRbv6rw0ZQvVu8ZpW5crObA9xxOvjbk74YEPK2Fk85xpLAqvMsOTEG9bvBOYSPMs0SU8
	QSW60G79SYr0qgBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Clean up and standardize #if/#else/#endif
 markers in sched/cpupri.h
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-6-mingo@kernel.org>
References: <20250528080924.2273858-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980025813.406.13959988197065884589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     79af17344c2728c58e254219ff47840c67211cd9
Gitweb:        https://git.kernel.org/tip/79af17344c2728c58e254219ff47840c67211cd9
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:08:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:15 +02:00

sched: Clean up and standardize #if/#else/#endif markers in sched/cpupri.h

 - Use the standard #ifdef marker format for larger blocks,
   where appropriate:

        #if CONFIG_FOO
        ...
        #else /* !CONFIG_FOO: */
        ...
        #endif /* !CONFIG_FOO */

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
Link: https://lore.kernel.org/r/20250528080924.2273858-6-mingo@kernel.org
---
 kernel/sched/cpupri.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpupri.h b/kernel/sched/cpupri.h
index f0f5a73..24add19 100644
--- a/kernel/sched/cpupri.h
+++ b/kernel/sched/cpupri.h
@@ -29,4 +29,4 @@ int  cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 void cpupri_set(struct cpupri *cp, int cpu, int pri);
 int  cpupri_init(struct cpupri *cp);
 void cpupri_cleanup(struct cpupri *cp);
-#endif
+#endif /* CONFIG_SMP */

