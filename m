Return-Path: <linux-tip-commits+bounces-2356-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CC09941DF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A422287E5B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23801E47B2;
	Tue,  8 Oct 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fXqeG095";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSbtIF3n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB081E3DFE;
	Tue,  8 Oct 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374182; cv=none; b=pI4NM6krX7PGWL5ttHPumSmknuWFPAwUKtAA9O5c93GQhBFzrxvpasHUbYGOj2nithJSyLN6FLQwnkdXdbr6fug/skhQA9r+FTmT5l7FMmHFCjDC3MOPY1VqQQa0q/fxZ0nWmulU/J0+zR7P8PDm3cZQbuLpogwE93IfTQs73aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374182; c=relaxed/simple;
	bh=aIajaEl+IF7nFk/y3Ko0qxXmvCZ5hoEDD+uf8rZvuQg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cc/WL2QbhQCel5N6bXBXCfb09X9rgq1zwdsSPA3US5aIyD9MjqZmnSxYSCvuGH9nIA19fcWZo1fxSb75hUAwITnnlzhsJILg/UrVGsA303f1DCdXaEAFTpPAg/ybtlf9Ezh+CkFgigcqmDeQZRB/qZ37cBH8eN6BXXkkOffIT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fXqeG095; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KSbtIF3n; arc=none smtp.client-ip=193.142.43.55
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
	bh=C5enLbY+hmqMP9TpBEBbw3O4WiT7ZupgNv6Px4p4+SY=;
	b=fXqeG095EooUe6bzTQsaonwIE9evL1YH7O8sGeUzMZ+otojQIEKRAzsqZ54XWzVbYrwuCb
	IQrLxZm+B89BHTcVBKSncKGIdjT4YoFBmqyUFzH2n2h/ViTCb/E+MRUkn6iRnV0GLV7IZA
	+Ejdfv+RLOjudGE3mcN8ZPtxmhVDyeiEAV6c29y+KPPtm/T9kD4adgtiobltyjO4Q75GLQ
	ZzLex5Z9AHOglmzQa05KsXWyhT00oaemY+B3kkUx0lSeO5YPgPCoMzhctPDHlG6Irpi+qo
	7vFut3VXRY5gYqcsS+YXvqafpzoXYUXPJNQBZ0FjfZn3JdJ04tDvwq5N6pAuCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374179;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5enLbY+hmqMP9TpBEBbw3O4WiT7ZupgNv6Px4p4+SY=;
	b=KSbtIF3nO/YEnlYbSBO5NHkYNIKHRLiZcrwNdzFsoTc3Hv+M/3YMRwBiFXomk0evLcv6Ge
	SgnHbe+sk4dL+hCQ==
From: "tip-bot2 for Huang Shijie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: fix the comment for PREEMPT_SHORT
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Christoph Lameter (Ampere)" <cl@linux.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241001070456.10939-1-shijie@os.amperecomputing.com>
References: <20241001070456.10939-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837417826.1442.12422643016094212444.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b15148ce21c11373ade7389202c12cabf4eba6cf
Gitweb:        https://git.kernel.org/tip/b15148ce21c11373ade7389202c12cabf4eba6cf
Author:        Huang Shijie <shijie@os.amperecomputing.com>
AuthorDate:    Tue, 01 Oct 2024 15:04:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:41 +02:00

sched/fair: fix the comment for PREEMPT_SHORT

We do not have RESPECT_SLICE, we only have RUN_TO_PARITY.
Change RESPECT_SLICE to RUN_TO_PARITY, makes it more clear.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Link: https://lkml.kernel.org/r/20241001070456.10939-1-shijie@os.amperecomputing.com
---
 kernel/sched/features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7c22b33..a3d331d 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -19,7 +19,7 @@ SCHED_FEAT(PLACE_REL_DEADLINE, true)
  */
 SCHED_FEAT(RUN_TO_PARITY, true)
 /*
- * Allow wakeup of tasks with a shorter slice to cancel RESPECT_SLICE for
+ * Allow wakeup of tasks with a shorter slice to cancel RUN_TO_PARITY for
  * current.
  */
 SCHED_FEAT(PREEMPT_SHORT, true)

