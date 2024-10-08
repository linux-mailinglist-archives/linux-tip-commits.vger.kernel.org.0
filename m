Return-Path: <linux-tip-commits+bounces-2355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9C09941E0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4469FB24707
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3CB1E47AD;
	Tue,  8 Oct 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VYOdQFoB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwZzvvOr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAB31E3797;
	Tue,  8 Oct 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374182; cv=none; b=aVPHXw+tL12FLLMkCmrbCRqcX7OTxbWWS8bbX3vKU8wlA8m/Odwil5MegjFAsRlSr3GpYb2jfqBs9ZY+33FAdAegL3IQ2x0OJ42IbDVdnT07Qsh6Kyb87Y0WGIi4GUdGelnXCV4SNZp87pZ00J7aF33NxDL7WRtbp4Q+Eg6yNco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374182; c=relaxed/simple;
	bh=YifGm0+0zlapQVMfTtlI27xt1Cxm8+XQQHaonFbe6UE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TQXjK+bLLI6iZ2y2LVJf1QHCjuJywQqytdq+Z+fINC31cZC/vwEMK3rt30A5o4qQaf2FEtStXhaYAHFzjrVNHlbokjloWS2k4T4JigxbO/GxpCT3NMuqqF8leYssI9jbWnXEzcNoRuG/B9IBQoyLkCRfZa++4WsLo4mZj3ZV954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VYOdQFoB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwZzvvOr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyc1Nk3Tt9hffOZs2uRLrr5Oot7hY431LH6Ms6oeBHA=;
	b=VYOdQFoB6kp/y419cgRYnkIyF84tW2l1Og61CEAOPTXcCgJpXtZje0v8JSQ00esvrdiS2G
	34Vrq1Ixvx36Oe9zhXibKog3xx4S5bXn7Cgp6yapfuAuly73KnXk2uG7jOVW24OcaGw/1I
	rKtqZNwO92hjdNBViKQTcTpGSfV47U6tDcTufIhhFKn7AThosFnB3/8GHzK1bPOuim+az1
	ZsWqEQ0i+QKczpmhtECAKxkJNxEjLis3Zzt7qQavlxyl3pBzLhS0Q/QA52R4wFKHxKnZFq
	iWh9THAS4NuHtZZB0q5aMgnIRjjM3W+oBBXgllx/p7XhXKpcGUW8+XiH6UZcRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eyc1Nk3Tt9hffOZs2uRLrr5Oot7hY431LH6Ms6oeBHA=;
	b=hwZzvvOrC6I4V4fyZuJuwb9g8MnidoYySzwxYvB5hcfkI7FKBFw4GO9ApaXFnko375W0fE
	2PjenVoUZE4eT1Bw==
From: "tip-bot2 for Huang Shijie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: optimize the PLACE_LAG when se->vlag is zero
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Christoph Lameter (Ampere)" <cl@linux.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001070021.10626-1-shijie@os.amperecomputing.com>
References: <20241001070021.10626-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837417886.1442.7238050482563919227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4423af84b29794a9bd2bd07188d8e71083e54c61
Gitweb:        https://git.kernel.org/tip/4423af84b29794a9bd2bd07188d8e71083e54c61
Author:        Huang Shijie <shijie@os.amperecomputing.com>
AuthorDate:    Tue, 01 Oct 2024 15:00:21 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:41 +02:00

sched/fair: optimize the PLACE_LAG when se->vlag is zero

When PLACE_LAG is enabled, from the relationship:
            vl_i = (W + w_i)*vl'_i / W
we know that if vl'_i(se->vlag) is zero, the vl_i is zero too.

So if se->vlag is zero, there is no need to waste cycles to
do the calculation.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Link: https://lkml.kernel.org/r/20241001070021.10626-1-shijie@os.amperecomputing.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c9e3b8d..5a62121 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5280,7 +5280,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
+	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 

