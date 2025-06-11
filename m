Return-Path: <linux-tip-commits+bounces-5756-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559BAD4F97
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 11:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4943A53CB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Jun 2025 09:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891A2609FD;
	Wed, 11 Jun 2025 09:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T670aH/F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0SOi2mUB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAC325E816;
	Wed, 11 Jun 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633613; cv=none; b=ecxeiVKxIw7Y7Q2FE9Nyz/aO7nIMSF5uiLHyy+l/oFvZnBWkB2TPkZVRNDSab3FarL1jSt/IZ99HUQF10qLrYQuilUKHK3Vas6wLx2x6nVcwbBHauvVvRRJRHoxoxLoEDRxcuShEBJxNMVjiZw8PHZPNglbno7Xr569rylOfgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633613; c=relaxed/simple;
	bh=IZUBoDPDJVn6kZGguxb22ZJQbFB/Don4EW0i9D3f9kM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HqYIXLChISS91g2ZnqdWSBTjS/49wXIkyBthHxgx7INBjVdQ4vFodX4j/B1Jm4+ElEJLnVKQ0yOzE994Z4o9aEM/VgVD1gO7jzSgJ6dI2rJr9Yb2XD8ayywUmgz5O0dFsZFLbuz4v46PDCpoGdY9nd+MmsPBGk16YfaLqfDAhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T670aH/F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0SOi2mUB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Jun 2025 09:20:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749633610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg8VDoiQasilCrJVdWOzVDyqJuvuup/lC46XCCU9ZdI=;
	b=T670aH/FQvWMnRRStBaI7cZH81GrQ6sfgYnel4fgsbrQe+bMu9AmgK/WshqL/pNNdIPMYT
	zBKEVWoC8KOd1pSNLc9aNpUsCh431R3EM3fQgr9KcC3Gyzlvxq4IkpUwJSGvXKFPo5Infj
	Uo4Dh6Eg+/f823QgsunTtY4IOz5JTKHWTcB75Q4fs5p7r1QPHryj5q467pSeYbQRZ0hc7e
	S9AmV1F2lVJgL0HDM8mADV54EMntBIS0hw6tcTG8ptyWib6hf0K7Tsz+kyE+JTqVCm1g7S
	DvkSmyy3XrUO/pWVSkyQZjTjsOKGb72Ab+pRTOkyzy54AZL7ohs5aPvDHpvYng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749633610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg8VDoiQasilCrJVdWOzVDyqJuvuup/lC46XCCU9ZdI=;
	b=0SOi2mUBEafLeinnlfds3OSHnvxcTeNV1CIJBFR9qj1hJ8B096jiyqF9ts+6at2k9bpaUR
	UwmdcEocQEbafoAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/urgent] selftests/futex: getopt() requires int as return value.
Cc: Mark Brown <broonie@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528085521.1938355-2-bigeasy@linutronix.de>
References: <20250528085521.1938355-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174963360947.406.3789042411341487780.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     1a9dcf69c7a97e733aa2fc026db22f22928ca7b7
Gitweb:        https://git.kernel.org/tip/1a9dcf69c7a97e733aa2fc026db22f22928ca7b7
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 May 2025 10:55:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 05 Jun 2025 14:37:58 +02:00

selftests/futex: getopt() requires int as return value.

Mark reported that futex_priv_hash fails on ARM64.
It turns out that the command line parsing does not terminate properly
and ends in the default case assuming an invalid option was passed.

Use an int as the return type for getopt().

Closes: https://lore.kernel.org/all/31869a69-063f-44a3-a079-ba71b2506cce@sirena.org.uk/
Fixes: 3163369407baf ("selftests/futex: Add futex_numa_mpol")
Fixes: cda95faef7bcf ("selftests/futex: Add futex_priv_hash")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250528085521.1938355-2-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 2 +-
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index 20a9d3e..564dbd0 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -144,7 +144,7 @@ int main(int argc, char *argv[])
 	struct futex32_numa *futex_numa;
 	int mem_size, i;
 	void *futex_ptr;
-	char c;
+	int c;
 
 	while ((c = getopt(argc, argv, "chv:")) != -1) {
 		switch (c) {
diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 2dca18f..24a92dc 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -130,7 +130,7 @@ int main(int argc, char *argv[])
 	pthread_mutexattr_t mutex_attr_pi;
 	int use_global_hash = 0;
 	int ret;
-	char c;
+	int c;
 
 	while ((c = getopt(argc, argv, "cghv:")) != -1) {
 		switch (c) {

