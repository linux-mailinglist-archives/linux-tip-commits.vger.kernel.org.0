Return-Path: <linux-tip-commits+bounces-3312-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F12A259C5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 13:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80CF16494C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Feb 2025 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788CE205515;
	Mon,  3 Feb 2025 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2kvmTlOz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0dMlU4rB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D9D204F8C;
	Mon,  3 Feb 2025 12:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738586905; cv=none; b=dj9KFaAKzQ7T1kRO6tIOoIyNPFtq2z5tv3sUr5Ed76SkS0/3DVavTkqzTkG2CmE/3sY/e6UlvhZgxUqcLFVkxHC8WwRir9OD1+Lzi03mPQFzvl7WuERSbkDTK1w7jvrMOta7v553uBps6k6xOgqRvN1MWXUmXmFjo4qXhYuOzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738586905; c=relaxed/simple;
	bh=SqBPxJkrb6ETKFTLXVZHFq1UJXDq0NCO+5xLFDQMzE0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ACRNb3AfsMaHT30lQ9y4VQB4fKnNxiB59IZigPZo54+7elA0HR45EPssgjWDCF2rK8JuWzZyGLIEamb7EBiHNGZItDf85yBCndpeUJRBTfTtxAXr9jwo2Te4DiloVBC/v+BQA0YovuPqCTL0VsdJAehhaHmY+A2cfWLrmW5Hi2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2kvmTlOz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0dMlU4rB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Feb 2025 12:48:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738586901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygulU40BbxrTKuhnwVZ0yk1ptKVvi8uMsUam4ORMcdQ=;
	b=2kvmTlOzOOCEIMlh0Ap6V+SmKlFdL70pMxXko5bq+W6fW6jHfmyQh+HgQEBSHhw4csZrAD
	p0JDAHxBDqZ+RVcj+wssrAMldtShwuXou6Qklb2kP9qJVXSsm5XHbhFfOqLds9jwV0HsMJ
	i4wdGt1XQqbTg4A/pGhyvx+4p0Q6Ns59X2SBnarceByqj55pES2oB2rUC11wyy2iMA8Gqv
	wFfiTglEpLuzgzD2JFu4Xv9XhannKmInsYtw4Y+8pPvKMFl51lhsu0R22vyskaH0jMgU7O
	F62eApz8sxs+mwrwpLX6jqxoHqaFan7h87acyGr98YtKe8AihsWjWQLR5Idoaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738586901;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygulU40BbxrTKuhnwVZ0yk1ptKVvi8uMsUam4ORMcdQ=;
	b=0dMlU4rBpyge+jq0gsIzCGRxD0I10BKFQxdQbQPqC5MmN2FqngtYsdBWVX3D9UWXmZBngJ
	R/+4JcslNQf5qiDw==
From: "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Remove pointless sample period check
Cc: Ravi Bangoria <ravi.bangoria@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250115054438.1021-3-ravi.bangoria@amd.com>
References: <20250115054438.1021-3-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173858690058.10177.11171001068661803463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     88c7bcad71c83f52f24108dedcecae0d18dbc627
Gitweb:        https://git.kernel.org/tip/88c7bcad71c83f52f24108dedcecae0d18dbc627
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Wed, 15 Jan 2025 05:44:31 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Feb 2025 11:46:04 +01:00

perf/amd/ibs: Remove pointless sample period check

Valid perf event sample period value for IBS PMUs (Fetch and Op both)
is limited to multiple of 0x10. perf_ibs_init() has this check:

  if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
          return -EINVAL;

But it's broken since hwc->sample_period will always be 0 when
event->attr.sample_freq is 0 (irrespective of event->attr.freq value.)

One option to fix this is to change the condition:

  - if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
  + if (!event->attr.freq && hwc->sample_period & 0x0f)

However, that will break all userspace tools which have been using IBS
event with sample_period not multiple of 0x10.

Another option is to remove the condition altogether and mask lower
nibble _silently_, same as what current code is inadvertently doing.
I'm preferring this approach as it keeps the existing behavior.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20250115054438.1021-3-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 4ca8006..bd8919e 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -307,13 +307,8 @@ static int perf_ibs_init(struct perf_event *event)
 		if (config & perf_ibs->cnt_mask)
 			/* raw max_cnt may not be set */
 			return -EINVAL;
-		if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
-			/*
-			 * lower 4 bits can not be set in ibs max cnt,
-			 * but allowing it in case we adjust the
-			 * sample period to set a frequency.
-			 */
-			return -EINVAL;
+
+		/* Silently mask off lower nibble. IBS hw mandates it. */
 		hwc->sample_period &= ~0x0FULL;
 		if (!hwc->sample_period)
 			hwc->sample_period = 0x10;

