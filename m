Return-Path: <linux-tip-commits+bounces-2576-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2937D9B0C66
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C301C2100C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8C3170A31;
	Fri, 25 Oct 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lryZ6v3e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6NSjD2+1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C74320B;
	Fri, 25 Oct 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879275; cv=none; b=YMqz416cRsoKc1XUVHRrLg8NGdidb1rp1mIiPqGtc/ZD9BmqM6VBCTYJW0TyCnwP9Y3Ju1e3KlGmvRBFpGX4+lxXucpcPoRqKXtcEC/oaiZkwm2h5ZEU5gf0mEhn9Lw0hAybEcWhkEi7ACLwYVdRBcdmvkEgX1eNjbZHVNfaSzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879275; c=relaxed/simple;
	bh=fK1DVEG6PSFMqF8+7zk/KKDwS3g76F7M0pP6fnp+hnE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t2jSrbdWcl7m6C4mUe6Mbz4iSMUGdaFUrxXJqPaF4bVGjRUDTKY6D2S8/avYyire/HYfbmWu3cwhdL4cmUsdZuxsg9b9B/YCJir2d+fPVia2pEPnbFJP+gBnkl3/uLrKU8R5A88uUlRDWAzPivTC4I7LcMKpqVYNwEsRBl0sQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lryZ6v3e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6NSjD2+1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 18:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729879272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3Jjn6FMuEIuBhDGYGuxGV5AnzMrsM93Vp+CWuKprmg=;
	b=lryZ6v3ei9FWLheb7nyq/Q7fVgL01KfA/VSlqbvUAFf6w5MFwWs2BCYchpeQHTw5wRFGdb
	SZ+aKi5ziLVYfJOVS49Rsqgbk79r+/EQIJrRgUBiDNtnB6GdkZiVCpEJDUhWbKMGMnBv/m
	QyJql1LaM3B/CnA96YorRrfsJJ5EwXchKbT/E24+iOWdFAepnSV+hh9/keA9yNYrW0jcW0
	aLF+fWadE5knm0rQ4xFRRyzyCnSQjwIurdmf77LRqtkjNbutHEkPPVDNcuo4k6uGVgTBqX
	T41a9aSTUACHmZT7PUA9Oh0legVvU4CKo1WzF48f5awVJme1vN7mAt6Yam3oGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729879272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3Jjn6FMuEIuBhDGYGuxGV5AnzMrsM93Vp+CWuKprmg=;
	b=6NSjD2+1CLfD/sx7a52nNX+vOH11oWepPV79rcb6JSLlUO8WJpXIKpx+FpQ3cAmvA55s1O
	rAgpLI92N6ZpIUBw==
From: "tip-bot2 for Miguel Ojeda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Partially revert cleanup on
 msecs_to_jiffies() documentation
Cc: Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241025110141.157205-1-ojeda@kernel.org>
References: <20241025110141.157205-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987927056.1442.11808363751945205440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b05aefc1f5886c8aece650c9c1639c87b976191a
Gitweb:        https://git.kernel.org/tip/b05aefc1f5886c8aece650c9c1639c87b976191a
Author:        Miguel Ojeda <ojeda@kernel.org>
AuthorDate:    Fri, 25 Oct 2024 13:01:40 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 25 Oct 2024 19:49:16 +02:00

time: Partially revert cleanup on msecs_to_jiffies() documentation

The documentation's intention is to compare msecs_to_jiffies() (first
sentence) with __msecs_to_jiffies() (second sentence), which is what the
original documentation did. One of the cleanups in commit f3cb80804b82
("time: Fix various kernel-doc problems") may have thought the paragraph
was talking about the latter since that is what it is being documented.

Thus revert that part of the change.

Fixes: f3cb80804b82 ("time: Fix various kernel-doc problems")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241025110141.157205-1-ojeda@kernel.org

---
 kernel/time/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 5984d4a..b1809a1 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -558,7 +558,7 @@ EXPORT_SYMBOL(ns_to_timespec64);
  *   handling any 32-bit overflows.
  *   for the details see __msecs_to_jiffies()
  *
- * __msecs_to_jiffies() checks for the passed in value being a constant
+ * msecs_to_jiffies() checks for the passed in value being a constant
  * via __builtin_constant_p() allowing gcc to eliminate most of the
  * code, __msecs_to_jiffies() is called if the value passed does not
  * allow constant folding and the actual conversion must be done at

